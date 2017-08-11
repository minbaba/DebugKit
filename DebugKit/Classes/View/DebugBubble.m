//
//  DebugBubble.m
//  YaoYi
//
//  Created by 郑敏 on 2017/7/28.
//
//

#import "DebugBubble.h"

@implementation DebugBubble


static CGFloat const BubbleSize = 60;

- (instancetype)initWithFrame:(CGRect)frame {

    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [[UIColor greenColor] colorWithAlphaComponent:0.7];
        self.layer.cornerRadius = BubbleSize / 2;
        self.layer.borderColor = [UIColor blueColor].CGColor;
        self.frame = CGRectMake(0, 0, BubbleSize, BubbleSize);
        self.layer.borderWidth = 2;
    }
    return self;
}

- (CGSize)intrinsicContentSize {
    return CGSizeMake(BubbleSize, BubbleSize);
}

@end
