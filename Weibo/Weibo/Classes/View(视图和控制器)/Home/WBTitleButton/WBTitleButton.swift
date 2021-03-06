//
//  WBTitleButton.swift
//  Weibo
//
//  Created by Smile on 2018/8/25.
//  Copyright © 2018年 llbt. All rights reserved.
//

import UIKit

class WBTitleButton: UIButton {
    
    //重载构造函数
    init(title: String?) {
        super.init(frame:CGRect())
        
        //1. 判断title是否为nil，如果为nil，显示首页；不为nil，显示title和头像
        if title == nil {
            setTitle("首页", for: [])
        }else {
            setTitle(title! + "", for: [])
            
            //设置图像
            setImage(UIImage.init(named: "navigationbar_arrow_down"), for: [])
            setImage(UIImage.init(named: "navigationbar_arrow_up"), for: .selected)
        }
        
        //2. 设置字体和颜色
        titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        setTitleColor(UIColor.darkGray, for: [])
        
        //3. 设置大小
        sizeToFit()
}
    
    ///重新布局子视图
    override func layoutSubviews() {
        super.layoutSubviews()
        
        //判断titleLabel 和imageView 是否同时存在
        guard let titleLabel = titleLabel,
              let imageView = imageView else {
            return
        }
        if imageView.frame.origin.x != 0 {
            // 已调整过，不用再调整布局
            return;
        }
        
        print("\(titleLabel) \(imageView)")
        print("调整按钮布局")
        //将label的x向左移动imageView的宽度
        titleLabel.frame = titleLabel.frame.offsetBy(dx: -imageView.bounds.width, dy: 0)
        //将iamgeview的x向右移动titleLabel的宽度
        imageView.frame = imageView.frame.offsetBy(dx: titleLabel.bounds.width, dy: 0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
