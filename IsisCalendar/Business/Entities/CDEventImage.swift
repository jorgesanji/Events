//
//  CDEventImage.swift
//  
//
//  Created by Jorge Sanmartin on 10/09/15.
//
//

import Foundation
import CoreData

@objc(CDEventImage)
class CDEventImage: NSManagedObject {

    @NSManaged var imageId: String
    @NSManaged var link: String
    @NSManaged var event: CDEvent

}
