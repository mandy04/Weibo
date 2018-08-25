//
//  WBMainViewController.swift
//  Weibo
//
//  Created by Smile on 2018/3/5.
//  Copyright © 2018年 llbt. All rights reserved.
//

import UIKit
import SVProgressHUD

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
        
        //设置新特性视图
        setupNewFeatureViews()
        
        //设置代理
        delegate = self
        
        //注册通知
        NotificationCenter.default.addObserver(self, selector: #selector(userLogin), name: NSNotification.Name(rawValue: WBUserShouldLoginNotification), object: nil)
    }
    
    deinit{
        //销毁时钟
        timer?.invalidate()
        
        //注销通知
        NotificationCenter.default.removeObserver(self)
    }
    
    //监听方法:
    @objc private func userLogin(n: Notification) {
        
        print("用户登录通知 \(n)")
        
        var when = DispatchTime.now()+5
        
        //判断n.object 是否有值，如果有，->token过期，提示用户重新登录
        if n.object != nil {
            //设置指示器样式
            SVProgressHUD.setDefaultMaskType(.gradient)
            
            SVProgressHUD.showInfo(withStatus: "用户登录超时，需要重新登录")
            //修改延迟时间
            when = DispatchTime.now() + 2
        }
        
        DispatchQueue.main.asyncAfter(deadline: when) {
            
            SVProgressHUD.setDefaultMaskType(.clear)
            
            //展现登录控制器  --通常会和UINavigationController连用，方便返回
            let nav = UINavigationController.init(rootViewController: WBOAuthViewController())
            
            self.present(nav, animated: true, completion: nil)
        }
        
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


// MARK: - 新特性视图处理
extension WBMainViewController {
    
    private func setupNewFeatureViews() {
     
        //1. 如果更新，显示新特性；否则显示欢迎界面
        let v = isNewVersion ? WBNewFeatureView() : WBWelcomView()
        
        //2. 添加视图
        v.frame = view.frame
        
        view.addSubview(v)
    }
    
    //extension中可以有计算型属性，不会占用存储空间
    /*版本号的科普
       -在AppStore每次升级应用程序，版本号需要增加，不能递减
       -组成：主版本号.次版本号.修订版本号
             -主版本号：意味着大的修改，使用者也需要做大的适应；
             -次版本号：意味着小的修改，某些函数或方法的使用，或者参数有变化；
             -修订版本号：程序/框架内部的 bug 的修订，不会对使用者造成任何的影像
     */
    var isNewVersion: Bool {
        
        //1. 取当前的版本号
        
        //2. 取保存在‘document（iTunes会备份）’，最理想版本号会保存在plist中，目录中之前的版本号
        
        //3. 将当前版本号保存在沙盒中
        
        //4. 返回两个版本号 ‘是否一致’
        return true
    }
}

//MARK： 时钟相关方法
extension WBMainViewController {
    
    //时间设置长一些
    private func setUpTimer() {
        timer = Timer.scheduledTimer(timeInterval: 60.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    //时钟触发方法
    @objc func updateTimer() {
        
        //用户未登录，return
        if !WBNetWorkManager.shared.userLogon {
            return
        }
        
        //测试微博未读数量
        WBNetWorkManager.shared.unreadCount { (count) in
            print("有 \(count) 条微博")
            
            //设置 首页 tabBarItem的badgeNumber
            self.tabBar.items?[0].badgeValue = count > 0 ? "\(count)" : nil
            
            //设置 App 的bagdeNumber , iOS8.0之后用户授权图标上才显示
            UIApplication.shared.applicationIconBadgeNumber = count
        }
    }
}


// MARK: - UITabBarControllerDelegate
extension WBMainViewController : UITabBarControllerDelegate {
    
    /// 将要选择tabbarItem
    ///   - tabBarController : tabBarController
    ///   - viewController : viewController
    /// - Returns: 是否切换目标控制器
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        print("将要选择:\(viewController)")
        
        //1. 获取数组中控制器的索引
        let idx = (childViewControllers as NSArray).index(of: viewController)
        //2. 判断当前索引是首页，同时 idx 也是首页，重复点击首页的按钮
        if selectedIndex == 0 && idx == selectedIndex {
            print("点击首页")
            //3.让表格滚动到顶部
            //a.获取到控制器
            let nav = childViewControllers[0] as! UINavigationController
            let vc = nav.childViewControllers[0] as! WBHomeViewController
            //b.滚动到顶部
            vc.tableView?.setContentOffset(CGPoint(x: 0, y: -64), animated: true)
            //4.刷新表格  --增加延迟，保证表格先滚动到顶部再刷新
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1, execute: {
                vc.loadData()
            })
        }
      //判断目标控制器是否是UIViewController,如果是这个类不加载；不是这个类加载；
        return !viewController.isMember(of: UIViewController.self)
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
        let w = tabBar.frame.width / count
        
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
