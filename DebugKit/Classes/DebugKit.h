//
//  DebugKit.h
//  Pods
//
//  Created by 郑敏 on 2017/8/16.
//
//

#import <Foundation/Foundation.h>

#ifndef DebugKit_h
#define DebugKit_h

typedef NSString * DebugUserDefualtKey NS_EXTENSIBLE_STRING_ENUM;

/**
 接入平台需要配置的内容
 */
@protocol DebugHelperProtocol <NSObject>

/**
 返回用户数据的字典
 
 @return 用户数据的 Key-Value 映射
 */
- (NSDictionary *)userInfo;


/**
 可供选择的网络环境
 
 @return 可供选择环境列表
 */
- (NSArray<NSString *> *)networkEnvs;

@property (nonatomic) NSString *currentNetEnv; ///< 当前网络环境

@end
#endif
