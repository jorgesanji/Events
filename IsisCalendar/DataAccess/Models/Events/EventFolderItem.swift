//
//  FolderItem.swift
//  IsisCalendar
//
//  Created by jorge Sanmartin on 9/9/15.
//  Copyright (c) 2015 isis. All rights reserved.
//

import Foundation

class EventFolderItem{
    
    var itemId: String!
    var title: String!
    var images: NSArray!
    var subTitle: NSString!
    var tags: NSArray!
    var startDate: NSDate!
    var endDate: NSDate!
    var links: NSArray!
    
    static func parseItem(item:NSDictionary) -> EventFolderItem{
        
        let folderItem = EventFolderItem()
        
        if let itemId = item["itemId"] as? String{
            folderItem.itemId = itemId
        }
        
        if let details = item["details"] as? NSDictionary{
            if let title = details["title"] as? String{
                folderItem.title = title
            }
            
            if let subTitle = details["subTitle"] as? String{
                folderItem.subTitle = subTitle
            }
            
            if let headerImages = details["images"] as? NSArray{
                let images = NSMutableArray.new()
                for image in headerImages{
                    let imageLink = EventImage.parseEventImage(image as! NSDictionary)
                    images.addObject(imageLink)
                }
                folderItem.images = images
            }
        }
        
        if let annotations = item["annotations"] as? NSDictionary{
            if let tags = annotations["tags"] as? NSArray{
                folderItem.tags = tags
            }
            if let restEvent = annotations["event"] as? NSDictionary{
                if let startDate = restEvent["startDate"] as? NSString{
                    folderItem.startDate = startDate.toDateTime()
                }
                
                if let endDate = restEvent["endDate"] as? NSString{
                    folderItem.endDate = endDate.toDateTime()
                }
            }
        }
        

        if let links = item["links"] as? NSArray{
            let eventLinks = NSMutableArray.new()
            for link in links{
                let eventLink = EventLink.parseEventLink(link as! NSDictionary)
                eventLinks.addObject(eventLink)
            }
            
            folderItem.links = eventLinks
        }
        
        return folderItem
    }
}