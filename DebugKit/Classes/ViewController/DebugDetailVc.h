//
//  DebugDetailVc.h
//  DebugKit
//
//  Created by 郑敏 on 2017/7/31.
//
//

#import <UIKit/UIKit.h>

#define TextAttributesDef(str, font, wei) [[NSAttributedString alloc] initWithString:str attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:font weight:wei], NSForegroundColorAttributeName: [UIColor blackColor]}]
#define TitleAttributesDef(str) TextAttributesDef(str, 16, 2)
#define ContentAttributesDef(str) TextAttributesDef(str, 12, 0.5)
#define ReturnStr(str) [NSString stringWithFormat:@"%@\n", str]


@interface DebugDetailVc : UIViewController

@property (weak, nonatomic) IBOutlet UITextView *textView;

@property (copy, nonatomic) NSAttributedString *text;

+ (instancetype)instance;

@end
