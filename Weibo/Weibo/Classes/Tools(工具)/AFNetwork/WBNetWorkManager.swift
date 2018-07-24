//
//  WBNetWorkManager.swift
//  Weibo
//
//  Created by Smile on 2018/7/25.
//  Copyright © 2018年 llbt. All rights reserved.
//

import UIKit
import AFNetworking

///网络管理工具
class WBNetWorkManager: AFHTTPSessionManager {

    ///静态区 常量 不可修改
    //闭包 在第一次访问时执行闭包，并且将结果保存到shared中
    static let shared = WBNetWorkManager()
    
}
