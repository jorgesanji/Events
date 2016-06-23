//
//  Event.swift
//  IsisCalendar
//
//  Created by jorge Sanmartin on 8/9/15.
//  Copyright (c) 2015 isis. All rights reserved.
//

import Foundation
import CoreLocation

class Event{
    var packItemIdString: String!
    var title: String!
    var content: String!
    var subTitle: String!
    var startDate: NSDate!
    var endDate: NSDate!
    var location: CLLocationCoordinate2D!
    var addressCountry : String!
    var links: NSArray!
    var folders: NSArray!
    var images: NSArray!
    var tags: NSArray!

    static func parseEvent(item:NSDictionary) -> Event{
        
        let event = Event()
        
        if let list = item["list"] as? NSDictionary{
            
            event.packItemIdString = item["packItemIdString"] as! String
            
            if let header = list["header"] as? NSDictionary{
                
                if let title = header["title"] as? String{
                    event.title = (title as NSString).removeHtmlTags() as String
                }
                
                if let subTitle = header["subTitle"] as? String{
                    event.subTitle = (subTitle as NSString).removeHtmlTags() as String
                }
                
                if let content = header["content"] as? String{
                    event.content = (content as NSString).removeHtmlTags() as String
                }
                
                if let headerImages = header["images"] as? NSArray{
                    let images = NSMutableArray.new()
                    for image in headerImages{
                        let imageLink = EventImage.parseEventImage(image as! NSDictionary)
                        images.addObject(imageLink)
                    }
                    event.images = images
                }
            }
            
            
            if let annotations = list["annotations"] as? NSDictionary{
                
                if let tags = annotations["tags"] as? NSArray{
                    event.tags = tags
                }
                
                if let restEvent = annotations["event"] as? NSDictionary{
                    
                    if let startDate = restEvent["startDate"] as? NSString{
                        event.startDate = startDate.toDateTime()
                    }
                    
                    if let endDate = restEvent["endDate"] as? NSString{
                        event.endDate = endDate.toDateTime()
                    }
                    
                    if let restEventLocation = restEvent["location"] as? NSDictionary{
                        if let restEventLocationGeo = restEventLocation["geo"] as? NSDictionary{
                            event.location = CLLocationCoordinate2D(latitude: restEventLocationGeo["latitude"] as!
                                CLLocationDegrees, longitude: restEventLocationGeo["longitude"] as! CLLocationDegrees)
                            if let restEventLocationAdress = restEventLocation["address"] as? NSDictionary{
                                event.addressCountry = restEventLocationAdress["addressCountry"] as! String
                            }
                        }
                    }
                }
                
            }
            
            if let links = item["links"] as? NSArray{
                let eventLinks = NSMutableArray.new()
                for link in links{
                    let eventLink = EventLink.parseEventLink(link as! NSDictionary)
                    eventLinks.addObject(eventLink)
                }
                event.links = eventLinks
            }
            
            if let folders = list["folders"] as? NSArray{
                let foldersContainer = NSMutableArray.new()
                for item in folders{
                    let folder = EventFolder.parseFolder(item as! NSDictionary)
                    foldersContainer.addObject(folder)
                }
                event.folders = foldersContainer
            }
        }
        
        return event
    }
}