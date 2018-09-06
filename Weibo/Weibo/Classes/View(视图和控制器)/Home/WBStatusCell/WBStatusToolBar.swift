//
//  WBStatusToolBar.swift
//  Weibo
//
//  Created by Smile on 2018/9/6.
//  Copyright © 2018年 llbt. All rights reserved.
//

import UIKit

class WBStatusToolBar: UIView {
    
    var viewModel: WBStatusViewModel? {
        didSet{
            retweetedButton.setTitle("\(viewModel?.retweetStr ?? "")", for: [])
            commentButton.setTitle("\(viewModel?.commentStr ?? "")", for: [])
            likeButton.setTitle("\(viewModel?.likeStr ?? "")", for: [])
        }
    }

    /// 转发
    @IBOutlet weak var retweetedButton: UIButton!
    /// 评论
    @IBOutlet weak var commentButton: UIButton!
    /// 赞
    @IBOutlet weak var likeButton: UIButton!


}
