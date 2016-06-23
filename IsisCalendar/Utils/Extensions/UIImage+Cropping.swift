//
//  UIImage+Cropping.swift
//  IsisCalendar
//
//  Created by jorge Sanmartin on 8/9/15.
//  Copyright (c) 2015 isis. All rights reserved.
//

import Foundation

extension UIImage {
    
    /// Create a round image
    ///
    /// :param: size: size for create a round image
    
    func cropToCircleWithSize(size:CGSize) -> UIImage {
        let imageCurrent = self;
        let rect = CGRect(origin: CGPointZero, size: size)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0)
        let path = UIBezierPath(roundedRect: rect, cornerRadius: size.height/2)
        path.addClip()
        imageCurrent.drawInRect(rect)
        return UIGraphicsGetImageFromCurrentImageContext()
    }
    
    /// Create a image with a color
    ///
    /// :param: color: color to fill the image
    /// :param: size: size for create a round image
    
    static func imageWithColor(color: UIColor, size: CGSize) -> UIImage {
        let rect = CGRectMake(0, 0, size.width, size.height)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        color.setFill()
        UIRectFill(rect)
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}