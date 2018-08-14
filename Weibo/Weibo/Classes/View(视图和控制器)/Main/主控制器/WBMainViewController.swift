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

    //定时器
    private var timer: Timer?
    
    //MARK： 私有控件
    //撰写按钮
    private lazy var composeButton:UIButton = UIButton.cz_imageButton("tabbar_compose_icon_add",
                                                                      backgroundImageName: "tabbar_compose_button")
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpChildViewControllers()
        setUpComposeButton()
        setUpTimer()
    }
    
    deinit{
        //销毁时钟
        timer?.invalidate()
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

//MARK： 时钟相关方法
extension WBMainViewController {
    private func setUpTimer() {
        timer = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    //时钟触发方法
    @objc func updateTimer() {
        //测试微博未读数量
        WBNetWorkManager.shared.unreadCount { (count) in
            print("有 \(count) 条微博")
            
            //设置首页 tabBarItem的badgeNumber
            self.tabBar.items?[0].badgeValue = count > 0 ? "\(count)" : nil
        }
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
        
        //1.取json：获取沙盒json路径
        let docDir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        let jsonPath = (docDir as NSString).appendingPathComponent("main.json")
        
        //2.加载data
        var data = NSData.init(contentsOfFile: jsonPath)
        
        //判断data是否有数据
        if data == nil {
            let pathDir = Bundle.main.path(forResource: "main.json", ofType: nil)
            data = NSData.init(contentsOfFile: pathDir!)
        }

        //3.反序列化
        guard let array = try? JSONSerialization.jsonObject(with: data! as Data, options: []) as? [[String: AnyObject]]
        else {
            return
        }
        //遍历数组，循环创建控制器数组
        var arrayM = [UIViewController]()
        for dict in array! {
            arrayM.append(controller(dict: dict))
        }
        //设置tabbar的子控制器
        viewControllers = arrayM
    }
    
   /// 使用一个字典创建一个子控制器
   ///
   /// - Parameter dict: [clsName，title，imageName,visitorInfo]
   /// - Returns: 导航控制器
    private func controller(dict: [String : Any]) -> UIViewController {
    
    //1. 取得字典内容
    guard let clsName = dict["clsName"] as? String,
        let title = dict["title"] as? String,
        let imageName = dict["imageName"] as? String,
        let cls = NSClassFromString(Bundle.main.namespace+"."+clsName) as? WBBaseViewController.Type,
        let visitorDict = dict["visitorInfo"] as? [String:String]
    else {
        return UIViewController()
    }
        print("-----\(cls)")

    //2. 创建视图控制器
    let vc = cls.init()
    vc.title = title
    //设置访客视图的字典
    vc.visitorInfoDict = visitorDict
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
