//
// FindFrameModel.m
//  OCPRO
//
//  Created by shiqianren on 2017/7/17.
//  Copyright © 2017年 shiqianren. All rights reserved.

#import "FindFrameModel.h"
#import "BannerModel.h"
#import "FindModel.h"
#import "BannerPicModel.h"
#import "AppSetting.h"

#define VMargin 10
#define findLineMargin 5
//单元格的宽度
#define cellW  (PortraitWidth-VMargin*3)/2

@interface FindFrameModel ()

@end

@implementation FindFrameModel


#pragma mark 设置广告栏的frame
-(void)setBannerModel:(BannerModel *)bannerModel
{
    _bannerModel=bannerModel;
    CGFloat bannerW=bannerModel.banner_pic.image_width;
    CGFloat bannerH=bannerModel.banner_pic.image_height;
    
    CGFloat logoH=cellW/bannerW*bannerH;
    
    _bannerF=CGRectMake(0, 0, cellW, logoH);
    _showF=_bannerF;
    _cellH=CGRectGetMaxY(_bannerF);
   
}
#pragma mark 设置显示商品的frame
-(void)setFindModel:(FindModel *)findModel
{
    _findModel=findModel;
    //1.设置图片的frame
    CGFloat imageX=0;
    CGFloat imageY=0;
    CGFloat imageW=cellW;
    CGFloat imageH=imageW;
    _imageF=CGRectMake(imageX, imageY, imageW, imageH);
    //2.设置商品的name
    CGFloat descX=VMargin;
    CGFloat descY=CGRectGetMaxY(_imageF)+VMargin;
    CGFloat descW=cellW-VMargin*2;
    
    NSString *shopname=[self subStrFromFitScreen:findModel.goods_name];
    
    CGSize finalSize=[shopname boundingRectWithSize:CGSizeMake(descW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:PorFont(11)} context:nil].size;
    
    _descF=CGRectMake(descX, descY, descW, finalSize.height);
    //self.descLabel.frame=CGRectMake(descX, descY, descW, finalSize.height);
    //3.设置价格的frame
    CGFloat priceX=VMargin;
    CGFloat priceY=CGRectGetMaxY(_descF)+findLineMargin;
    
    CGSize priceSize=[findModel.goods_display_final_price  sizeWithAttributes:@{NSFontAttributeName:PorFont(14)}];
    
    _priceF=CGRectMake(priceX, priceY, priceSize.width+20, priceSize.height);
    
    //4.设置商品来源的位置
    CGFloat addressX=VMargin;
    CGFloat addressY=CGRectGetMaxY(_priceF)+findLineMargin;
	
    NSString *addressStr=[NSString stringWithFormat:@"%@ %@",findModel.group_info.country,findModel.group_info.city];
    CGSize addressSize=[addressStr sizeWithAttributes:@{NSFontAttributeName:PorFont(10)}];
    _addressF=CGRectMake(addressX, addressY,addressSize.width+20, addressSize.height);
    //5.设置showView的frame
    _cellH=CGRectGetMaxY(_addressF)+10;
    
    _showF=CGRectMake(0, 0, cellW, _cellH);
   
}




-(NSString*)subStrFromFitScreen:(NSString*)str
{
    NSString *tempStr=nil;
    if(PortraitWidth<=320){
        if(str.length>21){
            tempStr=[str substringToIndex:21];
        }else{
            tempStr=str;
        }
        
        
    }else if(PortraitWidth<=375 && PortraitWidth>320){
        if(str.length>28){
            tempStr=[str substringToIndex:28];
        }else{
            tempStr=str;
        }
        
    }else{
        if(str.length>32){
            tempStr=[str substringToIndex:32];
        }else{
            tempStr=str;
        }
    }
    
    return tempStr;
}





@end
