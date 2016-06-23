//
//  AppStyles.swift
//  IsisCalendar
//
//  Created by jorge Sanmartin on 15/9/15.
//  Copyright (c) 2015 isis. All rights reserved.
//

import Foundation

class AppStyles {
    
    static func globalStyle(){
        UINavigationBar.appearance().titleTextAttributes = [NSFontAttributeName : UIFont.systemFontOfSize(20.0), NSForegroundColorAttributeName : UIColor.grayColor()]
        UINavigationBar.appearance().tintColor = primaryColorApp()
    }
    
    static func primaryColorApp()-> UIColor{
        return UIColor(red: 123.0/255.0, green: 69.0/255.0, blue: 137.0/255.0, alpha: 1.0)
    }
}