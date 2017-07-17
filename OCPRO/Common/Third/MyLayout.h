//
//  MyLayout.h
//  OCPRO
//
//  Created by shiqianren on 2017/7/17.
//  Copyright © 2017年 shiqianren. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MyLayout;
@protocol MyLayoutDelegate <NSObject>
-(CGFloat)waterFlow:(MyLayout*)waterFlow heightForWidth:(CGFloat)width indexpath:(NSIndexPath*)indexpath;
@end

@interface MyLayout : UICollectionViewLayout
//每一行的间距
@property (nonatomic , assign) CGFloat rowMargin;
//每一列的间距
@property (nonatomic , assign) CGFloat columnMargin;

//四边的距离
@property (nonatomic , assign) UIEdgeInsets sectionInset;

//最大的列数
@property (nonatomic , assign) CGFloat columsCount;

@property (nonatomic, weak) id<MyLayoutDelegate> delegate;

@end
