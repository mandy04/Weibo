//
//  UIImage+Extension.swift
//  Weibo
//
//  Created by Smile on 2018/9/3.
//  Copyright © 2018年 llbt. All rights reserved.
//

import Foundation

extension UIImage {
    
    /// 创建头像图像      
    ///
    /// - Parameters:
    ///   - size: 尺寸
    ///   - backColor: 背景颜色
    ///   - lineColor: 线条颜色
    /// - Return: 返回裁切后的图像
    func cz_avatarImage(size: CGSize?, backColor: UIColor = UIColor.white, lineColor: UIColor = UIColor.lightGray) -> UIImage? {
        var size = size
        if size == nil {
            size = self.size
        }
        
        let rect = CGRect(origin: CGPoint(), size: size!)
        UIGraphicsBeginImageContextWithOptions(rect.size, true, 0)
        
        backColor.setFill()
        UIRectFill(rect)
        
        let path = UIBezierPath(ovalIn: rect)
        path.addClip()
        
        draw(in: rect)
        
        let ovalPath =  UIBezierPath(ovalIn: rect)
        ovalPath.lineWidth = 2
        lineColor.setStroke()
        ovalPath.stroke()
        
        let result = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return result
        
    }
}
