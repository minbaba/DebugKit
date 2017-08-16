//
//  UserDataManager.m
//  DebugKit
//
//  Created by 郑敏 on 2017/8/4.
//
//

#import "UserDataManager.h"
#import "DebugDetailVc.h"

@implementation UserDataManager {
    NSDictionary *infoDict;
}


#pragma - item protocol
- (void)fetchData {
    if ([[DebugManager defualtManager].helper respondsToSelector:@selector(userInfo)]) {
        infoDict = [DebugManager defualtManager].helper.userInfo;
    }
}

- (UIViewController *)detailViewcontroller {
    
    DebugDetailVc *vc = [DebugDetailVc instance];
    NSMutableAttributedString *attStr = [NSMutableAttributedString new];
    for (NSString *key in infoDict.allKeys) {
        NSString *title = [NSString stringWithFormat:@"\n%@:", key];
        [attStr appendAttributedString:TitleAttributesDef(title)];
        NSObject *value = infoDict[key];
        if (![value isKindOfClass:[NSString class]]) {
            value = value.description;
        }
        [attStr appendAttributedString:ContentAttributesDef((NSString *)value)];
    }
    vc.text = attStr;
    return vc;
}

- (NSString *)name {
    return @"UserInfo";
}

@end
