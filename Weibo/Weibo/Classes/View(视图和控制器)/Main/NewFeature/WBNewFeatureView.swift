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
    
    class func newFeatureView() -> WBNewFeatureView {
        
        let nib = UINib(nibName: "WBNewFeatureView", bundle: nil)
        
        let v = nib.instantiate(withOwner: nil, options: nil)[0] as! WBNewFeatureView
        
        // 从 XIB 加载的视图，默认是 600 * 600
        v.frame = UIScreen.main.bounds
        return v
    }
    
    override func awakeFromNib() {
        print(bounds)
       //如果使用自动布局设置的界面，默认是600*600
        //添加4个图像视图
        let count = 4
        let rect = UIScreen.main.bounds
        for i in 0..<count {
            
            let imageName = "new_feature_\(i+1)"
            let iv = UIImageView.init(image: UIImage.init(named: imageName))
            
            //设置大小
            iv.frame = rect.offsetBy(dx: CGFloat(i) * rect.width, dy: 0)
            
            scrollView.addSubview(iv)
        }
        
        //指定scrollView的属性
        scrollView.contentSize = CGSize.init(width: CGFloat(count + 1) * rect.width, height: rect.height)
        
        scrollView.bounces = false
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        
        //隐藏按钮
        enterButton.isHidden = true
    }

}
