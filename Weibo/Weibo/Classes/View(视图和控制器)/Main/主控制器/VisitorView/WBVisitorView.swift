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
    ///hourseICon 小房子
    private lazy var houseIconImage:UIImageView = UIImageView.init(image: UIImage.init(named: "visitordiscover_feed_image_house"))
    ///tipLabel 提示标签
    private lazy var tipLabel:UILabel = UILabel.cz_label(withText: "关注一些人，回这里看看有什么新鲜事关注一些人，回这里看看有什么新鲜事", fontSize: 14, color: UIColor.darkGray)
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
        backgroundColor = UIColor.white
        //1. 添加视图
        addSubview(iconImage)
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
                                              constant: 100))

        
    }
}
