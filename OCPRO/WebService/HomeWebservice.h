//
//  HomeWebservice.h
//  OCPRO
//
//  Created by shiqianren on 2017/6/19.
//  Copyright © 2017年 shiqianren. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseResponse.h"
typedef void(^HomeResponseBlock)(BOOL success,BaseResponse *response);
@interface HomeWebservice : NSObject

+ (instancetype)shareInstance;


-(void)getGradeList:(HomeResponseBlock)homeResponseBlock;

-(void)getGoods:(HomeResponseBlock)homeResponseBlock;
@end
