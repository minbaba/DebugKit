//
//  NSURLSessionConfiguration+MBBExtension.m
//  DebugKit
//
//  Created by 郑敏 on 2017/8/3.
//
//

#import <objc/runtime.h>
#import "NSURLSessionConfiguration+MBBExtension.h"
#import "DebugHttpProtocol.h"


static BOOL exchangeFlagKey = NO;

@implementation NSURLSessionConfiguration (MBBExtension)

+ (NSURLSessionConfiguration *)zw_defaultSessionConfiguration{
    NSURLSessionConfiguration *configuration = [self zw_defaultSessionConfiguration];
    NSArray *protocolClasses = @[[DebugHttpProtocol class]];
    configuration.protocolClasses = protocolClasses;
    
    return configuration;
}

+ (void)setRegisterFlag:(BOOL)flag {

    if (flag != exchangeFlagKey) {
        Method systemMethod = class_getClassMethod([NSURLSessionConfiguration class], @selector(defaultSessionConfiguration));
        Method zwMethod = class_getClassMethod([self class], @selector(zw_defaultSessionConfiguration));
        method_exchangeImplementations(systemMethod, zwMethod);
        exchangeFlagKey = flag;
    }
    
    if (flag) {
        [NSURLProtocol registerClass:[DebugHttpProtocol class]];
    } else {
        [NSURLProtocol unregisterClass:[DebugHttpProtocol class]];
    }

}

@end
