//
//  PageInfoManager.h
//  YaoYi
//
//  Created by 郑敏 on 2017/7/31.
//
//

#import <Foundation/Foundation.h>
#import "DebugManager.h"


/**

 页面信息调试
 
 默认打印页面类名、pageName、继承关系、及截图
 
 可通过在具体页面中实现：
 - (NSString *)yw_debugInfo;
 定制调试信息
 
*/
@interface PageInfoManager : NSObject <DebugItemProtocol>



@end

