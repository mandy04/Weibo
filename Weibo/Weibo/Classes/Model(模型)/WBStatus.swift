//
//  WBStatus.swift
//  Weibo
//
//  Created by Smile on 2018/8/4.
//  Copyright © 2018年 llbt. All rights reserved.
//

import UIKit
import YYModel

//微博数据模型
class WBStatus: NSObject {
    
    var id :Int64 = 0
    var text:String?
    
    //重写description计算型属性
    override var description: String {
        return yy_modelDescription()
    }

}
