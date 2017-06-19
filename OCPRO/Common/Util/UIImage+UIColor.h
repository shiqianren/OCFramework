//
//  UIImage+UIColor.h
//  CEAir
//
//  Created by 郑海清 on 16/6/22.
//  Copyright © 2016年 hengtiansoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (UIColor)
+ (instancetype)imageWithColor:(UIColor *)color;
+ (instancetype)imageWithColor:(UIColor *)color size:(CGSize)size;
@end
