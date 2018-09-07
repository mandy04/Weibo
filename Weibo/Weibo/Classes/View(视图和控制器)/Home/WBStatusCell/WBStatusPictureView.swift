//
//  WBStatusPictureView.swift
//  Weibo
//
//  Created by Smile on 2018/9/7.
//  Copyright © 2018年 llbt. All rights reserved.
//

import UIKit

class WBStatusPictureView: UIView {

//配图数据的数组
    var urls : [WBStatusPicture]? {
        didSet {
            //1. 隐藏图像
            for v in subviews {
                v.isHidden = true
            }
            //2. 遍历url数组，顺序设置图像
            var index = 0
            for url in urls ?? [] {
                //1> 获得对应索引的ImageView
                let iv = subviews[index] as! UIImageView
                //判断4张图像
                if index == 1 && urls?.count == 4 {
                    index += 1
                }
                //2> 设置图像
                iv.cz_setImage(urlString: url.thumbnail_pic, placeholderImage: nil)
                //3> 显示图像
                iv.isHidden = false
                
                index += 1
            }
        }
    }
    @IBOutlet weak var heightCons: NSLayoutConstraint!

    override func awakeFromNib() {
        seupUI()
    }
}

// MARK: - 设置界面
extension WBStatusPictureView {
    
   // 1. cell中所有的控件都是提前准备好
   // 2. 设置的时候根据数据决定是否显示
   // 3. 不要动态创建控件
   private func seupUI() {
    //设置背景图像
    backgroundColor = superview?.backgroundColor
    //超出边界的内容不显示
    clipsToBounds = true
        let count  = 3
        let rect = CGRect(x: 0,
                          y: WBStatusPictureViewOutterMargin,
                          width: WBStatusPictureItemWidth,
                          height: WBStatusPictureItemWidth)
        //循环创建9个imageView
        for i in 0..<count * count{
            
            let iv = UIImageView()
            //设置contentMode
            iv.contentMode = .scaleAspectFill
            iv.clipsToBounds = true
            
            //行
            let row = CGFloat(i / count)
            //列
            let col = CGFloat(i % count)
            
            let xOffset = col * (WBStatusPictureItemWidth + WBStatusPictureViewInnerMargin)
            
            let yOffset = row * (WBStatusPictureItemWidth + WBStatusPictureViewInnerMargin)
            
            iv.frame = rect.offsetBy(dx: xOffset, dy: yOffset)
            
            addSubview(iv)
        }
    }
}
