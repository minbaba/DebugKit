//
//  DebugKit.h
//  Pods
//
//  Created by 郑敏 on 2017/8/13.
//
//

#ifndef DebugKit_h
#define DebugKit_h

#import <Foundation/Foundation.h>
#import "DebugManager.h"

/**
 每一个 Debug 模块需要实现的协议
 处理每一个模块化的 Debug 模块的内部流程和相关逻辑
 */
@protocol DebugItemProtocol <NSObject>

/**
 Debug 模块入口进入的时候调用
 可以在此时捕获数据
 */
- (void)fetchData;

/**
 入口VC点击后的跳转对象
 */
@property (nonatomic, readonly) UIViewController *detailViewcontroller;

/**
 入口列表显示的名字
 */
@property (nonatomic, readonly) NSString *name;

@end



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
- (NSArray<NSString *> *)networkEvns;

@end




#endif /* DebugKit_h */
