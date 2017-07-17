//
//  HGFindFrameModel.h
//  HiGo
//
//  Created by Think_lion on 15/7/28.
//  Copyright (c) 2015年 Think_lion. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>
@class FindModel,BannerModel;

@interface FindFrameModel : NSObject

@property (nonatomic,strong) FindModel *findModel;
@property (nonatomic,strong) BannerModel *bannerModel;

@property (nonatomic,assign,readonly) CGRect bannerF;

@property (nonatomic,assign,readonly) CGRect imageF;
@property (nonatomic,assign,readonly) CGRect descF;
@property (nonatomic,assign,readonly) CGRect priceF;
@property (nonatomic,assign,readonly) CGRect addressF;


@property (nonatomic,assign,readonly) CGRect showF;


@property (nonatomic,assign,readonly) CGFloat cellH; //单元格的高度

@end
