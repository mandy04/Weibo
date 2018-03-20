//
//  AppDelegate.swift
//  Weibo
//
//  Created by Smile on 2018/3/4.
//  Copyright © 2018年 llbt. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        window = UIWindow()
        window?.rootViewController = WBMainViewController()
        window?.backgroundColor = UIColor.white
        window?.makeKeyAndVisible()
        
        loadInfo()
        return true
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

