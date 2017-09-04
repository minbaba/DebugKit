//
//  ServerManager.m
//  DebugKit
//
//  Created by 郑敏 on 2017/8/9.
//
//

#import "ServerManager.h"
#import "serverListVc.h"

@interface ServerManager ()

@property (copy, nonatomic) NSArray<NSString *> *serverList;

@end

@implementation ServerManager

- (void)fetchData {
    if ([[DebugManager defualtManager].helper respondsToSelector:@selector(networkEnvs)]) {
        self.serverList = [[DebugManager defualtManager].helper networkEnvs];
    }
}

- (NSString *)name {
    return @"server";
}

- (UIViewController *)detailViewcontroller {
    return [[ServerListVc alloc] initWithServerList:self.serverList];
}

@end
