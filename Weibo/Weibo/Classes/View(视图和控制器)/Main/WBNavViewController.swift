//
//  WBNavViewController.swift
//  Weibo
//
//  Created by Smile on 2018/3/5.
//  Copyright © 2018年 llbt. All rights reserved.
//

import UIKit

class WBNavViewController: UINavigationController {

    //重写push 所有push动作都会调用此方法
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
//        print(viewController)
        //隐藏navigationBar，在基类里自定义
        navigationBar.isHidden = true
        //如果不是栈底控制器才需要隐藏，根控制器不需要处理
        if childViewControllers.count > 0 {
            //隐藏底部的tabbar
            viewController.hidesBottomBarWhenPushed = true
        }
        
        super.pushViewController(viewController, animated: animated)
    }
}
