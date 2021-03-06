//
//  WBNetWorkManager.swift
//  Weibo
//
//  Created by Smile on 2018/7/25.
//  Copyright © 2018年 llbt. All rights reserved.
//

import UIKit
import AFNetworking

enum WBHTTPMethod {
    case GET
    case POST
}
///网络管理工具
class WBNetWorkManager: AFHTTPSessionManager {

    ///静态区 常量 不可修改
    //闭包 在第一次访问时执行闭包，并且将结果保存到shared中
    
    static let shared: WBNetWorkManager = {
        
        //实例化对象
        let instance = WBNetWorkManager()
        
        //设置AFN反序列化对象支持的数据类型
        instance.responseSerializer.acceptableContentTypes?.insert("text/plain")
        
        return instance
    }()
    
    //用户账户的懒加载属性
    lazy var userAccount = WBUserAccount()
    
    //用户登录标记 [计算型属性]
    var userLogon : Bool {
        return userAccount.access_token != nil
    }
    
    
    //专门负责拼接token的网络方法
    func tokenRequest(method: WBHTTPMethod = .GET, URLString: String,parameters: [String: Any]?,completion: @escaping (_ json: Any?, _ isSuccess: Bool)->()){
        
        //处理token字典
        //0. 判断token是否为存在，如果为nil，应该新建一个字典
        
        guard let token = userAccount.access_token else {
            //发送通知，提示用户登录
            print("没有 token! 需要登录")
            //发送通知
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: WBUserShouldLoginNotification),
                                            object: nil)
            
            completion(nil, false)
            return
        }
        
        
        //1. 判断参数字典是否为存在，如果为nil，应该新建一个字典
        var parameters = parameters
        if parameters == nil {
            parameters = [String :AnyObject]()
        }
        //2.设置参数字典
        parameters!["access_token"] = token
        
        //调用request发起真正的网络请求方法
        request(URLString: URLString, parameters: parameters, completion: completion)
        
    }
    /// 封装AFN GET、POST网络请求方法
    /// - Parameters:
    ///   - method: GET/POST
    ///   - URLString:urlString
    ///   - parameters: 参数字典
    ///   - completion: 完成回调[json(字典数组),是否成功]
    func request(method: WBHTTPMethod = .GET, URLString:String, parameters:[String: Any]?, completion:@escaping (_ json: Any, _ isSuccess: Bool)->() )  {
        //成功回调
        let success = { (task: URLSessionDataTask, json:Any)->() in
            completion(json as AnyObject, true)
        }
        //失败回调
        let failure = { (task: URLSessionDataTask?, error:Error)->() in
            
            //针对403 处理token过期
            //超出上限，token会被锁定一段时间，新建一个应用
            if (task?.response as? HTTPURLResponse)?.statusCode == 403 {
                print("Token过期了")
                
                //发送通知，提示用户再次登录（谁接收到通知，谁处理！！）
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: WBUserShouldLoginNotification),
                                                object: nil)
            }
            print("网络请求错误\(error)")
            completion("" as AnyObject, false)
        }
        
        if method == .GET {
            get(URLString, parameters: parameters, progress: nil, success: success, failure: failure)
        }else {
            post(URLString, parameters: parameters, progress: nil, success: success, failure: failure)
        }
        
    }
    
}
