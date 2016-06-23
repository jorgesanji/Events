//
//  UIView+Click.swift
//  IsisCalendar
//
//  Created by jorge Sanmartin on 9/9/15.
//  Copyright (c) 2015 isis. All rights reserved.
//

import Foundation


extension UIView{
    
    /// Add tap gesture
    ///
    /// :param: target: the class which response tap gesture
    /// :param: action: the method which is asigned to this gesture
    
    func setOnClick(target:AnyObject, action:Selector){
        let tapGesture = UITapGestureRecognizer(target: target, action: action)
        tapGesture.numberOfTapsRequired = 1
        tapGesture.cancelsTouchesInView = true
        tapGesture.delaysTouchesBegan = true
        self.addGestureRecognizer(tapGesture)
    }

}