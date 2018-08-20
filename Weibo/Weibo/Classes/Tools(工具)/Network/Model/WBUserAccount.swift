//
//  WBUserAccount.swift
//  Weibo
//
//  Created by Smile on 2018/8/15.
//  Copyright © 2018年 llbt. All rights reserved.
//

import UIKit

//用户账户信息
@objcMembers class WBUserAccount: NSObject {
    //访问令牌  所有网络请求（登录除外）都基于
    var access_token: String?  //= "2.00fXeqaFRXwdnC58ac5de911LgkdlC"
    //用户代号
    var uid: String?
    //开发者 5年 ，每次登录之后，都是5年
    //使用者 3天  access_token的生命周期，单位是秒数。  会从第一次登录后开始递减
    var expires_in: TimeInterval = 0 {
        didSet{
            expiresDate = Date(timeIntervalSinceNow: expires_in) as NSDate
        }
    }
    
    //过期日期
    var expiresDate: NSDate?
    
    override var description: String {
        return yy_modelDescription()
    }
    
    /**1. 偏好设置（存小）
     * 2. 沙盒 -归档/json/plist
     * 3. 数据库  FMDB/CoreData
     * 4. 钥匙串访问（存小/自动加密 -需要使用框架SSKeyChain）
     */
    func saveAccount() {
        //1. 模型转字典
        var dict = (self.yy_modelToJSONObject() as? [String : Any]) ?? [:]
         //删除expires_in
        dict.removeValue(forKey: "expires_in")
        //2. 字典序列化  转Data
        guard let data = try? JSONSerialization.data(withJSONObject: dict, options: []),
              let filePath = ("useraccount.json" as NSString).cz_appendDocumentDir()
        else {
            return
        }
        print("用户账户保存成功\(filePath)")

        //3. 写入磁盘
        (data as NSData).write(toFile: filePath, atomically: true)
    }
}















