//
//  WBHomeViewController.swift
//  Weibo
//
//  Created by Smile on 2018/3/5.
//  Copyright © 2018年 llbt. All rights reserved.
//

import UIKit

class WBHomeViewController: WBBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    //MARK：显示好友
    @objc private func showFriends(){
        print(#function)
        let vc = WBTestViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - 设置界面
extension WBHomeViewController {
    //重写父类的方法
    override func setupUI() {
        super.setupUI()
        
        //1. 设置导航栏按钮
//        navigationItem.leftBarButtonItem = UIBarButtonItem.init(title: "好友", style: .plain, target: self, action: #selector(showFriends))
        
        //2. 使用自定义视图设置导航按钮
//        let btn : UIButton = UIButton.cz_textButton("好友", fontSize: 14, normalColor: UIColor.lightGray, highlightedColor: UIColor.orange)
//        btn.addTarget(self, action: #selector(showFriends), for: .touchUpInside)
//        navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: btn)
        
        //3. 抽取
            navItem.leftBarButtonItem = UIBarButtonItem.init(title: "好友", target: self, action: #selector(showFriends))

    }

    
}
