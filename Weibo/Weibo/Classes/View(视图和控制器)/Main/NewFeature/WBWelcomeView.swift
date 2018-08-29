//
//  WBWelcomView.swift
//  Weibo
//
//  Created by Smile on 2018/8/25.
//  Copyright © 2018年 llbt. All rights reserved.
//

import UIKit
//import SDWebImage

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
    
    // 提示：initWithaDecoder 是刚刚从 XIB 二进制文件将试图数据加载完成
    // 还没有跟代码连线建立起关系，所以开发时，不要在此方法中 处理UI   ----相当于initWithFrame（无XIB时）
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        print("initWithaDecoder + \(iconView)")
    }
    
    override func awakeFromNib() {
        print("awakeFromNib + \(iconView)")
        //1. url
        guard let urlString = WBNetWorkManager.shared.userAccount.avatar_large,
              let url = URL.init(string: urlString)
        else {
            return
        }
        
        //2. 设置头像，如果网络没有下载完成，先使用占位图
        // 如果不使用占位图，之前设置的图像会被清空
//        iconView.sd_s
       //FIXME：
        
        //3. 设置圆角
        //FIXME
        
    }
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
        UIView.animate(withDuration: 1.0,
                       delay: 0,
                       usingSpringWithDamping: 0.7,//弹力系数
                       initialSpringVelocity: 0,//初始速度
                       options: [], animations: {
            //更新约束
            self.layoutIfNeeded()
        }) { (_) in
            UIView.animate(withDuration: 1.0, animations: {
                self.tipLabel.alpha = 1
            }, completion: { (_) in
                self.removeFromSuperview()
            })
        }
    }
}
