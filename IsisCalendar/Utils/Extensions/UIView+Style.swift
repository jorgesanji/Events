//
//  UIView+Style.swift
//  IsisCalendar
//
//  Created by jorge Sanmartin on 9/9/15.
//  Copyright (c) 2015 isis. All rights reserved.
//

import Foundation

extension UIView{
    
    ///
    /// Make round corners using view layer
    ///
    /// :param: radius: radius for round our view
    ///
    
    func roundCornersWithRadius(radius:CGFloat){
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
    }
    
    ///
    /// Put border in view
    ///
    /// :param: color: border color
    /// :param: border: border width

    func putBorderWithColor(color:UIColor, border:CGFloat){
        self.layer.borderWidth = border
        self.layer.borderColor = color.CGColor
        self.layer.masksToBounds = true
    }
}