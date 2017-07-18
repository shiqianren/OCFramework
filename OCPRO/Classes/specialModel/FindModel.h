//
// FindModel.h
//  OCPRO
//
//  Created by shiqianren on 2017/7/17.
//  Copyright © 2017年 shiqianren. All rights reserved.
#import <Foundation/Foundation.h>
#import "HGGoodsInfoModel.h"
#import "HGGoodsMainImageModel.h"
@interface FindModel : NSObject

@property (nonatomic,copy) NSString *goods_id;  //group_id  goods_name  goods_desc
@property (nonatomic,copy) NSString *group_id;
@property (nonatomic,copy) NSString *goods_name;
@property (nonatomic,copy) NSString *goods_desc;
@property (nonatomic,copy) NSString *goods_display_final_price;  //产品的价格
@property (nonatomic,copy) NSString *goods_display_color_name;  //产品的颜色

//分组信息的模型
@property (nonatomic,strong)  HGGoodsInfoModel *group_info;

//主图片的模型
@property (nonatomic,strong) HGGoodsMainImageModel  *main_image;

@end
