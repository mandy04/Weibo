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
 
 关于表格的性能优化:
 - 尽量少计算， 所有需要的素材提前计算好!
 - 控件上不要设置圆角半径，所有图像渲染的属性，都要注意!
 - 不要动态创建控件，所有需要的控件，都要提前创建好，在显示的时候，根据数据隐藏和显示！
 - Cell 中控件的层次越少越好，数量越少越好!
 - 要测量，不要猜测!
 */
class WBStatusViewModel : CustomStringConvertible{
    
    //微博模型
    var status : WBStatus?
    
    //会员图标 -存储型属性（用内存换CPU）
    var memberIcon : UIImage?
    
    /// 微博模型
    /// - 构造函数
    /// - Parameter model: 微博视图模型
    init(model: WBStatus) {
        self.status = model
        //直接计算出会员图标/会员等级 0-6
        if (model.user?.mbrank)! > 0 && (model.user?.mbrank)! < 7 {
            let imageName = "common_icon_membership_level\(model.user?.mbrank ?? 1)"
            memberIcon = UIImage(named: imageName)
        }
    }
    var description: String {
        return status!.description
    }
}
