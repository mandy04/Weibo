//
//  UIBarButtonItem+Extension.swift
//  Weibo
//
//  Created by Smile on 2018/3/10.
//  Copyright © 2018年 llbt. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    
    /// 抽取UIBarButtonItem
    ///
    /// - Parameters:
    ///   - title: 标题
    ///   - fontSize: 字体
    ///   - target: target
    ///   - action: action
     convenience  init(title: String, fontSize:CGFloat = 16, target: Any?, action: Selector) {
        
        let btn : UIButton = UIButton.cz_textButton(title, fontSize: fontSize, normalColor: UIColor.lightGray, highlightedColor: UIColor.orange)
        btn.addTarget(target, action: action, for: .touchUpInside)
        //实例化
        self.init(customView: btn)
    }
}
