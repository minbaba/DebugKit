//
//  DebugManager.h
//  YaoYi
//
//  Created by 郑敏 on 2017/7/28.
//
//


#import <Foundation/Foundation.h>
#import "DebugBubble.h"


@protocol DebugItemProtocol <NSObject>

- (void)fetchData;

@property (nonatomic, readonly) UIViewController *detailViewcontroller;

@property (nonatomic, readonly) NSString *name;

@end


@interface DebugManager : NSObject

+ (instancetype)shareManeger;

+ (void)switchAccessorVisibility;

@property (strong, nonatomic) DebugBubble *bubble;

@property (copy, nonatomic) NSArray<DebugItemProtocol> *items;


@end
