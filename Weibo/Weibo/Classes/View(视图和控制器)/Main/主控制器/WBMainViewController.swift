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
    
   /*  portrait   竖屏，肖像
    *  landscape   横屏，风景画
    *  好处：自由横竖屏幕，设置支持的方向之后，当前的控制器及子控制器都会遵守这个方向
    *   如果是视频播放，通过modal展现
    */
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
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
        //将向内缩进的宽度减小，能够让按钮的宽度变大，遮住容错点
        let w = tabBar.frame.width / count - 1
        
        //设置composeButton的位置 缩进2个item的宽度  CGRectInset 正数向内缩进，负数向外扩展
        composeButton.frame = tabBar.bounds.insetBy(dx: 2 * w, dy: 0)
        print("撰写按钮宽度\(composeButton.bounds.width)")
        
        composeButton.addTarget(self, action: #selector(composeStatus), for: UIControlEvents.touchUpInside)
    }

    //设置所有子控制器
    private func setUpChildViewControllers() {
        let array :[[String: Any]] = [["clsName":"WBHomeViewController","title":"首页","imageName":"home",
                       "visitorInfo":["imageName":"","messgage":"哈哈哈"]],
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
    private func controller(dict: [String : Any]) -> UIViewController {
    
    //1. 取得字典内容
    guard let clsName = dict["clsName"] as? String,
    let title = dict["title"] as? String,
    let imageName = dict["imageName"] as? String,
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
    vc.tabBarItem.setTitleTextAttributes([NSAttributedStringKey.font:UIFont.systemFont(ofSize: 12)], for: UIControlState.normal)
    //实例化导航控制器的时候，会调用push方法，将vc压栈
    let nav = WBNavViewController.init(rootViewController: vc)
    return nav
  }
    
    

}
