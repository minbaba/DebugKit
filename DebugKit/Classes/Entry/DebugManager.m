//
//  DebugManager.m
//  DebugKit
//
//  Created by 郑敏 on 2017/7/28.
//
//

#import "DebugManager.h"
#import "PageInfoManager.h"
#import "RequestInfoManager.h"
#import "UserDataManager.h"
#import "ServerManager.h"
#import "NSURLSessionConfiguration+MBBExtension.h"
#import "UIWindow+MBBExtension.h"
#import <objc/runtime.h>
#import "YWSandboxBrowserManager.h"

@interface DebugManager ()

@property (strong, nonatomic) UINavigationController  *rootVc;

@end

@implementation DebugManager

+ (void)load {

#ifdef DEBUG
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(switchAccessorVisibility) name:UIApplicationDidFinishLaunchingNotification object:nil];
    
    Protocol *protocol = @protocol(DebugHelperProtocol);
    
    // 获取 helper 类
    int numberOfClasses = objc_getClassList(NULL, 0);
    Class *classList = (__unsafe_unretained Class *)malloc(numberOfClasses * sizeof(Class));
    numberOfClasses = objc_getClassList(classList, numberOfClasses);
    
    for (int idx = 0; idx < numberOfClasses; idx++) {
        Class class = classList[idx];
        if (class_getClassMethod(class, @selector(conformsToProtocol:)) && [class conformsToProtocol:protocol]) {
            [DebugManager registerHelper:[[class alloc] init]];
        }
    }
    free(classList);
#endif

}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        _bubble = [DebugBubble new];
        [_bubble addTarget:self action:@selector(clickedBubble) forControlEvents:UIControlEventTouchUpInside];
        _bubble.hidden = YES;
    }
    return self;
}

static DebugManager *instance;

+ (instancetype)defualtManager {
    
    static dispatch_once_t onceKey;
    dispatch_once(&onceKey, ^{
        instance = [[self alloc] init];
        NSArray *arr = @[[PageInfoManager new],
                         [RequestInfoManager new],
                         [UserDataManager new],
                         [ServerManager new],
                         [YWSandboxBrowserManager new]];
        instance.items = (NSArray<DebugItemProtocol> *)arr;
    });
    return instance;
}

+ (void)switchAccessorVisibility {
#ifdef DEBUG
    DebugBubble *bubble = [DebugManager defualtManager].bubble;
    bubble.hidden = NO;
    [NSURLSessionConfiguration setRegisterFlag:YES];
    
    UIWindow *window = [UIApplication sharedApplication].delegate.window;
    [[NSNotificationCenter defaultCenter] addObserver:[self defualtManager] selector:@selector(windowShow) name:kUIWindowDidChangeRootVcNotification object:window];
    
    bubble.frame = CGRectMake(window.frame.size.width - bubble.frame.size.width - 20,
                              window.frame.size.height - bubble.frame.size.height - 50,
                              bubble.frame.size.width,
                              bubble.frame.size.height);
    [window addSubview:bubble];
#endif
}

+ (void)registerHelper:(id<DebugHelperProtocol>)helper {
    [DebugManager defualtManager].helper = helper;
    [DebugManager defualtManager].bubble.title = helper.currentNetEnv;
}

- (void)clickedBubble {

    if (self.rootVc.view.window) {
        [self.rootVc dismissViewControllerAnimated:YES completion:nil];
        [self.rootVc popToRootViewControllerAnimated:YES];
        return;
    }

    for (id<DebugItemProtocol> item in self.items) {
        [item fetchData];
    }
    
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:self.rootVc animated:YES completion:nil];
}

- (UINavigationController *)rootVc {
    if (!_rootVc) {
    
        NSBundle *podBundle = [NSBundle bundleForClass:[DebugManager class]];
        NSURL *bundleURL = [podBundle URLForResource:@"DebugKit" withExtension:@"bundle"];
        NSBundle *bundle = [NSBundle bundleWithURL:bundleURL];

        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Debug" bundle:bundle];
        _rootVc = sb.instantiateInitialViewController;
    }
    return _rootVc;
}

- (void)windowShow {
    dispatch_async(dispatch_get_main_queue(), ^{
        UIWindow *window = [UIApplication sharedApplication].delegate.window;
        [window bringSubviewToFront:self.bubble];
    });
}



@end
