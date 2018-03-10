//
//  WBBaseViewController.swift
//  Weibo
//
//  Created by Smile on 2018/3/5.
//  Copyright © 2018年 llbt. All rights reserved.
//

import UIKit

class WBBaseViewController: UIViewController {

    //设置导航条
    lazy var navigationBar = UINavigationBar.init(frame: CGRect(x: 0, y: 0, width: UIScreen.cz_screenWidth(), height: 64))
    //设置导航条目
    lazy var navItem = UINavigationItem()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    //重写title setter
    override var title: String? {
        didSet {
            navItem.title = title
        }
    }
}


extension WBBaseViewController {
    
    //MARK： 设置界面
    //注：swift4.0 子类要重写父类的extension方法，需要加@objc，否则报错"Declarations in extensions cannot override yet"
   @objc func setupUI() {
    
    view.backgroundColor = UIColor.cz_random()

    //添加navigationBar
    view.addSubview(navigationBar)
    //将item设置给bar
    navigationBar.items = [navItem]
    //设置navigationBar 条子渲染颜色
    navigationBar.barTintColor = UIColor.cz_color(withHex: 0xF6F6F6)
    //设置navigationBar 标题颜色
    navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor.lightGray]
    }
}
