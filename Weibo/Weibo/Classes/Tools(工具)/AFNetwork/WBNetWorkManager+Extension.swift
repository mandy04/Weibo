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
    
    func statusList(completion: @escaping (_ list:[[String : Any]]?, _ isSuccss:Bool)->()) {
        let url = "https://api.weibo.com/2/statuses/home_timeline.json"
        
        tokenRequest(URLString: url, parameters: nil) { (json, isSuccess) in
            let result = (json as? [String : Any])?["statuses"] as? [[String: Any]]

            completion(result, isSuccess)
         }
    }
}
