//
//  HttpDebugModel.h
//  YaoYi
//
//  Created by 郑敏 on 2017/8/2.
//
//

#import <Foundation/Foundation.h>

@interface HttpDebugModel : NSObject

// property
@property (copy, nonatomic) NSString *url;
@property (copy, nonatomic) NSString *method;
@property (copy, nonatomic) NSString *mineType;
@property (copy, nonatomic) NSString *statusCode;
@property (copy, nonatomic) NSString *responseData;
@property (copy, nonatomic) NSString *startTime;
@property (copy, nonatomic) NSString *duration;
@property (copy, nonatomic) NSString *requestBody;
@property (copy, nonatomic) NSError *error;


@property (readonly) NSAttributedString *attributedDescription;

// for list
@property (strong, nonatomic) HttpDebugModel *next;

+ (void)push:(HttpDebugModel *)newHead;
+ (instancetype)head;
+ (void)setMaxCount:(NSInteger)count;
+ (void)realeseList;

@end
