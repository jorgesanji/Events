//
//  NSDate+String.swift
//  IsisCalendar
//
//  Created by jorge Sanmartin on 10/9/15.
//  Copyright (c) 2015 isis. All rights reserved.
//

import Foundation


extension NSDate{
    
    ///
    /// Formatter date using formatt "MMM d, h:mm:a"
    ///
    
    func toString()->String{
        let formatter = NSDateFormatter();
        formatter.dateFormat = "MMM d, h:mm a";
        formatter.timeZone = NSTimeZone.defaultTimeZone()
        let date = formatter.stringFromDate(self) as String;
        return date
    }
}