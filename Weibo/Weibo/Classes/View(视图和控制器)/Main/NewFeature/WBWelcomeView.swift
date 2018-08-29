//
//  WBWelcomView.swift
//  Weibo
//
//  Created by Smile on 2018/8/25.
//  Copyright © 2018年 llbt. All rights reserved.
//

import UIKit

class WBWelcomeView: UIView {

    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var tipLabel: UILabel!
    //底部约束
    @IBOutlet weak var bottomCons: NSLayoutConstraint!
    class func welcomeView() -> WBWelcomeView {
        
        let nib = UINib(nibName: "WBWelcomeView", bundle: nil)
        
        let v = nib.instantiate(withOwner: nil, options: nil)[0] as! WBWelcomeView
        
        // 从 XIB 加载的视图，默认是 600 * 600
        v.frame = UIScreen.main.bounds
        return v
    }
    
    //自动布局系统更新完成约束后，会自动调用此方法
    //通常是对子视图布局使用此方法
//    override func layoutSubviews() {
//    }
    
    
    /// 视图被添加到 Windows 上，表示视图已经显示
    override func didMoveToWindow() {
        super.didMoveToWindow()
        
        //视图是使用自动布局来设置的，只是设置了约束
        //--当视图被添加到窗口上时，根据父视图的大小，计算约束值，更新控件位置
        //--layoutIfNeeded会直接按照当前的约束直接更新控件位置
        //--执行之后，控件所在位置，就是 XIB 位置
        self.layoutIfNeeded()
        
        bottomCons.constant = bounds.size.height - 200
        
        //如果控件们的frame还没计算好，所有的约束回忆起动画
        UIView.animate(withDuration: 5.0,
                       delay: 0,
                       usingSpringWithDamping: 0.7,
                       initialSpringVelocity: 0,
                       options: [], animations: {
            //更新约束
            self.layoutIfNeeded()
        }) { (_) in
            
        }
        
    }

}
