//
//  RequestInfoManager.m
//  YaoYi
//
//  Created by 郑敏 on 2017/8/1.
//
//

#import "RequestInfoManager.h"
#import "DebugHttpProtocol.h"
#import "HttpDebugModel.h"
#import "RequestDebugVc.h"

@implementation RequestInfoManager

- (instancetype)init
{
    self = [super init];
    if (self) {
        [NSURLProtocol registerClass:[DebugHttpProtocol class]];
    }
    return self;
}

#pragma mark - protocol
- (void)fetchData {
    
}

- (UIViewController *)detailViewcontroller {
    return [RequestDebugVc instance];
}

- (NSString *)name {
    return @"Request";
}


@end
