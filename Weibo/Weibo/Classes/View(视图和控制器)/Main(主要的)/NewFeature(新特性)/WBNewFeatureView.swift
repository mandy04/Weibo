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
        removeFromSuperview()
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
        
        scrollView.delegate = self
        
        //隐藏按钮
        enterButton.isHidden = true
    }

}

extension WBNewFeatureView : UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        //1. 滚动到最后一屏，视图删除
        let page = Int(scrollView.contentOffset.x / scrollView.bounds.width)
        
        //2. 判断是否是最后一页
        if page == scrollView.subviews.count {
            removeFromSuperview()
        }
        //3. 如果是倒数第二页，显示按钮
        enterButton.isHidden = (page != scrollView.subviews.count - 1 )
    }
    
   func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        //0. 一旦滚动，隐藏按钮
        enterButton.isHidden = true
        
        //1. 计算当前的偏移量
        let page = Int(scrollView.contentOffset.x / scrollView.bounds.width + 0.5)
        
        //2. 设置分页控件
        pageControl.currentPage = page
        
        //3. 分页控件的隐藏
        pageControl.isHidden = (page == scrollView.subviews.count)
    }
}
