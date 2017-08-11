//
//  DebugDetailVc.m
//  YaoYi
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
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Debug" bundle:nil];
    return [sb instantiateViewControllerWithIdentifier:@"detail"];
}

@end
