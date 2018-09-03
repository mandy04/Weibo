//
//  WBStatusViewModel.swift
//  Weibo
//
//  Created by Smile on 2018/9/3.
//  Copyright © 2018年 llbt. All rights reserved.
//

import Foundation

class WBStatusViewModel {
    
    //微博模型
    var status : WBStatus?
    
    /// 微博模型
    /// - 构造函数
    /// - Parameter model: 微博视图模型
    init(model: WBStatus) {
        self.status = model
    }
}
