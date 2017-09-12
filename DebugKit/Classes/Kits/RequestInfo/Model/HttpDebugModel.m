//
//  HttpDebugModel.m
//  DebugKit
//
//  Created by 郑敏 on 2017/8/2.
//
//

#import "HttpDebugModel.h"
#import "DebugDetailVc.h"

@implementation HttpDebugModel

static HttpDebugModel *head = nil;
static NSInteger maxCount = HUGE;


//- (NSAttributedString *)attributedDescription {
//    
//    NSDictionary *dict = @{@"请求地址": self.url,
//                           @"Method": self.method,
//                           @"耗时": self.duration,
//                           @"状态码": self.statusCode};
//    
//    NSMutableAttributedString *attStr = [NSMutableAttributedString new];
//    for (NSString *key in dict.allKeys) {
//        NSString *title = [NSString stringWithFormat:@"\n\n%@:", key];
//        [attStr appendAttributedString:TitleAttributesDef(title)];
//        [attStr appendAttributedString:ContentAttributesDef(dict[key])];
//    }
//    
//    if (self.error) {
//        [attStr appendAttributedString:TitleAttributesDef(@"\n\n错误描述\n:")];
//        NSString *domain = ReturnStr(self.error.domain);
//        [attStr appendAttributedString:ContentAttributesDef(domain)];
//        NSString *code = ReturnStr(self.error.domain);
//        [attStr appendAttributedString:ContentAttributesDef(code)];
//        NSString *userinfo = ReturnStr(self.error.userInfo.description);
//        [attStr appendAttributedString:ContentAttributesDef(userinfo)];
//    }
//    
//    if (self.responseData) {
//        [attStr appendAttributedString:TitleAttributesDef(@"\n\n接口返回:\n")];
//        [attStr appendAttributedString:ContentAttributesDef(self.responseData.formatJSON)];
//    }
//    
//    return attStr;
//}

#pragma mark - for list
+ (void)push:(HttpDebugModel *)newHead {
    newHead.next = head;
    head = newHead;
    
    int i = 0;
    for (HttpDebugModel *p = head; p != nil; p = p.next) {
        if (i >= maxCount) {
            p.next = nil;
        }
        i ++;
    }
}

+ (instancetype)head {
    return head;
}

+ (void)realeseList {
    head = nil;
}

+ (void)setMaxCount:(NSInteger)count {
    maxCount = count;
}

@end
