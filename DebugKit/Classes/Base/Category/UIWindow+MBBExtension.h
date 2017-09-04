//
//  UIWindow+MBBExtension.h
//  DebugKit
//
//  Created by 郑敏 on 2017/7/31.
//
//

#import <UIKit/UIKit.h>

UIKIT_EXTERN NSNotificationName const kUIWindowDidChangeRootVcNotification;

@interface UIWindow (MBBExtension)

- (UIViewController *)visibleViewController;

+ (UIViewController *)getVisibleViewControllerFrom:(UIViewController *)vc;

@end
