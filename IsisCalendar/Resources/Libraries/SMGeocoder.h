//
//  SMGeocoder.h
//
//  Created by Jorge Sanmartin on 08/07/15.
//  Copyright (c) 2015 AXA Group Solutions. All rights reserved.
//

#import <Foundation/Foundation.h>
@import CoreLocation;

@interface SMGeocoder : NSObject
typedef void (^ArrayGeocodeResponseType)(NSArray*);

- (void) cancelBeforeOperations;
- (void) retrievePlacesFromAddress:(NSString *)address completionHandler:(ArrayGeocodeResponseType)response;
- (void) retrievePlacesFromLocation:(CLLocation *)location completionHandler:(ArrayGeocodeResponseType)response;

@end
