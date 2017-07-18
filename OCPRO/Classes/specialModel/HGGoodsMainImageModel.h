//
// HGGoodsMainImageModel.h
//  OCPRO
//
//  Created by shiqianren on 2017/7/17.
//  Copyright © 2017年 shiqianren. All rights reserved.

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface HGGoodsMainImageModel : NSObject

@property (nonatomic,copy) NSString *image_id;
@property (nonatomic,copy) NSString *image_original;
@property (nonatomic,copy) NSString  *image_middle;
@property (nonatomic,copy) NSString  *image_thumbnail;
@property (nonatomic,assign) CGFloat image_width;
@property (nonatomic,assign) CGFloat image_height;

@end
