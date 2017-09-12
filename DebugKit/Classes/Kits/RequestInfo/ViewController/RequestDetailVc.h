//
//  RequestDetailVc.h
//  Pods
//
//  Created by 郑敏 on 2017/9/12.
//
//

#import <UIKit/UIKit.h>
#import "HttpDebugModel.h"

@interface RequestDetailVc : UIViewController

- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;

+ (instancetype)instance;

@property (strong, nonatomic) HttpDebugModel *model;

@end
