//
//  CDEventTag.swift
//  
//
//  Created by Jorge Sanmartin on 10/09/15.
//
//

import Foundation
import CoreData

@objc(CDEventTag)
class CDEventTag: NSManagedObject {

    @NSManaged var name: String
    @NSManaged var event: CDEvent

}
