//
//  HGFindModel.m
//  HiGo
//
//  Created by Think_lion on 15/7/27.
//  Copyright (c) 2015年 Think_lion. All rights reserved.
//

#import "FindModel.h"

@implementation FindModel

-(void)setGoods_display_final_price:(NSString *)goods_display_final_price
{
    NSString *realPrice=[[goods_display_final_price componentsSeparatedByString:@"."] firstObject];
    _goods_display_final_price=realPrice;
}

@end
