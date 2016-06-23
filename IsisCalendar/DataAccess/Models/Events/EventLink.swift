//
//  EventLinks.swift
//  IsisCalendar
//
//  Created by jorge Sanmartin on 8/9/15.
//  Copyright (c) 2015 isis. All rights reserved.
//

import Foundation

class EventLink {
    
    var rel : String!
    var targetSchema : String!
    var href : String!
    
    static func parseEventLink(item:NSDictionary)->EventLink{
            
        let eventLink = EventLink()
        if let rel = item["rel"] as? String{
            eventLink.rel = rel
        }
        if let targetSchema = item["targetSchema"] as? String{
            eventLink.targetSchema = targetSchema
        }
        
        if let href = item["href"] as? String{
            eventLink.href = href
        }
        
        return eventLink
    }
}