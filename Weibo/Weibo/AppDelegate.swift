//
//  AppDelegate.swift
//  Weibo
//
//  Created by Smile on 2018/3/4.
//  Copyright © 2018年 llbt. All rights reserved.
//

import UIKit
import UserNotifications
import SVProgressHUD
import AFNetworking

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        //应用程序额外设置
        setupAdditions()
        
        window = UIWindow()
        window?.rootViewController = WBMainViewController()
        window?.backgroundColor = UIColor.white
        window?.makeKeyAndVisible()
        
        loadInfo()
        return true
    }
}


// MARK: - 设置应用程序额外设置
extension AppDelegate {
    
    func setupAdditions() {
        
        //1. 设置SVProgressHUD 最小解除时间
        SVProgressHUD.setMinimumDismissTimeInterval(1)
        
        //2. 设置AFN 加载指示器
        AFNetworkActivityIndicatorManager.shared().isEnabled = true
        
        //3. 设置用户授权显示通知  [sound/badgeNumber/alert]
        if #available(iOS 10.0, *) {//10.0以上  #available检查设备版本
            UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .carPlay, .sound]) { (success, error) in
                print("授权")
            }
        } else {//10.0以下
            let notifySettings = UIUserNotificationSettings.init(types: [.alert, .badge, .sound], categories: nil)
            UIApplication.shared.registerUserNotificationSettings(notifySettings)
        }
    }
}

//MARK: - 从服务器加载数据
extension AppDelegate {
    
    private func loadInfo(){
        DispatchQueue.global().async {
            
            let url = Bundle.main.url(forResource: "main.json", withExtension: nil)
            
            let data = NSData.init(contentsOf: url!)
            
            let docDir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
            
            let jsonPath = (docDir as NSString).appendingPathComponent("main.json")
            
            //写入磁盘
            data?.write(toFile: jsonPath, atomically: true)
        }
    }
}

