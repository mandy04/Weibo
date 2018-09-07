//
//  WBStatusPicture.swift
//  Weibo
//
//  Created by Smile on 2018/9/7.
//  Copyright © 2018年 llbt. All rights reserved.
//

import UIKit

@objcMembers class WBStatusPicture: NSObject {

    /// 缩略图地址
    dynamic var thumbnail_pic: String?
    
    override var description: String{
        return yy_modelDescription()
    }
}
