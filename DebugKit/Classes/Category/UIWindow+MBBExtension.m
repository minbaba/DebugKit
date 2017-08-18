//
//  UIWindow+MBBExtension.m
//  DebugKit
//
//  Created by 郑敏 on 2017/7/31.
//
//

#import "UIWindow+MBBExtension.h"
#import <objc/runtime.h>


NSNotificationName const kUIWindowDidChangeRootVcNotification = @"kUIWindowDidChangeRootVcNotification";  ///< UIWindow rootViewController 被修改的通知

@implementation UIWindow (MBBExtension)

+ (void)load {
#ifdef DEBUG
    Method systemMethod = class_getInstanceMethod([self class], @selector(setRootViewController:));
    Method zwMethod = class_getInstanceMethod([self class], @selector(mbb_setRootViewController:));    method_exchangeImplementations(systemMethod, zwMethod);
#endif
}

- (void)mbb_setRootViewController:(UIViewController *)rootViewController {
    [self mbb_setRootViewController:rootViewController];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kUIWindowDidChangeRootVcNotification object:nil];
}

#pragma mark - 华丽丽
- (UIViewController *)visibleViewController {
    UIViewController *rootViewController = self.rootViewController;
    return [UIWindow getVisibleViewControllerFrom:rootViewController];
}

+ (UIViewController *)getVisibleViewControllerFrom:(UIViewController *)vc {
    if ([vc isKindOfClass:[UINavigationController class]]) {
        return [UIWindow getVisibleViewControllerFrom:[((UINavigationController *) vc) visibleViewController]];
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        return [UIWindow getVisibleViewControllerFrom:[((UITabBarController *) vc) selectedViewController]];
    } else {
        if (vc.presentedViewController) {
            return [UIWindow getVisibleViewControllerFrom:vc.presentedViewController];
        } else if (vc.childViewControllers.count) {
            return [UIWindow getVisibleViewControllerFrom:vc.childViewControllers.lastObject];
        }
    }
    
    return vc;
}

@end
