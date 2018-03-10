//
//  WBBaseViewController.swift
//  Weibo
//
//  Created by Smile on 2018/3/5.
//  Copyright © 2018年 llbt. All rights reserved.
//

import UIKit

class WBBaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}


extension WBBaseViewController {
    
    //MARK： 设置界面
    //注：swift4.0 子类要重写父类的extension方法，需要加@objc，否则报错"Declarations in extensions cannot override yet"
   @objc func setupUI() {
        view.backgroundColor = UIColor.cz_random()
    }
}
