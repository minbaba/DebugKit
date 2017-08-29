//
//  YWSandboxFileItem.h
//
//  Created by 郭敏 on 2017/8/28.
//  Copyright © 2017年 ypzdw. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, YWFileItemType) {
    YWFileItemTypeDirectory,///< 文件夹
    YWFileItemTypeFile,///< 文件
};

@interface YWSandboxFileItem : NSObject

@property (nonatomic, assign) YWFileItemType fileType;
@property (nonatomic, copy)   NSString *fileName;
@property (nonatomic, copy)   NSString *fileFullPath;
@property (nonatomic, assign) NSUInteger subContentsCount;

@end
