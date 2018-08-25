//
//  WeiBoCommon.swift
//  Weibo
//
//  Created by Smile on 2018/8/14.
//  Copyright © 2018年 llbt. All rights reserved.
//

import Foundation

//MARK： -应用程序信息
//应用程序ID
let WBAppKey = "1629409877"
//应用程序加密信息（开发者可以申请修改）
let WBAppSecret = "a88bd3671421588aa101723b2702d84e"
//回调url，登录完成跳转的URL， 参数以get拼接
let WBRedirectURI = "http://baidu.com"


/// MARK --全局通知定义
//用户需要登录通知
let WBUserShouldLoginNotification = "WBUserShouldLoginNotification"
let WBLoginSuccessedNotification = "WBLoginSuccessedNotification"
