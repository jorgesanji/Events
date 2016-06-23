//
//  Event.swift
//  IsisCalendar
//
//  Created by jorge Sanmartin on 8/9/15.
//  Copyright (c) 2015 isis. All rights reserved.
//

import Foundation
import CoreLocation

class Session{
    var packItemIdString: String!
    var title: String!
    var content: String!
    var subTitle: String!
    var startDate: NSDate!
    var endDate: NSDate!
    var links: NSArray!
    var folders: NSArray!
    var images: NSArray!
    
    static func parseSession(item:NSDictionary) -> Session{
                
        let list = item["list"] as! NSDictionary
        
        let session = Session()
        
        if let packItemIdString = item["packItemIdString"] as? String{
            session.packItemIdString = packItemIdString
        }
        
        
        if let header = list["header"] as? NSDictionary{
            if let title = header["title"] as? String{
                session.title = (title as NSString).removeHtmlTags() as String
            }
            
            if let subtitle = header["subTitle"] as? String{
                session.subTitle = (subtitle as NSString).removeHtmlTags() as String
            }
            
            if let content = header["content"] as? String{
                session.content =  (content as NSString).removeHtmlTags() as String
            }
            
            if let startDate = header["startDate"] as? NSString{
                session.startDate = startDate.toDateTime()
            }
            
            if let endDate = header["endDate"] as? NSString{
                session.startDate = endDate.toDateTime()
            }
            
            if let headerImages = header["images"] as? NSArray{
                let images = NSMutableArray.new()
                for image in headerImages{
                    let imageLink = SessionImage.parseSessionImage(image as! NSDictionary)
                    images.addObject(imageLink)
                }
                session.images = images
            }
        }
        

        
        if let links = list["links"] as? NSArray{
            let eventLinks = NSMutableArray.new()
            for link in links{
                let eventLink = SessionLink.parseSessionLink(link as! NSDictionary)
                eventLinks.addObject(eventLink)
            }
            session.links = eventLinks
        }
        
        if let folders = list["folders"] as? NSDictionary{
            if let folderItems = folders["items"] as? NSArray{
                let foldersContainer = NSMutableArray.new()
                for item in folderItems{
                    let folder = SessionFolder.parseFolder(item as! NSDictionary)
                    foldersContainer.addObject(folder)
                }
                session.folders = foldersContainer
            }
        }
        
        return session
    }
}