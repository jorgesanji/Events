//
//  EventImage.swift
//  IsisCalendar
//
//  Created by jorge Sanmartin on 8/9/15.
//  Copyright (c) 2015 isis. All rights reserved.
//

import Foundation

class SessionImage{
    
    var imageId: String!
    var width: NSNumber!
    var height: NSNumber!
    var tags: NSArray!
    var links: NSArray!
    
    static func parseSessionImage(item:NSDictionary) -> SessionImage{
                
        let sessionImage = SessionImage()
        sessionImage.imageId = item["imageId"] as! String
        
        if let height = item["height"] as? NSNumber {
            sessionImage.width = height
        }
        
        if let width = item["width"] as? NSNumber {
            sessionImage.width = width
        }
        
        if let annotations = item["annotations"] as? NSDictionary {
            if let tags = annotations["tags"] as? NSArray {
                sessionImage.tags = tags
            }
        }
        
        if let imagelinks = item["links"] as? NSArray{
            let itemsLinks = NSMutableArray.new()
            for link in imagelinks {
                let sessionLink = SessionImageLink.parseImageLink(link as! NSDictionary);
                itemsLinks.addObject(sessionLink)
            }
            
            sessionImage.links = itemsLinks
        }

        
        return sessionImage
    }
}