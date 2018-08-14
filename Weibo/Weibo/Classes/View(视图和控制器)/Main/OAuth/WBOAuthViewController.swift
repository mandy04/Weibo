//
//  WBOAuthViewController.swift
//  Weibo
//
//  Created by Smile on 2018/8/14.
//  Copyright © 2018年 llbt. All rights reserved.
//

import UIKit

class WBOAuthViewController: UIViewController {

    private lazy var webView = UIWebView()
    
    override func loadView() {
        view = webView
        view.backgroundColor = UIColor.white
        //设置导航栏
        title = "登录新浪微博"
        navigationItem.leftBarButtonItem = UIBarButtonItem.init(title: "返回", target: self, action: #selector(close), isBack: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    //返回
    @objc private func close() {
        self.dismiss(animated: true, completion: nil)
    }
}
