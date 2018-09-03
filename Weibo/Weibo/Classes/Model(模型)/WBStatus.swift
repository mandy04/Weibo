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
    
    //基本数据类型需要赋初值
    var id :Int64 = 0
    //微博信息
    var text:String?
    //微博用户 --注意和服务器返回 KEY 一致
    var user : WBUser?
    
    //重写description计算型属性
    override var description: String {
        return yy_modelDescription()
    }

}
