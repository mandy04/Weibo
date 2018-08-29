//
//  WBWelcomView.swift
//  Weibo
//
//  Created by Smile on 2018/8/25.
//  Copyright © 2018年 llbt. All rights reserved.
//

import UIKit

class WBWelcomeView: UIView {

    class func welcomeView() -> WBWelcomeView {
        
        let nib = UINib(nibName: "WBWelcomeView", bundle: nil)
        
        let v = nib.instantiate(withOwner: nil, options: nil)[0] as! WBWelcomeView
        
        // 从 XIB 加载的视图，默认是 600 * 600
        v.frame = UIScreen.main.bounds
        
        return v
    }
    
   
}
