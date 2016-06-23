//
//  NSInvocation+SMNSInvocation.m
//
//  Created by Jorge Sanmartin on 14/07/15.
//  Copyright (c) 2015 AXA Group Solutions. All rights reserved.
//

#import "NSInvocation+SMNSInvocation.h"

@implementation NSInvocation (SMNSInvocation)

- (void) cancelInvokeMethod{
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(invoke)  object:self];
}

- (void) invokeWithDelay:(CGFloat) delay{
    [self performSelector:@selector(invoke) withObject:nil afterDelay:delay];
}

+ (instancetype)invocationWithSelector:(SEL)selector target:(id) target params:(NSArray *)params  completion:(ArrayGeocodeResponseType)response{
    NSMethodSignature *signature = [target methodSignatureForSelector:selector];
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
    [invocation setTarget:target];
    [invocation setSelector:selector];
    NSInteger index = 2;
    for (id __strong op in params) {
        [invocation setArgument:(void *) &op atIndex:index];
        index++;
    }
    [invocation setArgument:&response atIndex:index];
    return invocation;
}

@end
