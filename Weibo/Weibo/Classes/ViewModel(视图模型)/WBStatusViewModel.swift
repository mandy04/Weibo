//
//  WBStatusViewModel.swift
//  Weibo
//
//  Created by Smile on 2018/9/3.
//  Copyright © 2018年 llbt. All rights reserved.
//

import Foundation


/// 若没有父类，如果希望在开发时调试，输出调试信息，需要：
/* 1. 继承CustomStringConvertible
   2. 实现description
 */
class WBStatusViewModel : CustomStringConvertible{
    
    //微博模型
    var status : WBStatus?
    
    /// 微博模型
    /// - 构造函数
    /// - Parameter model: 微博视图模型
    init(model: WBStatus) {
        self.status = model
    }
    var description: String {
        return status!.description
    }
}
