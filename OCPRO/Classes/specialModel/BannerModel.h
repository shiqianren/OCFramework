
//
// BannerModel.h
//  OCPRO
//
//  Created by shiqianren on 2017/7/17.
//  Copyright © 2017年 shiqianren. All rights reserved.
//
#import <Foundation/Foundation.h>

@class BannerPicModel;

@interface BannerModel : NSObject

@property (nonatomic,copy) NSString *name;

@property (nonatomic,strong) BannerPicModel *banner_pic;

@end
