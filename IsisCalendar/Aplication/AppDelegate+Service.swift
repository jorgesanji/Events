//
//  AppDelegate+Service.swift
//  IsisCalendar
//
//  Created by jorge Sanmartin on 7/9/15.
//  Copyright (c) 2015 isis. All rights reserved.
//

import Foundation

extension AppDelegate{
    
    func initService(){
        ManagerService.initWithAuthorizationCredentials(Constants.USER, password: Constants.PASSWORD)
    }
}