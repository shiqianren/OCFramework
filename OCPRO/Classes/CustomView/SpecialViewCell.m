//
//  SpecialViewCell.m
//  OCPRO
//
//  Created by shiqianren on 2017/7/17.
//  Copyright © 2017年 shiqianren. All rights reserved.
//

#import "SpecialViewCell.h"
#import "SpecialShowView.h"
@interface SpecialViewCell ()
@property (nonatomic , weak) SpecialShowView *specialShow;
@end

@implementation SpecialViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	if (self) {
		[self addChildView];
	}
	return self;
}

-(void)addChildView{
	SpecialShowView *show = [[SpecialShowView alloc] init];
	[self.contentView addSubview:show];
	self.specialShow = show;
}


-(void)setFindFrameModel:(FindFrameModel *)findFrameModel{
	self.specialShow.findFrame = findFrameModel;
}


@end
