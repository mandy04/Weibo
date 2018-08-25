//
//  WBNetWorkManager+Extension.swift
//  Weibo
//
//  Created by Smile on 2018/7/25.
//  Copyright © 2018年 llbt. All rights reserved.
//

import Foundation

extension WBNetWorkManager {
    
    /// 加载微博数据字典
    ///
    /// - Parameters:
    ///   - since_id: 返回ID比since_id大的微博（即比since_id时间晚的微博），默认为0。
    ///   - max_id: 返回ID小于或等于max_id的微博，默认为0。
    ///   - completion: 完成回调 lis[字典数组]，是否成功
    func statusList(since_id:Int64 ,max_id:Int64 , completion: @escaping (_ list:[[String : Any]]?, _ isSuccss:Bool)->()) {
        let urlString = "https://api.weibo.com/2/statuses/home_timeline.json"
        //swift中，int可以转成any，Int64不行
        let params = ["since_id":"\(since_id)",
            "max_id":"\(max_id > 0 ? max_id - 1 : 0)"]
        
        tokenRequest(URLString: urlString, parameters: params) { (json, isSuccess) in
            let result = (json as? [String : Any])?["statuses"] as? [[String: Any]]

            completion(result, isSuccess)
         }
    }
    
    //返回微博未读信息数量  --定时刷新，不需要返回失败
    func unreadCount(completion: @escaping (_ count:Int) -> ()) {
        
        guard let uid:String = userAccount.uid else {
            return
        }
        let urlString = "https://rm.api.weibo.com/2/remind/unread_count.json"
        let params = ["uid":uid]
        tokenRequest(URLString: urlString, parameters: params) { (json, isSuccess) in
            
            let dict = json as? [String : Any]
            let count = dict?["status"] as? Int
            completion(count ?? 0)
        }
    }
}


// MARK: - 用户信息
extension WBNetWorkManager {
    func loadUserInfo(completion: @escaping (_ dict : [String : Any ])->()) {
        guard let uid:String = userAccount.uid else {
            return
        }
        
        let urlString = "https://api.weibo.com/2/users/show.json"
        
        let params = ["uid":uid]
        
        //发起网络请求
        tokenRequest(URLString: urlString, parameters: params) { (json, isSuccess) in
            completion(json as? [String: Any] ?? [:])
        }
    }
}

// MARK: - OAuth相关方法
extension WBNetWorkManager {
    
    //提问：网络请求异步应该返回什么?-需要什么返回什么
    /// 加载AccessToken
    ///
    /// - Parameters:
    ///   - code: 授权码
    ///   - completion: [完成回调：是否成功]
    func loadAccessToken(code: String, completion: @escaping (_ isSuccess: Bool)-> ()) {
        
        let urlString = "https://api.weibo.com/oauth2/access_token"
        let params = ["client_id":WBAppKey,
                      "client_secret":WBAppSecret,
                      "grant_type":"authorization_code",
                      "code":code,
                      "redirect_uri":WBRedirectURI,
                      ]
        //发起请求
        request(method: .POST, URLString: urlString, parameters: params) { (json, isSuccess) in
            print("获取AccessToken - \(json) ")
            
            //如果请求失败，不会对用户有任何影响
            //直接用字典设置 userAccount 的属性
            self.userAccount.yy_modelSet(with: (json as? [String : Any]) ?? [:])
            
            //加载当前用户信息
            self.loadUserInfo(completion: { (dict) in
                
                //使用用户信息字典设置用户账户信息(昵称和头像地址)
                self.userAccount.yy_modelSet(with: dict)
                //保存模型
                self.userAccount.saveAccount()
                print(self.userAccount)
                
                //用户信息加载完成，再完成回调
                completion(isSuccess)
            })
        }
    }
}
