//
//  WBMainViewController.swift
//  Weibo
//
//  Created by Smile on 2018/3/5.
//  Copyright © 2018年 llbt. All rights reserved.
//

import UIKit

//主控制器
class WBMainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUpChildViewControllers()
    }

}

//使用extensions进行切分代码块

//MARK: 设置界面
extension WBMainViewController {
    

    //设置所有子控制器
    private func setUpChildViewControllers() {
        let array  = [["clsName":"WBHomeViewController","title":"首页","imageName":"home"],
                      ["clsName":"WBMessageViewController","title":"消息","imageName":"message_center"],
                      ["clsName":"WBDiscoverViewController","title":"发现","imageName":"discover"],
                      ["clsName":"WBProfileViewController","title":"我","imageName":"profile"],]
        var arrayM = [UIViewController]()
        for dict in array {
            print(dict)
            arrayM.append(controller(dict: dict))
        }
        viewControllers = arrayM
        
    }
   /// 使用一个字典创建一个子控制器
   ///
   /// - Parameter dict: [clsName，title，imageName]
   /// - Returns: 导航控制器
    
    private func controller(dict: [String : String]) -> UIViewController {
    
    //1. 取得字典内容
    guard let clsName = dict["clsName"],
    let title = dict["title"],
    let imageName = dict["imageName"],
        let cls = NSClassFromString(Bundle.main.namespace+"."+clsName) as? UIViewController.Type
//        print("-----\(cls)")
    else {
        return UIViewController()
    }
    
    //2. 创建视图控制器
    let vc = cls.init()
    vc.title = title
    //3.设置图片
    vc.tabBarItem.image = UIImage.init(named: "tabbar_"+imageName)?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
    vc.tabBarItem.selectedImage = UIImage.init(named: "tabbar_"+imageName+"_selected")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
    let nav = WBNavViewController.init(rootViewController: vc)
    return nav
  }

}
