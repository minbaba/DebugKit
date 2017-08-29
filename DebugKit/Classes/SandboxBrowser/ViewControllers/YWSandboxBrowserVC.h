//
//  YWSandboxBrowserVC.h
//
//  Created by 郭敏 on 2017/8/28.
//  Copyright © 2017年 ypzdw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YWSandboxBrowserVC : UIViewController

@property (nonatomic, copy, readonly) NSString *path; ///< 当前 path

/**
 返回一个指定 path 的控制器，并显示该目录下的内容。

 @param path 目录地址
 @return 指定 path 的控制器。
 */
+ (instancetype)instanceWithPath:(NSString *)path;

@end
