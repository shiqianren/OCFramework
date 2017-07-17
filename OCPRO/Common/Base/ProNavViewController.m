//
//  ProNavViewController.m
//  OCPRO
//
//  Created by shiqianren on 2017/5/3.
//  Copyright © 2017年 shiqianren. All rights reserved.
//

#import "ProNavViewController.h"
#import "AppDelegate.h"
#import "UIImage+UIColor.h"
@interface ProNavViewController ()<UINavigationControllerDelegate,UIGestureRecognizerDelegate>

@end

@implementation ProNavViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	self.delegate = self;
	[self setupAppearance];
	// Do any additional setup after loading the view.
	__weak ProNavViewController *weakSelf = self;
	if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)])
		
	{
		
		self.interactivePopGestureRecognizer.delegate = weakSelf;
		
	}
    // Do any additional setup after loading the view.
}
- (void)setupAppearance
{
	// 配置导航栏默认状态
	[self.navigationBar setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]]
							 forBarMetrics:UIBarMetricsDefault];
	[self.navigationBar setTitleTextAttributes:@{ NSForegroundColorAttributeName : [UIColor blackColor],
												  NSShadowAttributeName : [NSShadow new],
												  NSFontAttributeName : [UIFont systemFontOfSize:17]}];
	
}

- (void)pushViewController:(UIViewController *)viewController
				  animated:(BOOL)animated
{
	if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]){
		self.interactivePopGestureRecognizer.enabled = NO;
	}
	if ([self.viewControllers count] >= 1)
	{
		viewController.hidesBottomBarWhenPushed = YES;
	}
	[super pushViewController:viewController animated:animated];
	if (viewController.navigationItem.leftBarButtonItem == nil && [self.viewControllers count] > 1)
	{
		UIImage *norImage  = [UIImage imageNamed:@"btn_back"];
		UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
		[btn setBackgroundImage:norImage forState:UIControlStateNormal];
		[btn addTarget:self action:@selector(didLeftBarButtonItemAction:) forControlEvents:UIControlEventTouchUpInside];
		[btn sizeToFit];
		UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
		UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
		negativeSpacer.width = -10;
		viewController.navigationItem.leftBarButtonItems = @[negativeSpacer, backItem];
	}
}


- (void)presentViewController:(UIViewController *)viewControllerToPresent
					 animated:(BOOL)flag
				   completion:(void (^)(void))completion
{
	if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)])
	{
		self.interactivePopGestureRecognizer.enabled = NO;
	}
	if ([self.viewControllers count] >= 1)
	{
		viewControllerToPresent.hidesBottomBarWhenPushed = YES;
	}
	[super presentViewController:viewControllerToPresent animated:flag completion:completion];
	if (viewControllerToPresent.navigationItem.leftBarButtonItem == nil)
	{
		UIImage *norImage  = [UIImage imageNamed:@"btn_back"];
		//        UIImage *higlImage = [UIImage imageNamed:@"back_high"];
		UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
		[btn setBackgroundImage:norImage forState:UIControlStateNormal];
		//        [btn setBackgroundImage:higlImage forState:UIControlStateHighlighted];
		[btn addTarget:self action:@selector(didLeftBarButtonItemAction:) forControlEvents:UIControlEventTouchUpInside];
		[btn sizeToFit];
		UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
		viewControllerToPresent.navigationItem.leftBarButtonItem = backItem;
		//        viewController.navigationItem.leftBarButtonItem =[[UIBarButtonI
	}
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
	if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)])
	{
		
		self.interactivePopGestureRecognizer.enabled = YES;
	}
	
	// show homePage
	AppDelegate *appDeletegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
	if (appDeletegate.showHome >= 0)
	{
		[appDeletegate showHomePage:appDeletegate.showHome];
	}
}



- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer

{
	if (gestureRecognizer == self.interactivePopGestureRecognizer)
	{
		// 防止rootViewController卡死界面
		if (self.viewControllers.count < 2 || self.visibleViewController == [self.viewControllers objectAtIndex:0])
		{
			
			return NO;
		}
		
	}
	return YES;
}

- (void)didLeftBarButtonItemAction:(id)sender
{
	id vc = self.viewControllers.lastObject;
	[super popViewControllerAnimated:YES];
	vc = nil;
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
