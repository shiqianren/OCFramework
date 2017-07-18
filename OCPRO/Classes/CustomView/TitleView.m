//
//  TitleView.m
//  OCPRO
//
//  Created by shiqianren on 2017/7/11.
//  Copyright © 2017年 shiqianren. All rights reserved.
//

#import "TitleView.h"
#import "AppSetting.h"
#import "UIView+ViewExtension.h"
@interface TitleView()

@property (nonatomic , weak) UIButton *button;
@property (nonatomic , weak) UIView *underLine;
@end


@implementation TitleView


- (instancetype)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	if (self) {
		[self setupButton];
		
	}
	return self;
}

-(void)setupButton{
	[self addBUtton:@"精选"];
	[self addBUtton:@"探索"];
	[self addBUtton:@"发现"];
}



-(void)addBUtton:(NSString*)title{
	
	UIButton *btn=[[UIButton alloc]init];
	btn.titleLabel.font=PorFont(15);
	[btn setTitle:title forState:UIControlStateNormal];
	[btn setTitleColor:UIColorRGBA(75, 75, 75,1) forState:UIControlStateNormal];
	[btn setTitleColor:UIColorRGBA(247, 133, 136,1) forState:UIControlStateSelected];
	[btn addTarget:self action:@selector(titleButtonClick:) forControlEvents:UIControlEventTouchUpInside];
	[self addSubview:btn];
}

-(void)titleButtonClick:(UIButton*)sender{
	
	if([self.delegate respondsToSelector:@selector(scrollToIndex:)]){
		[self.delegate scrollToIndex:sender.tag];
	}
	
	self.button.selected = NO;
	self.button.titleLabel.font = PorFont(15);
	sender.selected  = YES;
	sender.titleLabel.font = PorFont(18);
	self.button = sender;
    [self updateUnderLine:sender];
}

-(void)tagSelected:(NSInteger)tagIndex{
	
	self.button.selected = NO;
	self.button.titleLabel.font = PorFont(15);
	UIButton *btn = self.subviews[tagIndex];
	btn.selected = YES;
	btn.titleLabel.font = PorFont(18);
	self.button = btn;
	
	[self updateUnderLine:btn];
}

-(void)updateUnderLine:(UIButton *)btn{

	[UIView animateWithDuration:0.5 animations:^{
		self.underLine.x = btn.x ;
	}];
	
}


-(void)layoutSubviews{
	CGFloat btnY =0 ;
	int count = (int)self.subviews.count;
	CGFloat btnX = 0;
	CGFloat btnW = self.width/count;
	CGFloat btnH = self.height;
	for (int i =0; i <count; i++) {
		btnX = btnW*i;
		UIButton *btn = self.subviews[i];
		btn.tag = i;
		btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
		if (i == 0){
			[self addLine:btn];
		}
	}
	
}


-(void)addLine:(UIButton *)btn {
	UIView *underLine = [[UIView alloc] initWithFrame:CGRectMake(btn.left, btn.bottom, btn.width, 2)];
	underLine.backgroundColor = [UIColor blackColor];
	[self addSubview:underLine];
	self.underLine = underLine;
}




@end
