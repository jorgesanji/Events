//
//  EventImageLink.swift
//  IsisCalendar
//
//  Created by jorge Sanmartin on 8/9/15.
//  Copyright (c) 2015 isis. All rights reserved.
//

import Foundation

class EventImageLink{
    
    var rel: String!
    var href: String!
    var mediaType: String!
    
    static func parseImageLink(item:NSDictionary) -> EventImageLink{
                
        let imageLink = EventImageLink()
        if let rel = item["rel"] as? String {
            imageLink.rel = rel
        }
        
        if let rel = item["rel"] as? String {
            imageLink.rel = rel
        }

        if let href = item["href"] as? String {
            imageLink.href = href
        }
        
        if let mediaType = item["mediaType"] as? String {
            imageLink.mediaType = mediaType
        }

        return imageLink
    }
    
}