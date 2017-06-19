//
//  Macro.h
//  OCPRO
//
//  Created by shiqianren on 2017/6/14.
//  Copyright © 2017年 shiqianren. All rights reserved.
//

#ifndef Macros_h
#define Macros_h


#endif /* Macro_h */

/* !weak self*/
#define PRO_WEAKSELF typeof(self) __weak weakSelf = self
#define PRO_WeakSelf(type)  __weak typeof(type) weak##type = type;

/*Font size*/
#define PRO_FontSize(fontSize) [UIFont systemFontOfSize:fontSize]

/**
 *  获取iOS版本
 */
#define IOS_VERSION [UIDevice currentDevice].systemVersion

//#define isiOS10 ([[[[[UIDevice currentDevice] systemVersion] substringToIndex:1] stringByAppendingString:@"0"] intValue] == 10)

#define isiOS10 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 10.0)

/*! 大于8.0 */
#define IOS8x ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
