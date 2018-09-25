//
//  WBStatusCell.swift
//  Weibo
//
//  Created by Smile on 2018/9/1.
//  Copyright © 2018年 llbt. All rights reserved.
//

import UIKit

class WBStatusCell: UITableViewCell {
    
    /// 微博视图模型
    var viewModel : WBStatusViewModel? {
        didSet {
            //微博正文
            statusLabel.text = viewModel?.status?.text
            //姓名
            nameLabel.text = viewModel?.status?.user?.screen_name
            
            //设置会员图标,直接获取属性，不需要计算
            memberIconView.image = viewModel?.memberIcon
            
            //认证图标
            vipIconView.image = viewModel?.vipIcon
            
            //用户头像
            iconView.cz_setImage(urlString: viewModel?.status?.user?.profile_image_url, placeholderImage:UIImage(named: "avatar_default_big")! ,isAvatar: true)
            //底部导航
            toolBar.viewModel = viewModel
            //配图视图模型
            pictureView.viewModel = viewModel
            
//            //设置配图（被转发和原创）
//            pictureView.urls = viewModel?.picURLs
            
            //设置被转发微博文字
            retweetedTextLabel?.text = viewModel?.retweetedText
            
            //测试4张图片
//            if viewModel?.status?.pic_urls?.count ?? 0 > 4 {
//                // 修改数组 -> 将末尾的数据全部删除
//                var picURLs = viewModel?.status?.pic_urls ?? []
//                picURLs.removeSubrange(((picURLs.startIndex) + 4)..<(picURLs.endIndex))
//                pictureView.urls = picURLs
//            }else{
//                pictureView.urls = viewModel?.status?.pic_urls
//            }
        }
    }
    
    /// 头像
    @IBOutlet weak var iconView: UIImageView!
    /// 姓名
    @IBOutlet weak var nameLabel: UILabel!
    /// 会员图标
    @IBOutlet weak var memberIconView: UIImageView!
    /// 时间
    @IBOutlet weak var timeLabel: UILabel!
    /// 来源
    @IBOutlet weak var sourceLabel: UILabel!
    /// 认证图标
    @IBOutlet weak var vipIconView: UIImageView!
    /// 微博正文
    @IBOutlet weak var statusLabel: UILabel!
    /// 底部工具栏
    @IBOutlet weak var toolBar: WBStatusToolBar!
    /// 配图视图
    @IBOutlet weak var pictureView: WBStatusPictureView!
    
    //被转发微博文字
    @IBOutlet weak var retweetedTextLabel: UILabel?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //离屏渲染 --异步绘制  如果检测到cell性能已经很好，就无需离屏渲染（CPU和GPU之间的切换），否则需要付出代价
        self.layer.drawsAsynchronously = true
        
        //栅格化 - 异步绘制之后会生成一张独立的图像，cell在屏幕上滚动的时候，本质上滚动的是这张图像
        //cell优化，要尽量减少图层的数量，相当于就只有一层！
        //停止滚动之后，可以接收监听
        self.layer.shouldRasterize = true
        
        //使用‘栅格化’必须制定分辨率
        self.layer.rasterizationScale = UIScreen.main.scale
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
