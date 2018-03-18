//
//  WBVisitorView.swift
//  Weibo
//
//  Created by Smile on 2018/3/14.
//  Copyright © 2018年 llbt. All rights reserved.
//

import UIKit

class WBVisitorView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - 私有控件  懒加载属性只有调用 UIKit 控件的指定构造函数，其他都需要使用类型
    ///icon 图标
    private lazy var iconImage:UIImageView = UIImageView.init(image: UIImage.init(named: "visitordiscover_feed_image_smallicon"))
    //遮罩
    private lazy var maskImage: UIView = UIImageView.init(image: UIImage.init(named: "visitordiscover_feed_mask_smallicon"))
    ///hourseICon 小房子
    private lazy var houseIconImage:UIImageView = UIImageView.init(image: UIImage.init(named: "visitordiscover_feed_image_house"))
    ///tipLabel 提示标签
    private lazy var tipLabel:UILabel = UILabel.cz_label(withText: "关注一些人，回这里看看有什么惊喜关注一些人，回这里看看有什么惊喜", fontSize: 14, color: UIColor.darkGray)
    ///注册
    private lazy var registerButton:UIButton = UIButton.cz_textButton("注册",
                                                                      fontSize: 14,
                                                                      normalColor: UIColor.orange,
                                                                      highlightedColor: UIColor.black, backgroundImageName: "common_button_white_disable")
    ///登录
    private lazy var loginButton:UIButton = UIButton.cz_textButton("登录",
                                                                      fontSize: 14,
                                                                      normalColor: UIColor.darkGray,
                                                                      highlightedColor: UIColor.black, backgroundImageName: "common_button_white_disable")
    
    
}

//MARK: 设置界面
extension WBVisitorView {
    func setupUI() {
        //如果可以使用颜色，就不要使用图片，颜色效率高
        backgroundColor = UIColor.cz_color(withHex: 0xEDEDED)
        //1. 添加视图
        addSubview(iconImage)
        addSubview(maskImage)
        addSubview(houseIconImage)
        addSubview(tipLabel)
        addSubview(registerButton)
        addSubview(loginButton)
        
        //2. 使用原生autolayout， 不可与autoreresize同时存在
        for v in subviews {
            v.translatesAutoresizingMaskIntoConstraints = false
        }
        
        //3. 自动布局 "view1.attr1 = view2.attr2 * multiplier + constant"
        /*
         *addConstraints([NSLayoutConstraint.init(item: 视图,
         attribute: 约束属性,
         relatedBy: 约束关系,
         toItem: 参照视图,
         attribute: 参照属性,
         multiplier: 乘积,
         constant: 约束数值)])
         */
        //参照视图为nil，属性为.NSLayoutAttribute.notAnAttribute
        let margin : CGFloat = 20.0
        //图标
        addConstraint(NSLayoutConstraint.init(item: iconImage,
                                                attribute: .centerX,
                                                relatedBy: .equal,
                                                toItem: self,
                                                attribute: .centerX,
                                                multiplier: 1.0,
                                                constant: 0))
        addConstraint(NSLayoutConstraint.init(item: iconImage,
                                                attribute: .centerY,
                                                relatedBy: .equal,
                                                toItem: self,
                                                attribute: .centerY,
                                                multiplier: 1.0,
                                                constant: 0))
        
        //小房子
        addConstraint(NSLayoutConstraint.init(item: houseIconImage,
                                                attribute: .centerX,
                                                relatedBy: .equal,
                                                toItem: iconImage,
                                                attribute: .centerX,
                                                multiplier: 1.0,
                                                constant: 0))
        addConstraint(NSLayoutConstraint.init(item: houseIconImage,
                                                attribute: .centerY,
                                                relatedBy: .equal,
                                                toItem: iconImage,
                                                attribute: .centerY,
                                                multiplier: 1.0,
                                                constant: 0))
        //提示标题
        addConstraint(NSLayoutConstraint.init(item: tipLabel,
                                                attribute: .centerX,
                                                relatedBy: .equal,
                                                toItem: iconImage,
                                                attribute: .centerX,
                                                multiplier: 1.0,
                                                constant: 0))
        addConstraint(NSLayoutConstraint.init(item: tipLabel,
                                                attribute: .top,
                                                relatedBy: .equal,
                                                toItem: iconImage,
                                                attribute: .bottom,
                                                multiplier: 1.0,
                                                constant: margin))
        addConstraint(NSLayoutConstraint.init(item: tipLabel,
                                                attribute: .width,
                                                relatedBy: .equal,
                                                toItem: nil,
                                                attribute: .notAnAttribute,
                                                multiplier: 1.0, constant: 236))
        //注册按钮
        addConstraint(NSLayoutConstraint.init(item: registerButton,
                                              attribute: .left,
                                              relatedBy: .equal,
                                              toItem: tipLabel,
                                              attribute: .left,
                                              multiplier: 1.0,
                                              constant: 0))
        addConstraint(NSLayoutConstraint.init(item: registerButton,
                                              attribute: .top,
                                              relatedBy: .equal,
                                              toItem: tipLabel,
                                              attribute: .bottom,
                                              multiplier: 1.0,
                                              constant: margin))
        addConstraint(NSLayoutConstraint.init(item: registerButton,
                                              attribute: .width,
                                              relatedBy: .equal,
                                              toItem: nil,
                                              attribute: .notAnAttribute,
                                              multiplier: 1.0,
                                              constant: 100))
        
        //登录按钮
        addConstraint(NSLayoutConstraint.init(item: loginButton,
                                              attribute: .right,
                                              relatedBy: .equal,
                                              toItem: tipLabel,
                                              attribute: .right,
                                              multiplier: 1.0,
                                              constant: 0))
        addConstraint(NSLayoutConstraint.init(item: loginButton,
                                              attribute: .top,
                                              relatedBy: .equal,
                                              toItem: tipLabel,
                                              attribute: .bottom,
                                              multiplier: 1.0,
                                              constant: margin))
        addConstraint(NSLayoutConstraint.init(item: loginButton,
                                              attribute: .width,
                                              relatedBy: .equal,
                                              toItem: registerButton,
                                              attribute: .width,
                                              multiplier: 1.0,
                                              constant: 0))
        //设置遮罩
        //1. views:定义VFL中的控件名称和实际名称映射关系
        //2. metrics:定义VFL中（）指定的常数映射关系
        let viewDict = ["maskImage":maskImage,
                        "registerButton":registerButton]
        let metrics = ["spacing":-20]
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[maskImage]-0-|",
                                                      options: [],
                                                      metrics: nil,
                                                      views: viewDict))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[maskImage]-(spacing)-[registerButton]",
                                                      options: [],
                                                      metrics: metrics,
                                                      views: viewDict))

        
    }
}
