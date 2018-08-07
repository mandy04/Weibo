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
    static let shared = WBNetWorkManager()
    
    //访问令牌，所有网络请求，都基于此令牌（登录除外）
    //MARK:----if 里面的判断类型必须是Optional类型。

    var access_token: String? = "2.00fXeqaFRXwdnC58ac5de911LgkdlC"
    var uid : String  = ""
    
    //专门负责拼接token的网络方法
    func tokenRequest(method: WBHTTPMethod = .GET, URLString: String,parameters: [String: Any]?,completion: @escaping (_ json: Any?, _ isSuccess: Bool)->()){
        
        //处理token字典
        //0. 判断token是否为存在，如果为nil，应该新建一个字典
        
        guard let token = access_token else {
            //FIXME:发送通知，提示用户登录
            print("没有 token! 需要登录")
            
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
            
            //处理token过期
            if (task?.response as? HTTPURLResponse)?.statusCode == 403 {
                print("Token过期了")
                
                //FIXME:发送通知，提示用户再次登录（谁接收到通知，谁处理！！）

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
