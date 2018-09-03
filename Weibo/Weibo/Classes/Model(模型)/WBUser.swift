//
//  WBUser.swift
//  Weibo
//
//  Created by Smile on 2018/9/3.
//  Copyright © 2018年 llbt. All rights reserved.
//

import UIKit

/// 微博用户模型
class WBUser: NSObject {
    
    //基本数据类型与private 不能？
    var id : Int64 = 0
    //用户昵称
    var screen_name : String?
    //用户头像地址（中图），50×50像素
    var profile_image_url : String?
    //认定类型，-1：没有认证；0：认证用户；2，3，5：企业认证；220：达人
    var verified_type : Int = 0
    //会员等级 0-6
    var  mbrank : Int = 0
    
    override func yy_modelDescription() -> String {
        return yy_modelDescription()
    }
}
