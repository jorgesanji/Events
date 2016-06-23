//
//  CDEvent+Add.swift
//  IsisCalendar
//
//  Created by jorge Sanmartin on 10/9/15.
//  Copyright (c) 2015 isis. All rights reserved.
//

import Foundation

extension CDEvent{
    
    func addImage(image:CDEventImage) {
        let images = self.valueForKeyPath("images") as! NSMutableSet
        images.addObject(image)
    }
    
    func addTag(tag:CDEventTag) {
        let tags = self.valueForKeyPath("tags")as! NSMutableSet
        tags.addObject(tag)
    }
    
    func addLink(link:CDEventLink) {
        let links = self.valueForKeyPath("links") as! NSMutableSet
        links.addObject(link)
    }
    
    
}