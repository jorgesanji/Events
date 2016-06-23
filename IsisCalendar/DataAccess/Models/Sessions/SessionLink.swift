//
//  EventLinks.swift
//  IsisCalendar
//
//  Created by jorge Sanmartin on 8/9/15.
//  Copyright (c) 2015 isis. All rights reserved.
//

import Foundation

class SessionLink {
    
    var rel : String!
    var targetSchema : String!
    var href : String!
    
    static func parseSessionLink(item:NSDictionary)->SessionLink{
                
        let sessionLink = SessionLink()
        if let rel = item["rel"] as? String{
            sessionLink.rel = rel
        }
        if let targetSchema = item["targetSchema"] as? String{
            sessionLink.targetSchema = targetSchema
        }
        
        if let href = item["href"] as? String{
            sessionLink.href = href
        }
        
        return sessionLink
    }
}