//
//  NSString+NSDate.swift
//  IsisCalendar
//
//  Created by jorge Sanmartin on 10/9/15.
//  Copyright (c) 2015 isis. All rights reserved.
//

import Foundation

extension NSString{
    
    ///
    /// Formatt string to date using format "yyyy-MM-dd'T'HH:mm:ss+ss:ss"
    ///
    
    func toDateTime() -> NSDate{
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss+ss:ss"
        dateFormatter.timeZone = NSTimeZone.localTimeZone()
        let stringDate = self as String
        let date = dateFormatter.dateFromString(stringDate)
        return date!
    }
}