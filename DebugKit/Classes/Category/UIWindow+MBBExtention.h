//
//  UIWindow+MBBExtention.h
//  DebugKit
//
//  Created by 郑敏 on 2017/7/31.
//
//

#import <UIKit/UIKit.h>

@interface UIWindow (MBBExtention)

- (UIViewController *)visibleViewController;

+ (UIViewController *)getVisibleViewControllerFrom:(UIViewController *)vc;

@end
