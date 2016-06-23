//
//  Folder.swift
//  IsisCalendar
//
//  Created by jorge Sanmartin on 9/9/15.
//  Copyright (c) 2015 isis. All rights reserved.
//

import Foundation

class EventFolder{
    var name:NSString!
    var items:NSArray!
    
    static func parseFolder(item:NSDictionary) -> EventFolder{
                
        let folder = EventFolder()
        folder.name = item["name"] as! String
        
        if let items = item["items"] as? NSArray{
            let folderItems = NSMutableArray.new()
            for item in items{
                let folderItem = EventFolderItem.parseItem(item as! NSDictionary)
                folderItems.addObject(folderItem)
            }
            
            var sortedArray = folderItems.sortedArrayUsingComparator {
                (obj1, obj2) -> NSComparisonResult in
                let p1 = obj1 as! EventFolderItem
                let p2 = obj2 as! EventFolderItem
                let result = p1.startDate.compare(p2.startDate)
                return result
            }
            
            folder.items = sortedArray
        }
        return folder
    }

}