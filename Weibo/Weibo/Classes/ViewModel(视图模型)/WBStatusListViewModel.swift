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

//上拉刷新最大尝试次数
private let maxPullupTryTimes = 3

class WBStatusListViewModel {
    
    //微博模型数组懒加载
    lazy var  statusList = [WBStatus]()
    
    //上拉刷新错误次数
    private var pullUpErrorTimes = 0
    
    /// 加载微博列表，完成回调
    ///
    /// - Parameter completion: 完成回调[网络请求是否成功, 是否刷新表格]
    func loadStatus(pullUp:Bool, completion: @escaping (_ isSuccess : Bool , _ shouldRefresh : Bool) -> ()) {
        
        //判断是否上拉刷新，同时检查刷新次数
        if pullUp &&  pullUpErrorTimes > maxPullupTryTimes {
            completion(true , false)
        }
        
        //since_id 下拉，取出数组中第一条微博的id
        let since_id = pullUp ? 0 : (statusList.first?.id ?? 0)
        //max_id  上拉，取出数组中最后一条微博id
        let  max_id = !pullUp ? 0 : (statusList.last?.id ?? 0)
        
        WBNetWorkManager.shared.statusList(since_id: since_id, max_id: max_id){ (list, isSuccess) in
            
           /// BUG：使用YYModel，字典中有值，但是字典转模型之后，模型中没有值：
          ///解决方法：在build setting -> swift 3 @objc inference -> on 然后在swift4里面就可以使用了
            //1. 字典转模型 [所有第三方框架都支持字典转模型]
            guard let array = NSArray.yy_modelArray(with: WBStatus.classForCoder(), json: list ?? []) as? [WBStatus] else {
                completion(isSuccess , false)
                return
            }
            print("刷新到 \(array.count) 条数据 \(array)")
            //2. 拼接数组
            if pullUp { //上拉
                //刷新数组，将结果数组拼接在数组后面
                self.statusList += array
            }else {
                //刷新数组，将结果数组拼接在数组前面
                self.statusList = array + self.statusList
            }
            
            //3， 判断上拉刷新的数据量
            if pullUp && array.count == 0 {
                self.pullUpErrorTimes += 1
                completion(isSuccess , false)

            }else {
                //4. 完成回调
                completion(isSuccess , true)
            }
        }
    }
}
