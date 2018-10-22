//
//  CZRefreshControl.swift
//  Weibo
//
//  Created by Smile on 2018/10/10.
//  Copyright © 2018年 llbt. All rights reserved.
//

import UIKit

class CZRefreshControl: UIControl {

    
    /// MARK: - 属性
    //刷新控件的父视图，下拉刷新控件应该适用于 UITableView/ UICollectionview
    private weak var scrollView: UIScrollView?
    lazy var refreshControll : CZRefreshControl = CZRefreshControl()
    
    ///构造函数
    override init(frame: CGRect) {
        super.init(frame: CGRect())
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }
    
    /// willMove addSubview会调用
    /// - 当添加到父视图的时候，newSuperview是父视图
    /// - 当父视图被移除，newSuperview为nil
    /// - Parameter newSuperview
    override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        //判断父视图的类型
        guard let sv = newSuperview as? UIScrollView else {
            return
        }
        
        //记录父视图
        scrollView = sv
        
        // KVO监听父视图的contentOffset
        scrollView?.addObserver(self, forKeyPath: "contentOffset", options: [], context: nil)
        
    }
    // 本视图从父视图移除
    // 提示：所有的下拉刷新框架都是监听父视图的contentOffset
    // 所有框架的KVO实现思路都是如此！
    override func removeFromSuperview() {
        //superView 还存在
        superview?.removeObserver(self, forKeyPath: "contentOffset")
        
        super.removeFromSuperview()
        //superView 不存在
    }
    
    /// 所有KVO统一调用此方法
    // 在程序中，通常只监听某一个对象的几个属性，否则会很乱！
    // 观察者模式，在不需要的时候，都需要释放！
    // - 通知中心：如果不释放，什么都不会发生，但是会有内存泄漏，会有多次注册的可能！
    // - KVO：如果不释放，会崩溃！
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        //contentInset 的 y 值跟contentInset 的 top 有关
        print(scrollView?.contentInset ?? 0)
        
        guard let sv = scrollView else {
            return
        }
        //初始高度应该是0
        let height = -(sv.contentInset.top + sv.contentOffset.y)
        
        //根据高度设置刷新控件的frame
        self.frame = CGRect(x: 0,
                            y: -height,
                            width: sv.bounds.width,
                            height: height)
    }
    
    
     /// 开始刷新
    func beginRefreshing(){
        print("开始刷新")
    }
    
    
     /// 结束刷新
    func endRefreshing(){
        print("结束刷新")
    }

}

extension CZRefreshControl {
    private func setupUI() {
        backgroundColor = UIColor.orange
    }
}
