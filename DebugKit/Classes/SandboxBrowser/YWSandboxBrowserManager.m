//
//  YWSandboxBrowserManager.m
//  SandboxBrowser
//
//  Created by 郭敏 on 2017/8/28.
//  Copyright © 2017年 ypzdw. All rights reserved.
//

#import "YWSandboxBrowserManager.h"
#import "YWSandboxBrowserVC.h"

@implementation YWSandboxBrowserManager

- (NSString *)name {
    return @"沙盒浏览器";
}

- (UIViewController *)detailViewcontroller {
    return [YWSandboxBrowserVC instanceWithPath:nil];
}

- (void)fetchData {
    
}

@end
