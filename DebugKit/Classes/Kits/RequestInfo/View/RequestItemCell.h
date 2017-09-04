//
//  RequestItemCell.h
//  DebugKit
//
//  Created by 郑敏 on 2017/8/3.
//
//

#import <UIKit/UIKit.h>

@interface RequestItemCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (weak, nonatomic) IBOutlet UILabel *urlLabel;

@property (weak, nonatomic) IBOutlet UIView *stateHint;

@end
