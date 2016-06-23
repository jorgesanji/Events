//
//  CDEventLink.swift
//  
//
//  Created by Jorge Sanmartin on 10/09/15.
//
//

import Foundation
import CoreData

@objc(CDEventLink)
class CDEventLink: NSManagedObject {

    @NSManaged var link: String
    @NSManaged var targetSchema: String
    @NSManaged var event: CDEvent

}
