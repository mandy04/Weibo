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
    
    /// 封装AFN GET、POST网络请求方法
    /// - Parameters:
    ///   - method: GET/POST
    ///   - URLString:urlString
    ///   - parameters: 参数字典
    ///   - completion: 完成回调[json(字典数组),是否成功]
    func request(method: WBHTTPMethod = .GET, URLString:String, parameters:[String: AnyObject]?, completion:@escaping (_ json: AnyObject, _ isSuccess: Bool)->() )  {
        //成功回调
        let success = { (task: URLSessionDataTask, json:Any)->() in
            completion(json as AnyObject, true)
        }
        //失败回调
        let failure = { (task: URLSessionDataTask?, error:Error)->() in
            
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
