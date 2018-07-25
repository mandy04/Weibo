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
    /// - Parameter completion: 完成回调 lis[字典数组]，是否成功
    func statusList(completion: @escaping (_ list:[[String : AnyObject]], _ isSuccess:Bool)->()) {
        let url = "https://api.weibo.com/2/statuses/home_timeline.json"
        let params = ["access_token":"2.00fXeqaFRXwdnC58ac5de911LgkdlC"]
        WBNetWorkManager.shared.request(URLString: url, parameters: params as [String : AnyObject]) { (json, isSuccess) in
            
            let result = json ["statuses"] as? [[String : AnyObject ]]
            completion(result!, isSuccess)
        }
    }
}
