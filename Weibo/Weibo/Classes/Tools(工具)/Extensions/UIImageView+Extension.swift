//
//  UIImageView+Extension.swift
//  Weibo
//
//  Created by Smile on 2018/9/3.
//  Copyright © 2018年 llbt. All rights reserved.
//

import Foundation

extension UIImageView {
    
    /// 隔离SDWebImage，设置头像
    ///
    /// - Parameters:
    ///   - urlString:  urlString
    ///   - placeholderImage: 占位图
    ///   -isAvatar: 是否头像
    func cz_setImage(urlString: String?,placeholderImage:UIImage?, isAvatar:Bool = false) {
        //处理url
        guard let urlString = urlString,
              let url = URL(string: urlString) else {
            //设置占位图
            image = placeholderImage
            return
        }
        //可选项只是用在swift，oc有的时候用！，同样可以使用nil  [weak self] --避免循环使用
        sd_setImage(with: url, placeholderImage: placeholderImage, options: []) {[weak self] (image, _, _, _) in
            
            //完成回调，判断是否是头像
            if isAvatar {
                self?.image = image?.cz_avatarImage(size: self?.bounds.size)
            }
        }
    }
}
