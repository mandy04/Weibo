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
        window?.rootViewController = WBHomeViewController()
        window?.backgroundColor = UIColor.white
        window?.makeKeyAndVisible()
        
        return true
    }

}

