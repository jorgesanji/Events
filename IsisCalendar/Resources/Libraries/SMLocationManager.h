//
//  SMLocationManager.h
//
//  Created by Jorge Sanmartin on 09/07/15.
//  Copyright (c) 2015 AXA Group Solutions. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

typedef void (^LocationAllow)(BOOL);

typedef enum {
    KAUTH_REQUEST_AVAILABLE = 1000,
    KAUTH_REQUEST_NO_AVAILABLE = 1001,
    KAUTH_USER_RESTRICTED = kCLAuthorizationStatusRestricted,
    KAUTH_USER_DENIED = kCLAuthorizationStatusDenied,
    KAUTH_USER_NOT_DETERMINED = kCLAuthorizationStatusNotDetermined
} KAUTH_STATUS_USER_LOCATION;

typedef enum {
    KLOCATION_ALWAYS = 1000,
    KLOCATION_ONLY_USER_ACTIVE = 1001,
} KLOCATION_MODE;

@interface SMLocationManager : NSObject

+ (BOOL) isUserLocationEnabled;
+ (void) startLocationAlways;
+ (void) startLocationUserActive;
+ (void) startUpdateUserLocation;
+ (void) stopUpdateUserLocation;
+ (CLLocation *) userLocation;


@end
