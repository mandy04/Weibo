//
//  WBUserAccount.swift
//  Weibo
//
//  Created by Smile on 2018/8/15.
//  Copyright © 2018年 llbt. All rights reserved.
//

import UIKit
import YYModel

//用户账户信息
class WBUserAccount: NSObject {
    //访问令牌  所有网络请求（登录除外）都基于
    var access_Token: String?
    //用户代号
    var uid: String?
    //开发者 5年
    //使用者 3天  access_token的生命周期，单位是秒数。
    var expires_in: TimeInterval = 0
    
    override var description: String {
        return yy_modelDescription()
    }
}
