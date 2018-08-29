//
//  WBNewFeatureView.swift
//  Weibo
//
//  Created by Smile on 2018/8/25.
//  Copyright © 2018年 llbt. All rights reserved.
//

import UIKit

class WBNewFeatureView: UIView {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var enterButton: UIButton!
    @IBAction func enterButton(_ sender: UIButton) {
    }
    
    override init(frame: CGRect) {
        super.init(frame: CGRect())
        backgroundColor = UIColor.red
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
