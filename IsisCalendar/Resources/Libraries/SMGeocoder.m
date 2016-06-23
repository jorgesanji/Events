//
//  SMGeocoder.m
//
//  Created by Jorge Sanmartin on 08/07/15.
//  Copyright (c) 2015 AXA Group Solutions. All rights reserved.
//

#import "SMGeocoder.h"
#import "NSInvocation+SMNSInvocation.h"

#define KRetrieveDelay 0.8f
#define KRetrieveMax 1

@interface SMGeocoder()
@property (nonatomic, strong) CLGeocoder *gecoder;
@property (nonatomic, strong) NSOperationQueue *queue;
@property (nonatomic, strong) NSInvocation *invocation;
@property (nonatomic) BOOL concurrent;
@end

@implementation SMGeocoder

- (id)init{
    self = [super init];
    if (self) {
        _gecoder = [[CLGeocoder alloc] init];
        _queue = [[NSOperationQueue alloc] init];
        [_queue setMaxConcurrentOperationCount:KRetrieveMax];
        _concurrent = NO;
    }
    return self;
}

#pragma mark Public Methods

- (void) retrievePlacesFromAddress:(NSString *)address completionHandler:(ArrayGeocodeResponseType)response{
    [self cancelBeforeOperations];
    SEL selector = @selector(retrieveDelayPlacesFromAddress:completionHandler:);
    _invocation = [NSInvocation invocationWithSelector:selector target:self params:@[address] completion:response];
    [_invocation retainArguments];
    [self sendRequest];
}

- (void) retrievePlacesFromLocation:(CLLocation *)location completionHandler:(ArrayGeocodeResponseType)response{
    [self cancelBeforeOperations];
    SEL selector = @selector(retrieveDelayPlacesFromLocation:completionHandler:);
    _invocation = [NSInvocation invocationWithSelector:selector target:self params:@[location] completion:response];
    [_invocation retainArguments];
    [self sendRequest];
}

#pragma mark Private Methods

- (void) sendRequest{
    if (_concurrent) {
        NSInvocationOperation* operation = [[NSInvocationOperation alloc] initWithInvocation:_invocation];
        [_queue addOperation:operation];
    }else{
        [_invocation invokeWithDelay:KRetrieveDelay];
    }
}

- (void)cancelBeforeOperations{
    [_gecoder cancelGeocode];
    if (_concurrent) {
        [_queue cancelAllOperations];
    }else{
        if (_invocation) {
            [_invocation cancelInvokeMethod];
        }
    }
}

- (void)retrieveDelayPlacesFromAddress:(NSString *)address completionHandler:(ArrayGeocodeResponseType)response{

    [_gecoder geocodeAddressString:address completionHandler:^(NSArray *placemarks, NSError *error) {
        response(placemarks);
    }];
}

- (void) retrieveDelayPlacesFromLocation:(CLLocation *)location completionHandler:(ArrayGeocodeResponseType)response{
    [_gecoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
        response(placemarks);
    }];
}

@end
