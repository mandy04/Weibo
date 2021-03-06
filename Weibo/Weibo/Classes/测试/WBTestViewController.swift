//
//  WBTestViewController.swift
//  Weibo
//
//  Created by Smile on 2018/3/10.
//  Copyright © 2018年 llbt. All rights reserved.
//

import UIKit

class WBTestViewController: WBBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //设置title
        title = "这是第\(navigationController?.childViewControllers.count ?? 0)个"
    }
    
    //MARK: 监听事件
    //继续PUSH一个新的控制器
    @objc private func showNext() {
        let vc = WBTestViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    //MARK: 测试屏幕的方向
    func testOrientation() {
        let vc = UIViewController()
        vc.view.backgroundColor = UIColor.brown
        let nav = UINavigationController.init(rootViewController: vc)
        present(nav, animated: true, completion: nil)
    }
    
}

extension WBTestViewController {
    //MARK: 重写父类方法
    override func setupTableView() {
        super.setupTableView()
        
        navItem.rightBarButtonItem = UIBarButtonItem.init(title: "下一页", target: self, action: #selector(showNext))

    }
}
