//
//  NSString+Html.swift
//  IsisCalendar
//
//  Created by jorge Sanmartin on 10/9/15.
//  Copyright (c) 2015 isis. All rights reserved.
//

import Foundation

extension NSString{
    
    ///
    /// Remove all html tags from this string
    ///

    func removeHtmlTags()-> NSString{
    
        let regex:NSRegularExpression  = NSRegularExpression(
            pattern: "<.*?>",
            options: NSRegularExpressionOptions.CaseInsensitive,
            error: nil)!
        
        let range = NSMakeRange(0, self.length)
        let htmlLessString :String = regex.stringByReplacingMatchesInString(self as String,
            options: NSMatchingOptions.allZeros,
            range:range ,
            withTemplate: "")
        
         return htmlLessString
    }
}