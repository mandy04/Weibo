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

    //MARK： 私有控件
    //撰写按钮
    private lazy var composeButton:UIButton = UIButton.cz_imageButton("tabbar_compose_icon_add",
                                                                      backgroundImageName: "tabbar_compose_button")
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpChildViewControllers()
        setUpComposeButton()
    }
    
    //MARK：监听方法
    //撰写微博
    //FIXME: 没有实现
    //1.private ：保证方法私有，仅在当前对象被访问
    //2.@objc ：允许这个函数在‘运行时’通过 OC 的消息机制被调用
    @objc private func composeStatus() {
        print("撰写微博")
    }
    
}


//使用extensions进行切分代码块
//MARK: 设置界面
extension WBMainViewController {
    
    private func setUpComposeButton() {
        
        tabBar.addSubview(composeButton)
        
        //计算每一个item宽度
        let count = CGFloat(childViewControllers.count)
        let w = tabBar.frame.width / count
        
        //设置composeButton的位置 缩进2个item的宽度
        composeButton.frame = tabBar.bounds.insetBy(dx: 2 * w, dy: 0)
        print("撰写按钮宽度\(composeButton.bounds.width)")
        
        composeButton.addTarget(self, action: #selector(composeStatus), for: UIControlEvents.touchUpInside)
        
    }

    //设置所有子控制器
    private func setUpChildViewControllers() {
        let array  = [["clsName":"WBHomeViewController","title":"首页","imageName":"home"],
                      ["clsName":"WBMessageViewController","title":"消息","imageName":"message_center"],
                      ["clsName":"UIViewController"],
                      ["clsName":"WBDiscoverViewController","title":"发现","imageName":"discover"],
                      ["clsName":"WBProfileViewController","title":"我","imageName":"profile"],]
        var arrayM = [UIViewController]()
        for dict in array {
//            print(dict)
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
    else {
        return UIViewController()
    }
        print("-----\(cls)")

    //2. 创建视图控制器
    let vc = cls.init()
    vc.title = title
    //3.设置图片
    vc.tabBarItem.image = UIImage.init(named: "tabbar_"+imageName)?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
    vc.tabBarItem.selectedImage = UIImage.init(named: "tabbar_"+imageName+"_selected")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
   //4.设置tabbar的字体颜色
    vc.tabBarItem.setTitleTextAttributes([NSAttributedStringKey.foregroundColor : UIColor.orange], for: UIControlState.highlighted)
    //设置字体大小  系统默认12
//    vc.tabBarItem.setTitleTextAttributes([NSAttributedStringKey.font:UIFont.systemFont(ofSize: 24)], for: UIControlState.normal)
    let nav = WBNavViewController.init(rootViewController: vc)
    return nav
  }
    
    

}
