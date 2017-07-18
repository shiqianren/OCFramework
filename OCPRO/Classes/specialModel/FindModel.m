//
// FindModel.h
//  OCPRO
//
//  Created by shiqianren on 2017/7/17.
//  Copyright © 2017年 shiqianren. All rights reserved.
#import "FindModel.h"

@implementation FindModel

-(void)setGoods_display_final_price:(NSString *)goods_display_final_price
{
    NSString *realPrice=[[goods_display_final_price componentsSeparatedByString:@"."] firstObject];
    _goods_display_final_price=realPrice;
}

@end
