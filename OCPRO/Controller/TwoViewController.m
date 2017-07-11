//
//  TwoViewController.m
//  OCPRO
//
//  Created by shiqianren on 2017/5/3.
//  Copyright © 2017年 shiqianren. All rights reserved.
//

#import "TwoViewController.h"
#import "SpecialViewController.h"
#import "FindViewController.h"
#import "ActivityViewController.h"
#import "AppSetting.h"
#import "TitleView.h"
@interface TwoViewController ()<UIScrollViewDelegate,TitleViewDelegate>
@property (nonatomic , strong) NSMutableArray *childViews;
@property (nonatomic, weak) UIScrollView *scrollView;
@property (nonatomic,weak) TitleView *titleView;

@end

@implementation TwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	self.view.backgroundColor = [UIColor whiteColor];
     //添加titleView
	[self setUpTitleView];
	 //添加滚动视图
	[self setUpScroll];
	
}

-(void)setUpTitleView{
	TitleView *tv = [[TitleView alloc] init];
	tv.delegate = self;
	tv.frame = CGRectMake(0, 0, 200, 30);
	self.navigationItem.titleView = tv;
	self.titleView = tv;
}

-(NSMutableArray *)childViews{
	if (!_childViews){
		_childViews = [NSMutableArray array];
	}
	return _childViews;
}

-(void)setUpScroll{
	SpecialViewController *specialVc = [[SpecialViewController alloc]init];
	[self addChildViewController:specialVc];
	FindViewController *findVc = [[FindViewController alloc] init];
	[self addChildViewController:findVc];
	ActivityViewController *activityVc = [[ActivityViewController alloc] init];
	[self addChildViewController:activityVc];
	//将这几个控制器的view添加到数组中
	[self.childViews addObject:specialVc.view];
	[self.childViews addObject:findVc.view];
	[self.childViews addObject:activityVc.view];
	
	UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
	scrollView.delegate = self;
	[self.view addSubview:scrollView];
	for (int i =0 ; i< self.childViews.count; i++) {
		CGFloat childVX = PortraitWidth*i;
		UIView *childV = self.childViews[i];
		childV.frame = CGRectMake(childVX, 0, PortraitWidth, self.view.height);
		[scrollView addSubview:childV];
	}
	//设置滚动的属性
	scrollView.showsVerticalScrollIndicator = NO;
	scrollView.showsHorizontalScrollIndicator = NO;
	scrollView.pagingEnabled = YES;
	scrollView.contentSize = CGSizeMake(PortraitWidth*3, 0);
	scrollView.bounces = NO;
	self.scrollView = scrollView;
	
}

-(void)scrollToIndex:(NSInteger)tagIndex{

	[self.scrollView scrollRectToVisible:CGRectMake(PortraitWidth*tagIndex, 0, PortraitWidth, PortraitHeight) animated:YES];
	
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
	if (scrollView.contentOffset.x/PortraitWidth == 0){
		[self.titleView tagSelected:0];
	}else if (scrollView.contentOffset.x/PortraitWidth == 1){
		[self.titleView tagSelected:1];
	}else if (scrollView.contentOffset.x/PortraitWidth == 2){
		[self.titleView tagSelected:2];
	}

}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
