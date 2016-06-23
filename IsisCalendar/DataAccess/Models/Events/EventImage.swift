//
//  EventImage.swift
//  IsisCalendar
//
//  Created by jorge Sanmartin on 8/9/15.
//  Copyright (c) 2015 isis. All rights reserved.
//

import Foundation

class EventImage{
    
    var imageId: String!
    var width: NSNumber!
    var height: NSNumber!
    var tags: NSArray!
    var links: NSArray!
    
    static func parseEventImage(item:NSDictionary) -> EventImage{
                
        let eventImage = EventImage()
        eventImage.imageId = item["imageId"] as! String
        
        if let height = item["height"] as? NSNumber {
            eventImage.width = height
        }
        
        if let width = item["width"] as? NSNumber {
            eventImage.width = width
        }
        
        if let annotations = item["annotations"] as? NSDictionary {
            if let tags = annotations["tags"] as? NSArray {
                eventImage.tags = tags
            }
        }
        
        let imagelinks = item["links"] as! NSArray
        let itemsLinks = NSMutableArray.new()
        for link in imagelinks {
            let eventLink = EventImageLink.parseImageLink(link as! NSDictionary);
            itemsLinks.addObject(eventLink)
        }
        
        eventImage.links = itemsLinks
        
        return eventImage
    }
}