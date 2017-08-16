//
//  DebugDetailVc.m
//  DebugKit
//
//  Created by 郑敏 on 2017/7/31.
//
//

#import "DebugDetailVc.h"

@interface DebugDetailVc ()

@end

@implementation DebugDetailVc

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.textView.attributedText = self.text;
}

+ (instancetype)instance {
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Debug" bundle:bundle];
    return [sb instantiateViewControllerWithIdentifier:@"detail"];
}

@end
