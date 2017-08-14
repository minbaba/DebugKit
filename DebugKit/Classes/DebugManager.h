//
//  DebugManager.h
//  YaoYi
//
//  Created by 郑敏 on 2017/7/28.
//
//

#ifndef DebugManager_h
#define DebugManager_h

#import <Foundation/Foundation.h>
#import "DebugBubble.h"
#import "DebugKit.h"

@interface DebugManager : NSObject

+ (instancetype)shareManeger;

+ (void)switchAccessorVisibility;

+ (void)registerHelper:(id<DebugHelperProtocol>)helper;

@property (strong, nonatomic) DebugBubble *bubble;

@property (copy, nonatomic) NSArray<DebugItemProtocol> *items;


- (instancetype)init NS_UNAVAILABLE;

+ (instancetype)new NS_UNAVAILABLE; 

@end

#endif
