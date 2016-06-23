//
//  AppDelegate+CoreData.swift
//  IsisCalendar
//
//  Created by Jorge Sanmartin on 10/09/15.
//  Copyright (c) 2015 isis. All rights reserved.
//

import Foundation

extension AppDelegate{

    func initMagicalRecord(){
        MagicalRecord.setupCoreDataStack()
    }
}