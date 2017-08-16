//
//  UIWindow+MBBExtention.m
//  DebugKit
//
//  Created by 郑敏 on 2017/7/31.
//
//

#import "UIWindow+MBBExtention.h"

@implementation UIWindow (MBBExtention)

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
