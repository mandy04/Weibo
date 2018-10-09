//
//  CZRefreshControl.swift
//  Weibo
//
//  Created by Smile on 2018/10/10.
//  Copyright © 2018年 llbt. All rights reserved.
//

import UIKit

class CZRefreshControl: UIControl {

    
    /// MARK: - h属性
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
    
    /// 所有KVO统一调用此方法
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
