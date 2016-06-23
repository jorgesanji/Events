//
//  NSInvocation+SMNSInvocation.h
//
//  Created by Jorge Sanmartin on 14/07/15.
//  Copyright (c) 2015 AXA Group Solutions. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SMGeocoder.h"
@import UIKit;

@interface NSInvocation (SMNSInvocation)
- (void) cancelInvokeMethod;
- (void) invokeWithDelay:(CGFloat) delay;
+ (instancetype)invocationWithSelector:(SEL)selector target:(id) target params:(NSArray *)params  completion:(ArrayGeocodeResponseType)response;
@end
