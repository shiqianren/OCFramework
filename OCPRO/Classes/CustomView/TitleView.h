//
//  TitleView.h
//  OCPRO
//
//  Created by shiqianren on 2017/7/11.
//  Copyright © 2017年 shiqianren. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TitleViewDelegate <NSObject>

-(void)scrollToIndex:(NSInteger)tagIndex;

@end

@interface TitleView : UIView
@property(nonatomic,weak) id<TitleViewDelegate>delegate;

-(void)tagSelected:(NSInteger)tagIndex;

@end
