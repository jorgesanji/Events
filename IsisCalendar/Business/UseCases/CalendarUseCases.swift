//
//  CalendarUseCases.swift
//  IsisCalendar
//
//  Created by Jorge Sanmartin on 10/09/15.
//  Copyright (c) 2015 isis. All rights reserved.
//

class CalendarUseCases {
    
    /// Get all events
    ///
    /// Save events in database using magical record (Only for demostration how to save data using this framework)
    ///
    /// :param: success callback success
    /// :param: failure callback failure
    
    static func getEventList(success:TypeResponse, failure:ErrorResponse){
       CalendarService.getEventList({ (result) -> Void in
        
        // Save model to core data objects
        MagicalRecord.saveWithBlock({ (context:NSManagedObjectContext!) -> Void in
            //Remove older events
            CDEvent.MR_truncateAllInContext(context)
            
            //Convert model to core data objects
            for item in result as! NSArray{
                let event = item as! Event
                event.toCoreDataWithContext(context)
            }
            }, completion: { (sucess:Bool, error:NSError!) -> Void in
                if sucess == false{
                    println("ERROR CORE DATA OBJECT")
                }else{
                    println("OK SAVE CORE DATA OBJECT")
                    // Get Events order by startDate
                    let events = CDEvent.MR_findAllSortedBy("startDate", ascending: true)
                    success(result: events)
                }
        })
        
       }, failure: { (error) -> Void in
            failure(error: error)
       })
    }
    
    /// Get event detail
    ///
    /// :param: url detail event
    /// :param: success callback success
    /// :param: failure callback failure
    
    static func getEventDetail(url:NSString, success:TypeResponse, failure:ErrorResponse){
        CalendarService.getEventDetail(url, success: { (result) -> Void in
            success(result: result)
        }) { (error) -> Void in
            failure(error: error)
        }
    }
    
    /// Get session detail
    ///
    /// :param: url session event
    /// :param: success callback success
    /// :param: failure callback failure
    
    static func getSessionDetail(url:NSString, success:TypeResponse, failure:ErrorResponse){
        CalendarService.getSessionDetail(url, success: { (result) -> Void in
            success(result: result)
        }) { (error) -> Void in
            failure(error: error)
        }
    }
}
