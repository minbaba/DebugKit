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
    [DebugManager registerHelper:[cls new]];
    [DebugManager switchAccessorVisibility];
#endif
}

@end
