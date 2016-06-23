//
//  SMLocationManager.m
//
//  Created by Jorge Sanmartin on 09/07/15.
//  Copyright (c) 2015 AXA Group Solutions. All rights reserved.
//

#import "SMLocationManager.h"

#define KDelayAlertLocation 0.3f

@interface SMLocationManager()<CLLocationManagerDelegate>
@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) CLLocation *userLocation;
@end

@implementation SMLocationManager

+ (SMLocationManager *)sharedInstance {
    static SMLocationManager *sharedInstance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [SMLocationManager new];
    });
    return sharedInstance;
}

- (id)init{
    self = [super init];
    if (self) {
        _locationManager = [CLLocationManager new];
        _locationManager.delegate = self;
    }
    return self;
}

#pragma mark - Private Methods

- (void) setlocationMode:(KLOCATION_MODE)mode{
    // Check for iOS 8. Without this guard the code will crash with "unknown selector" on iOS 7.
    BOOL iOS8 = floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_7_1;
    switch (mode) {
        case KLOCATION_ALWAYS:
            if (iOS8) {
                [self.locationManager requestAlwaysAuthorization];
            }
            break;
        case KLOCATION_ONLY_USER_ACTIVE:
            if (iOS8) {
                [self.locationManager requestWhenInUseAuthorization];
            }
        default:
            break;
    }
}

- (void) setAppWithLocationMode:(KLOCATION_MODE)mode{
    
    // Used only for iOS 8 SDK
    // requestAlwaysAuthorization : used to retrieve the user location including background aplication state.
    // requestWhenInUseAuthorization :  used to retrieve the user location only in foreground aplication state.
    
    NSAssert(_locationManager,@"Location manager not initialized");
    
    KAUTH_STATUS_USER_LOCATION auth = [SMLocationManager statusLocation];
    if (auth == KAUTH_USER_NOT_DETERMINED) {
        [self setlocationMode:mode];
        //start request location
        [[self class] startUpdateUserLocation];
    }else if (auth == KAUTH_USER_DENIED){
        [[self class]  startUpdateUserLocation];
    }else if (auth == KAUTH_REQUEST_AVAILABLE){
        [[self class]  startUpdateUserLocation];
    }
}


#pragma mark - LocationManager Methods

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    if ([SMLocationManager isUserLocationEnabled]) {
        [[self class]  startUpdateUserLocation];
    }
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    _userLocation = [locations lastObject];
}

+ (KAUTH_STATUS_USER_LOCATION) statusLocation {
    if ([CLLocationManager locationServicesEnabled]) {
        // Location Services Are Enabled
        switch ([CLLocationManager authorizationStatus]) {
            case kCLAuthorizationStatusNotDetermined:
                // User has not yet made a choice with regards to this application
                return KAUTH_USER_NOT_DETERMINED;
                break;
            case kCLAuthorizationStatusRestricted:
                // This application is not authorized to use location services.  Due
                // to active restrictions on location services, the user cannot change
                // this status, and may not have personally denied authorization
                return KAUTH_USER_RESTRICTED;
                break;
            case kCLAuthorizationStatusDenied:
                // User has explicitly denied authorization for this application,
                // or location services are disabled in Settings
                return KAUTH_USER_DENIED;
                break;
            default:
                // User has authorized this application to use location services
                return KAUTH_REQUEST_AVAILABLE;
                break;
        }
    } else {
        return KAUTH_REQUEST_NO_AVAILABLE;
    }
}

#pragma mark - Public 

+ (BOOL) isUserLocationEnabled {
    return [SMLocationManager statusLocation] == KAUTH_REQUEST_AVAILABLE;
}

+ (void)startUpdateUserLocation{
    if ([self sharedInstance].locationManager) {
        [[self sharedInstance].locationManager startUpdatingLocation];
    }
}

+ (void)stopUpdateUserLocation{
    if ([self sharedInstance].locationManager) {
        [[self sharedInstance].locationManager stopUpdatingLocation];
    }
}

+ (void)startLocationAlways{
    [[self sharedInstance] setAppWithLocationMode:KLOCATION_ALWAYS];
}

+ (void)startLocationUserActive{
    [[self sharedInstance] setAppWithLocationMode:KLOCATION_ONLY_USER_ACTIVE];
}

+ (CLLocation *)userLocation{
    return [self sharedInstance].userLocation;
}

@end
