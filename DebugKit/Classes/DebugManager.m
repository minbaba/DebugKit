//
//  DebugManager.m
//  YaoYi
//
//  Created by 郑敏 on 2017/7/28.
//
//

#import "DebugManager.h"
#import "PageInfoManager.h"
#import "RequestInfoManager.h"
#import "UserDataManager.h"

@interface DebugManager ()

@property (strong, nonatomic) UINavigationController  *rootVc;

@end

@implementation DebugManager

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

+ (instancetype)shareManeger {
    
    static dispatch_once_t onceKey;
    dispatch_once(&onceKey, ^{
        instance = [self new];
        instance.items = @[[PageInfoManager new], [RequestInfoManager new], [UserDataManager new]];
    });
    return instance;
}

+ (void)switchAccessorVisibility {
    
    DebugBubble *bubble = [DebugManager shareManeger].bubble;
    bubble.hidden = !bubble.hidden;
    if (bubble.hidden) {
        [bubble removeFromSuperview];
    } else {
    
        UIWindow *window = [UIApplication sharedApplication].delegate.window;
        
        bubble.frame = CGRectMake(window.frame.size.width - bubble.frame.size.width - 20,
                                  window.frame.size.height - bubble.frame.size.height - 50,
                                  bubble.frame.size.width,
                                  bubble.frame.size.height);
        [window addSubview:bubble];
    }
    
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
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Debug" bundle:nil];
        _rootVc = sb.instantiateInitialViewController;
    }
    return _rootVc;
}


@end
