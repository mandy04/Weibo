//
//  WBNavViewController.swift
//  Weibo
//
//  Created by Smile on 2018/3/5.
//  Copyright © 2018年 llbt. All rights reserved.
//

import UIKit

class WBNavViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //隐藏navigationBar，在基类里自定义
        navigationBar.isHidden = true
    }
    
    @objc private func popToParent() {
        popViewController(animated: true)
    }
    
    //重写push 所有push动作都会调用此方法
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
//        print(viewController)
        //如果不是栈底控制器才需要隐藏，根控制器不需要处理
        if childViewControllers.count > 0 {
            //隐藏底部的tabbar
            viewController.hidesBottomBarWhenPushed = true
            
            //判断控制器的类型
            if let vc = viewController as? WBBaseViewController {
            
            var title = "返回"
            //判断控制器的级数，如果只有一个控制器，返回栈底控制器的title
            if childViewControllers.count == 1 {
                title = childViewControllers.first?.title ?? "返回"
            }
            
            vc.navItem.leftBarButtonItem = UIBarButtonItem.init(title: title, target: self, action: #selector(popToParent), isBack: true)
        }
    }
        super.pushViewController(viewController, animated: animated)
  }
    
}
