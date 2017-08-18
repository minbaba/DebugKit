//
//  DebugKit.m
//  Pods
//
//  Created by 郑敏 on 2017/8/16.
//
//

#import "DebugKit.h"
#ifdef DEBUG
#import "DebugManager.h"
#endif


@implementation DebugKit

+ (void)registerWithHelperClass:(Class)cls {
    
#ifdef DEBUG
    Class class = cls;
    if (class == nil) {
        class = NSClassFromString(@"DebugHelper");
    }
    
    [DebugManager registerHelper:[class new]];
    [DebugManager switchAccessorVisibility];
#endif
}

@end
