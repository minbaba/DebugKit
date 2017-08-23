//
//  YWDebugHelper.m
//  DebugKit
//
//  Created by 郑敏 on 2017/8/16.
//  Copyright © 2017年 minbaba. All rights reserved.
//

#import "DebugHelper.h"

DebugUserDefualtKey const kCurrentNetEnvKey = @"kCurrentNetEnvKey";  ///< 当前网络环境

@implementation DebugHelper

@synthesize currentNetEnv = _currentNetEnv;

/**
 返回用户数据的字典
 
 @return 用户数据的 Key-Value 映射
 */
- (NSDictionary *)userInfo {
    return @{@"name": @"minbaba",
             @"age": @18,
             @"money": @10000000000000,
             @"girlfriendsCount": @10000000};
}


/**
 可供选择的网络环境
 
 @return 可供选择环境列表
 */
- (NSArray<NSString *> *)networkEnvs {
    return @[@"stage", @"test", @"online"];
}

- (void)setCurrentNetEnv:(NSString *)currentNextEnv {
    
    NSUserDefaults *defualt = [NSUserDefaults standardUserDefaults];
    [defualt setObject:currentNextEnv forKey:kCurrentNetEnvKey];
    [defualt synchronize];
    
    // 强制退出
    exit(0);
}

- (NSString *)currentNetEnv {
    _currentNetEnv = [[NSUserDefaults standardUserDefaults] stringForKey:kCurrentNetEnvKey];
    if (!_currentNetEnv || ! _currentNetEnv.length) {
        _currentNetEnv = @"online";
    }

    return _currentNetEnv;
}


@end
