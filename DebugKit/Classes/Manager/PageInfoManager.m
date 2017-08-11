//
//  PageInfoManager.m
//  YaoYi
//
//  Created by 郑敏 on 2017/7/31.
//
//

#import "PageInfoManager.h"
#import "UIWindow+MBBExtention.h"
#import "DebugDetailVc.h"
#import <objc/runtime.h>


@interface NSObject ()

- (NSString *)yw_debugInfo;

@end


#pragma - implement
@interface PageInfoManager()

@property (weak, nonatomic) UIViewController *currentPage;

@end

@implementation PageInfoManager

#pragma mark - sections

- (NSAttributedString *)classSection {
    
    if (!self.currentPage) {
        return [NSAttributedString new];
    }

    NSMutableAttributedString *ret = [TitleAttributesDef(@"\n\n页面信息:\n") mutableCopy];
    NSString *content = [NSString stringWithFormat:@"类名:%@\n", self.currentPage.class];
    [ret appendAttributedString:ContentAttributesDef(content)];
    
    // pageName
    if ([self.currentPage respondsToSelector:NSSelectorFromString(@"pageName")]) {
        content = [NSString stringWithFormat:@"pageName:%@\n", [(id)self.currentPage valueForKey:@"pageName"]];
        [ret appendAttributedString:ContentAttributesDef(content)];
    }
    
    // url
    if ([self.currentPage isKindOfClass:NSClassFromString(@"YWH5BridgeContainerVC")]) {
        UIWebView *webView = [self.currentPage valueForKey:@"webView"];
        NSString *url = webView.request.URL.absoluteString;
        NSString *content = [NSString stringWithFormat:@"url:%@\n", url];
        [ret appendAttributedString:ContentAttributesDef(content)];
    }
    
    return ret;
}

- (NSAttributedString *)inhireStackSection {
  
    Class cls = self.currentPage.class;
    NSMutableString *str = [NSStringFromClass(cls) mutableCopy];
    do {
        cls = [cls superclass];
        [str appendFormat:@"\n%@", NSStringFromClass(cls)];
    } while (![NSStringFromClass(cls) isEqualToString:NSStringFromClass([NSObject class])]);
    
    NSMutableAttributedString *ret = [TitleAttributesDef(@"\n\n继承信息:\n") mutableCopy];
    [ret appendAttributedString:ContentAttributesDef(str)];
    
    return ret;
}

- (NSAttributedString *)addtionSection {
    if ([self.currentPage respondsToSelector:NSSelectorFromString(@"yw_debugInfo")]) {
    
        NSMutableAttributedString *ret = [TitleAttributesDef(@"\n\nAddtion:\n") mutableCopy];
        NSString *str = [self.currentPage yw_debugInfo];
        [ret appendAttributedString:ContentAttributesDef(str)];
        return ret;
    }
    return [NSAttributedString new];
}

#pragma - item protocol
- (void)fetchData {
    
    self.currentPage = [UIApplication sharedApplication].delegate.window.visibleViewController;
}

- (UIViewController *)detailViewcontroller {

    DebugDetailVc *vc = [DebugDetailVc instance];
    NSMutableAttributedString *mStr = [NSMutableAttributedString new];
    [mStr appendAttributedString:[self classSection]];
    [mStr appendAttributedString:[self inhireStackSection]];
    [mStr appendAttributedString:[self addtionSection]];
    vc.text = mStr;
    
    return vc;
}

- (NSString *)name {
    return @"页面信息";
}


@end
