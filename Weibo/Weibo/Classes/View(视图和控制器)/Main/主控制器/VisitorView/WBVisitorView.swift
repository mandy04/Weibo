//
//  WBVisitorView.swift
//  Weibo
//
//  Created by Smile on 2018/3/14.
//  Copyright © 2018年 llbt. All rights reserved.
//

import UIKit

class WBVisitorView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//MARK: 设置界面
extension WBVisitorView {
    func setupUI() {
        backgroundColor = UIColor.white
    }
}
