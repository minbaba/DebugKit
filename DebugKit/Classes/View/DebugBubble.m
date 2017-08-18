//
//  DebugBubble.m
//  DebugKit
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
        
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
        self.layer.cornerRadius = BubbleSize / 2;
        self.layer.borderColor = [UIColor whiteColor].CGColor;
        self.clipsToBounds = YES;
        self.frame = CGRectMake(0, 0, BubbleSize, BubbleSize);
        self.layer.borderWidth = 2;
    }
    return self;
}

- (CGSize)intrinsicContentSize {
    return CGSizeMake(BubbleSize, BubbleSize);
}

- (void)setTitle:(NSString *)title {
    _title = [title copy];
}

- (void)drawRect:(CGRect)rect {
    [self.title drawAtPoint:CGPointMake(10, BubbleSize / 2 - 7) withAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor], NSFontAttributeName: [UIFont systemFontOfSize:14]}];
}

@end
