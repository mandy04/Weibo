//
//  WBStatusViewModel.swift
//  Weibo
//
//  Created by Smile on 2018/9/3.
//  Copyright © 2018年 llbt. All rights reserved.
//

import Foundation



/// 若没有父类，如果希望在开发时调试，输出调试信息，需要：
/* 1. 继承CustomStringConvertible
   2. 实现description
 
 关于表格的性能优化:
 - 尽量少计算， 所有需要的素材提前计算好!
 - 控件上不要设置圆角半径，所有图像渲染的属性，都要注意!
 - 不要动态创建控件，所有需要的控件，都要提前创建好，在显示的时候，根据数据隐藏和显示！
 - Cell 中控件的层次越少越好，数量越少越好!
 - 要测量，不要猜测!
 */
class WBStatusViewModel : CustomStringConvertible{
    
    //微博模型
    var status : WBStatus?
    
    //会员图标 -存储型属性（用内存换CPU）
    var memberIcon : UIImage?
    
    //认证类型 -1：没有认证；0：认证用户；2，3，5：企业认证；220：
    var vipIcon : UIImage?
    
    //转发
    var retweetStr: String?
    //评论
    var commentStr: String?
    //赞
    var likeStr: String?
    /// 配图视图大小
    var pictureViewSize = CGSize()
    
    //---如果是被转发原创微博，原创微博一定没有图
    var picURLs : [WBStatusPicture] {
        //如果有被转发的原创微博，返回被转发原创微博配图
        //如果无被转发的原创微博，返回原创微博配图
        //如果都无，返回nil
        guard let pic_urls = status?.retweeted_status?.pic_urls else {
            guard let pic_urls1 = status?.pic_urls else {
                return []
            }
            return pic_urls1
        }
        
        return pic_urls
    }
    
    //设置被转发微博的文字
    var  retweetedText : String?
    
    //设置行高
    var rowHeight: CGFloat = 0
    
    /// 微博模型
    /// - 构造函数
    /// - Parameter model: 微博视图模型
    init(model: WBStatus) {
        self.status = model
        
        //直接计算出会员图标/会员等级 0-6
        if (model.user?.mbrank)! > 0 && (model.user?.mbrank)! < 7 {
            let imageName = "common_icon_membership_level\(model.user?.mbrank ?? 1)"
            memberIcon = UIImage(named: imageName)
        }
        //认证类型
        switch model.user?.verified_type ?? -1 {
        case 0:
            vipIcon = UIImage(named: "avatar_vip")
        case 2,3,5:
            vipIcon = UIImage(named: "avatar_grassroot")
        case 220:
            vipIcon = UIImage(named: "avatar_enterprise_vip")
        default:
            break
        }
        //设置底部计数字符串
        //测试超过10000
//        model.reposts_count = Int(arc4random_uniform(100000))
        retweetStr = countString(count: model.reposts_count, defaultStr: "转发")
        commentStr = countString(count: model.comments_count, defaultStr: "评论")
        likeStr = countString(count: model.attitudes_count, defaultStr: "赞")
        
        ///计算配图视图大小(有原创的就计算原创的，有转发的就计算转发的)
        pictureViewSize = calPictureViewSize(count: picURLs.count)
        //被转发微博文字
        let temp = "@" +  (status?.retweeted_status?.user?.screen_name ?? "")  + ":"
        retweetedText =  temp + (status?.retweeted_status?.text ?? "")
        //计算行高
        updateRowHeight()
    }
    
    var description: String {
        return status!.description
    }
    
    //根据当前的视图模型内容计算行高
    func updateRowHeight() {
        //原创微博：顶部分割视图(12) + 间隔(12) + 图像的高度(34) + 间距(12) + 正文高度(需要计算) + 配图视图高度(计算) + 间距(12) + 底部视图高度（35）
        //被转发微博：顶部分割视图(12) + 间隔(12) + 图像的高度(34) + 间距(12) + 正文高度(需要计算) + 间距(12) + 间距(12) + 转发文本高度（需要计算）+ 配图视图高度（计算） + 间距（12） + 底部视图高度（35）
        let margin: CGFloat = 12
        let iconHeight: CGFloat = 34
        let toolBarHeight: CGFloat = 35
        
        var height: CGFloat = 0
        
        let viewSize = CGSize(width: UIScreen.cz_screenWidth() - 2 * margin, height: CGFloat(MAXFLOAT))
        let originalFont = UIFont.systemFont(ofSize: 15)
        let retweetedFont = UIFont.systemFont(ofSize: 14)
        
        //1. 计算顶部位置
        height = 2 * margin + iconHeight + margin
        
        //2. 正文高度
        /**1> 预期尺寸，宽度固定，高度尽量大；
           2> 选项，换行文本，统一使用usesLineFragmentOrigin
         * 3> attributes :指定字体字典 NSAttributedStringKey.font
         */
        if let text = status?.text {
            height += (text as NSString).boundingRect(with: viewSize,
                                                      options: NSStringDrawingOptions.usesLineFragmentOrigin,
                                                      attributes: [NSAttributedStringKey.font : originalFont],
                                                      context: nil).height
        }
        //3. 被转发微博
        if status?.retweeted_status != nil {
            height += 2 * margin
            //转发文本的高度，一定要用 retweetedText，拼接了 @用户名：微博文字
            if let text = retweetedText {
                height += (text as NSString).boundingRect(with: viewSize,
                                                          options: NSStringDrawingOptions.usesLineFragmentOrigin,
                                                          attributes: [NSAttributedStringKey.font : retweetedFont],
                                                          context: nil).height
            }
        }
        //4. 配图视图
        height += pictureViewSize.height
        
        height += margin
        
        //5. 底部工具栏
        height += toolBarHeight
        
        //6. 使用属性记录
        rowHeight = height
    }
    
    /// 使用单个图像，更新单张图像的大小
    ///
    /// - Parameter image: 网络缓存的单张图像
    func updateSingleImage(image:UIImage) {
        
        var size = image.size
        //注意：尺寸需要增加顶部的12个点，便与布局
        size.height += WBStatusPictureViewOutterMargin
        //重新设置配图视图大小
        pictureViewSize = size
        //更新行高
        updateRowHeight()
    }
    
    /// 计算指定数量的图片对应配图视图的大小
    ///
    /// - Parameter count: 图片个数
    /// - Returns: 返回配图视图尺寸
    func calPictureViewSize(count: Int?) -> CGSize {
        
        if count == 0 || count == nil{
            return CGSize()
        }

        //1. 计算配图视图的高度
        //1> 根据count知道行数
        /**  1  2  3     0  1  2    0+1
          *  4  5  6     3  4  5    1+1
          *  7  8  9     6  7  8    2+1
          */
        let row = (count! - 1) / 3 + 1
        //2> 根据行数算高度
//        let WBStatusPictureItemHeight = WBStatusPictureViewOutterMargin + CGFloat(row) * WBStatusPictureItemWidth + CGFloat(row - 1)*WBStatusPictureViewInnerMargin
        var height = WBStatusPictureViewOutterMargin
        height += CGFloat(row) * WBStatusPictureItemWidth
        height += CGFloat(row - 1)*WBStatusPictureViewInnerMargin
        
        return CGSize(width: WBStatusPictureItemWidth, height: height)
    }
    
    /// 给定义一个数字，返回描述结果
    ///
    /// - Parameters:
    ///   - count: 数字
    ///   - defaultStr: 默认字符串 转发/评论/赞
    /// - Returns: 返回描述结果
    /*count =0 ,显示默认标题
    * count < 10000,显示数字
    * count > 10000,显示x.xx万
    */
    @objc private func countString(count: Int, defaultStr: String)->String {
        if count == 0 {
            return defaultStr
        }
        if count < 10000 {
            return count.description
        }
        return String.init(format: "%.02f 万", Double(count) / 10000)
    }
}
