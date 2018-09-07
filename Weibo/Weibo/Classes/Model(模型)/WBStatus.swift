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
    
    //微博配图模型数组
    var pic_urls : [WBStatusPicture]?
    
    //转发
    var reposts_count : Int = 0
    //评论
    var comments_count : Int = 0
    //赞
    var attitudes_count : Int = 0
    
    //重写description计算型属性
    override var description: String {
        return yy_modelDescription()
    }
    ///github中找到此方法--返回容器类中的所需要存放的数据类型 (以 Class 或 Class Name 的形式)。
    /// 类函数 -> 告诉第三方框架 YY_Model 如果遇到数组类型的属性，数组中存放的对象是什么类
    /// NSArray 中保存对象的类型通常 'id' 类型
    /// OC 中的泛型是 Swift 推出后，苹果为了兼容给 OC 增加的，
    /// 从运行时角度，仍然不知道数组中应该存放什么类型的对象
    class func modelContainerPropertyGenericClass() -> [String: AnyClass] {
        return ["pic_urls": WBStatusPicture.self]
    }
}
