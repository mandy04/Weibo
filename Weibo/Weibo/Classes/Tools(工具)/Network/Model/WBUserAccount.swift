//
//  WBUserAccount.swift
//  Weibo
//
//  Created by Smile on 2018/8/15.
//  Copyright © 2018年 llbt. All rights reserved.
//

import UIKit

private let accountFile: NSString = "useraccount.json"

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
    ///用户昵称
    var screen_name: String?
    ///用户头像地址（大图），180×180像素
    var avatar_large: String?
    //过期日期
    var expiresDate: NSDate?
    
    override var description: String {
        return yy_modelDescription()
    }
    
    override init() {
        super.init()
        //从磁盘中加载保存的文件--字典
        //1. 加载磁盘文件到二进制数据，如果失败直接返回
        guard let filePath = accountFile.cz_appendDocumentDir(),
        let data = NSData.init(contentsOfFile: filePath),
            let dict = try? JSONSerialization.jsonObject(with: data as Data, options: []) as? [String : Any] else {
                return
        }
        //2. 使用字典设置属性值
        yy_modelSet(with: dict ?? [:])
        print("从沙盒加载用户信息\(self)")
        
        //判断token是否过期
        //往前推算一天  -3600 * 24
//        expiresDate = Date.init(timeIntervalSinceNow: -3600 * 24) as NSDate
//        print("模拟过期时间---\(String(describing: expiresDate))")
        if expiresDate?.compare(Date()) != .orderedDescending {
            print("账户过期")
            access_token = nil
            uid = nil
            //清空缓存账户信息
            try? FileManager.default.removeItem(atPath: filePath)
        }
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
              let filePath = accountFile.cz_appendDocumentDir()
        else {
            return
        }
        print("用户账户保存成功\(filePath)")

        //3. 写入磁盘
        (data as NSData).write(toFile: filePath, atomically: true)
    }
}















