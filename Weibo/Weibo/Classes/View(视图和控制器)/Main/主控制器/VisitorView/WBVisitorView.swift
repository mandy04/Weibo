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
    ///icon
    private lazy var icoImage:UIImageView = UIImageView.init(image: UIImage.init(named: "visitordiscover_feed_image_smallicon"))
    ///hourseICon
    private lazy var houseIcoImage:UIImageView = UIImageView.init(image: UIImage.init(named: "visitordiscover_feed_image_house"))
    ///label
    private lazy var textLabel:UILabel = UILabel.cz_label(withText: "000", fontSize: 14, color: UIColor.darkGray)
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
        
    }
}
