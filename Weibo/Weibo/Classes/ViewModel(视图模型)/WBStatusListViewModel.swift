//
//  WBStatusListViewModel.swift
//  Weibo
//
//  Created by Smile on 2018/8/4.
//  Copyright © 2018年 llbt. All rights reserved.
//

import Foundation

//微博列表视图模型
/*父类的选择：
 --如果类需要使用‘KVC’或者字典转模型设置对象值，类就需要继承NSObject
 --如果类只是包装了一些代码逻辑，可以不用任何父类，好处：更轻量级；
 --提示：如果用OC写，一般都集成NSObject
 *
 */


//使命：负责微博数据处理
//1. 字典转模型
//2. 下拉/上拉数据处理


class WBStatusListViewModel {
    
    //微博模型数组懒加载
    lazy var  statusList = [WBStatus]()
    
    /// 加载微博列表，完成回调
    ///
    /// - Parameter completion: 完成回调[网络请求是否成功]
    func loadStatus(completion: @escaping (_ isSuccess : Bool) -> ()) {
        
        WBNetWorkManager.shared.statusList { (list, isSuccess) in
            
           /// BUG：使用YYModel，字典中有值，但是字典转模型之后，模型中没有值：
          ///解决方法：在build setting -> swift 3 @objc inference -> on 然后在swift4里面就可以使用了
            //1. 字典转模型
            guard let array = NSArray.yy_modelArray(with: WBStatus.classForCoder(), json: list ?? []) as? [WBStatus] else {
                completion(isSuccess)
                return
            }

            //2. 拼接数组
            self.statusList += array
            
            //3. 完成回调
            completion(isSuccess)
        }
    }
}
