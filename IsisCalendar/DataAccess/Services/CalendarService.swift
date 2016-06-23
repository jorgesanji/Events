//
//  CalendarService.swift
//  IsisCalendar
//
//  Created by jorge Sanmartin on 7/9/15.
//  Copyright (c) 2015 isis. All rights reserved.
//

import Foundation

class CalendarService {
    
    /// Get all events and parse each one to Event model
    ///
    /// :param: url detail event
    /// :param: success callback success
    /// :param: failure callback failure
    
    static func getEventList(success:TypeResponse, failure:ErrorResponse){
        let calendaryEndpoint  = Constants.URL_EVENTS
        ManagerService.getWithUrl(calendaryEndpoint, parameters: nil, success: { (result) -> Void in
            dispatch_async(dispatch_get_global_queue(Int(QOS_CLASS_USER_INITIATED.value), 0)) {
                let items = NSMutableArray.new()
                for item in result as! NSArray{
                    let event = Event.parseEvent(item as! NSDictionary)
                    items.addObject(event)
                }
                
                dispatch_async(dispatch_get_main_queue()) {
                    success(result: items)
                }
                
            }
            }, failure:failure)
    }
    
    /// Get event detail and parse to Event model
    ///
    /// :param: url detail event
    /// :param: success callback success
    /// :param: failure callback failure
    
    static func getEventDetail(url:NSString, success:TypeResponse, failure:ErrorResponse){
        ManagerService.getWithUrl(url, parameters: nil, success: { (result) -> Void in
            dispatch_async(dispatch_get_global_queue(Int(QOS_CLASS_USER_INITIATED.value), 0)) {
                let eventDetail = Event.parseEvent(result as! NSDictionary)
                dispatch_async(dispatch_get_main_queue()) {
                    success(result:eventDetail)
                }
            }
            }, failure:failure)
    }
    
    
    /// Get session detail and parse to Session model
    ///
    /// :param: url detail event
    /// :param: success callback success
    /// :param: failure callback failure
    
    static func getSessionDetail(url:NSString, success:TypeResponse, failure:ErrorResponse){
        ManagerService.getWithUrl(url, parameters: nil, success: { (result) -> Void in
            
            dispatch_async(dispatch_get_global_queue(Int(QOS_CLASS_USER_INITIATED.value), 0)) {
                let eventDetail = Session.parseSession(result as! NSDictionary)
                dispatch_async(dispatch_get_main_queue()) {
                    success(result:eventDetail)
                }
            }
            }, failure:failure)
    }
}