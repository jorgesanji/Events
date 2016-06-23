//
//  CDEvent.swift
//  
//
//  Created by Jorge Sanmartin on 10/09/15.
//
//

import Foundation
import CoreData

@objc(CDEvent)
class CDEvent: NSManagedObject {

    @NSManaged var title: String
    @NSManaged var subTitle: String
    @NSManaged var content: String
    @NSManaged var packItemIdString: String
    @NSManaged var startDate: NSDate
    @NSManaged var endDate: NSDate
    @NSManaged var latitude: NSNumber
    @NSManaged var longitude: NSNumber
    @NSManaged var addressCountry: String
    @NSManaged var links: NSSet
    @NSManaged var tags: NSSet
    @NSManaged var images: NSSet
}
