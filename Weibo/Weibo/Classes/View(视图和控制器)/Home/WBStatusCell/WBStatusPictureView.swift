//
//  WBStatusPictureView.swift
//  Weibo
//
//  Created by Smile on 2018/9/7.
//  Copyright © 2018年 llbt. All rights reserved.
//

import UIKit

class WBStatusPictureView: UIView {


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
    
        let count  = 3
        let rect = CGRect(x: WBStatusPictureViewOutterMargin,
                          y: WBStatusPictureViewOutterMargin,
                          width: WBStatusPictureItemWidth,
                          height: WBStatusPictureItemWidth)
        //循环创建9个imageView
        for i in 0..<count * count{
            
            let iv = UIImageView()
            
            iv.backgroundColor = UIColor.red
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
