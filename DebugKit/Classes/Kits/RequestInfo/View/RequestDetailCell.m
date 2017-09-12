//
//  RequestDetailCell.m
//  Pods
//
//  Created by 郑敏 on 2017/9/12.
//
//

#import "RequestDetailCell.h"

@implementation RequestDetailCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self.cpyButton addTarget:self action:@selector(cpyButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

- (void)cpyButtonClicked:(UIButton *)sender {
    [[UIPasteboard generalPasteboard] setString:self.contentLabel.text];
}

@end
