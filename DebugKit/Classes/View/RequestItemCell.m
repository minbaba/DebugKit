//
//  RequestItemCell.m
//  DebugKit
//
//  Created by 郑敏 on 2017/8/3.
//
//

#import "RequestItemCell.h"

@implementation RequestItemCell

- (void)awakeFromNib {
    [super awakeFromNib];

    self.stateHint.layer.cornerRadius = 4.25;
    self.stateHint.clipsToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
