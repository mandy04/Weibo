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
        let url = "https://api.weibo.com/2/statuses/home_timeline.json"
        //swift中，int可以转成any，Int64不行
        let params = ["since_id":"\(since_id)",
            "max_id":"\(max_id > 0 ? max_id - 1 : 0)"]
        
        tokenRequest(URLString: url, parameters: params) { (json, isSuccess) in
            let result = (json as? [String : Any])?["statuses"] as? [[String: Any]]

            completion(result, isSuccess)
         }
    }
}
