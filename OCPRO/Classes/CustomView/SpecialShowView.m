//
//  SpecialShowView.m
//  OCPRO
//
//  Created by shiqianren on 2017/7/17.
//  Copyright © 2017年 shiqianren. All rights reserved.
//

#import "SpecialShowView.h"
#import "AppSetting.h"
#import "UIImageView+WebCache.h"
@interface SpecialShowView()

@property (nonatomic,weak) UIImageView *logoView;
//@property (nonatomic,weak) UIButton *heartBtn;
@property (nonatomic,weak) UILabel *descLabel;
@property (nonatomic,weak) UILabel *priceLabel;
@property (nonatomic,weak) UILabel *addressLabel;



@end
@implementation SpecialShowView
-(instancetype)initWithFrame:(CGRect)frame
{
	self=[super initWithFrame:frame];
	if(self){
		//添加子控件
		[self addChildView];
		self.backgroundColor=[UIColor whiteColor];
	}
	return self;
}

-(void)addChildView
{
	//1.添加商品图片
	UIImageView *logo=[[UIImageView alloc]init];
	logo.contentMode=UIViewContentModeScaleAspectFill;
	logo.clipsToBounds=YES;
	[self addSubview:logo];
	self.logoView=logo;
	//2.添加商品描述
	UILabel *descLabel=[[UILabel alloc]init];
	descLabel.contentMode=UIViewContentModeScaleAspectFill;
	descLabel.clipsToBounds=YES;
	descLabel.font=PorFont(11);
	descLabel.numberOfLines=0;
	descLabel.textColor=UIColorRGBA(75, 75, 75,1);
	[self addSubview:descLabel];
	self.descLabel=descLabel;
	//3.添加价格label
	UILabel *priceLabel=[[UILabel alloc]init];
	priceLabel.font=[UIFont boldSystemFontOfSize:14];
	priceLabel.textColor=UIColorRGBA(75, 75, 75,1);
	[self addSubview:priceLabel];
	self.priceLabel=priceLabel;
	//4.添加地址label
	UILabel *addressLabel=[[UILabel alloc]init];
	addressLabel.font=PorFont(10);
	addressLabel.textColor=UIColorRGBA(164, 164, 164,1);
	[self addSubview:addressLabel];
	self.addressLabel=addressLabel;
}



-(void)setFindFrame:(FindFrameModel *)findFrame
{
	
	_findFrame=findFrame;
	//如果有广告栏这个模型
	if(findFrame.bannerModel){
		[self setBannerWith:findFrame];
	}else{
		[self setGoodsFrame:findFrame];
	}
}

#pragma mark 设置广告栏的frame
-(void)setBannerWith:(FindFrameModel*)findFrame
{
	NSString *strUrl=findFrame.bannerModel.banner_pic.image_original;
	[self.logoView sd_setImageWithURL:[NSURL URLWithString:strUrl] placeholderImage:[UIImage imageNamed:@"loading"]];
	self.logoView.frame=findFrame.bannerF;
	self.frame=findFrame.showF;
}



#pragma mark 设置其余商品的展示效果
-(void)setGoodsFrame:(FindFrameModel*)findFrame
{
	//1.设置图片
	NSString *strUrl=findFrame.findModel.main_image.image_original;
	[self.logoView sd_setImageWithURL:[NSURL URLWithString:strUrl] placeholderImage:[UIImage imageNamed:@"loading"]];
	self.logoView.frame=findFrame.imageF;
	
	//2.设置商品的name
	
	NSString *shopname=[self subStrFromFitScreen:findFrame.findModel.goods_name];
	
	
	self.descLabel.text=shopname;
	self.descLabel.frame=findFrame.descF;
	//3.设置价格的frame
	
	
	NSString *priceStr=[NSString stringWithFormat:@"￥%@",findFrame.findModel.goods_display_final_price];
	self.priceLabel.text=priceStr;
	self.priceLabel.frame=findFrame.priceF;
	//4.设置商品来源的位置
	
	NSString *addressStr=[NSString stringWithFormat:@"%@ %@",findFrame.findModel.group_info.country,findFrame.findModel.group_info.city];
	[self setupAddressLabelWithStr:addressStr];
	self.addressLabel.frame=findFrame.addressF;
	//5.设置view的frame
	self.frame=findFrame.showF;
	
	
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

-(void)setupAddressLabelWithStr:(NSString*)str
{
	NSMutableAttributedString *string = [[NSMutableAttributedString alloc] init];
	// 创建图片图片附件
	NSTextAttachment *attach = [[NSTextAttachment alloc] init];
	attach.image = [UIImage imageNamed:@"localG"];
	attach.bounds = CGRectMake(0, -1, 10, 10);
	NSAttributedString *attachString = [NSAttributedString attributedStringWithAttachment:attach];
	[string appendAttributedString:attachString];
	[string appendAttributedString:[[NSAttributedString alloc] initWithString:str]];
	self.addressLabel.attributedText=string;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
