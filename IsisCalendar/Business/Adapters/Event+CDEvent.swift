//
//  Event+CDEvent.swift
//  IsisCalendar
//
//  Created by Jorge Sanmartin on 10/09/15.
//  Copyright (c) 2015 isis. All rights reserved.
//

import Foundation

extension Event{
    
    /// Convert a Event model to core data object "CDEvent"
    ///
    /// :param: context is current context which is used for create and save core data objects
    ///
    
    func toCoreDataWithContext(context:NSManagedObjectContext)-> CDEvent{
        let event = CDEvent.MR_createEntityInContext(context) as CDEvent
        event.title = self.title
        event.subTitle = self.subTitle
        event.content = self.content
        event.addressCountry = self.addressCountry
        event.startDate = self.startDate
        event.endDate = self.endDate
        event.latitude = self.location.latitude
        event.longitude = self.location.longitude
        
        for image in self.images{
            let restImage = image as! EventImage
            let idImage = restImage.imageId
            for itemImage in restImage.links{
                let imageLink = itemImage as! EventImageLink
                let cdImage = CDEventImage.MR_createEntityInContext(context) as CDEventImage
                cdImage.imageId = idImage
                cdImage.link = imageLink.href
                event.addImage(cdImage)
            }
        }

        for link  in self.links{
            let restLink = link as! EventLink
            let cdLink = CDEventLink.MR_createEntityInContext(context) as CDEventLink
            cdLink.link = restLink.href
            cdLink.targetSchema =  restLink.targetSchema
            event.addLink(cdLink)
        }

        for tag in self.tags{
            let restTag = tag as! String
            let cdTag = CDEventTag.MR_createEntityInContext(context) as CDEventTag
            cdTag.name = restTag
            event.addTag(cdTag)
        }
        
        return event
    }
    
    func toCoreData()-> CDEvent{
        let res = CDEvent.MR_createEntity() as CDEvent
        res.title = self.title
        return res
    }
}