//
//  Bundle+extension.swift
//  Weibo
//
//  Created by Smile on 2018/3/6.
//  Copyright © 2018年 llbt. All rights reserved.
//

import Foundation

extension Bundle {
    //返回命名空间字符串
    
    //计算型属性  更加直观
    var namespace :String {
        return infoDictionary? ["CFBundleName"] as? String ?? ""
    }
    
}
