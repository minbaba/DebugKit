//
//  DebugManager.h
//  DebugKit
//
//  Created by 郑敏 on 2017/7/28.
//
//

#ifndef DebugManager_h
#define DebugManager_h

#import <Foundation/Foundation.h>
#import "DebugBubble.h"
#import "DebugKit.h"


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
 入口管理类
 Debug 模块的入口从这里开始
 */
@interface DebugManager : NSObject

/**
 默认的实例(单例)

 @return 单例对象
 */
+ (instancetype)defualtManager;

/**
 切换气泡的显示与隐藏
 */
+ (void)switchAccessorVisibility;

/**
 注册定制化的辅助类

 @param helper 辅助类
 */
+ (void)registerHelper:(id<DebugHelperProtocol>)helper;

@property (strong, nonatomic) DebugBubble *bubble;                  ///< 气泡
@property (copy, nonatomic) NSArray<DebugItemProtocol> *items;      ///< 模块列表
@property (strong, nonatomic) id<DebugHelperProtocol> helper;       ///< 定制信息辅助工具

// 禁止私自初始化
- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;

@end

#endif
