//
//  TabBarViewController.m
//  OCPRO
//
//  Created by shiqianren on 2017/5/3.
//  Copyright © 2017年 shiqianren. All rights reserved.
//
#import "OneViewController.h"
#import "TwoViewController.h"
#import "ThreeViewController.h"
#import "TabBarViewController.h"
#import "ProNavViewController.h"
@interface TabBarViewController ()

@end

@implementation TabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	[self setupAllChildViewControllers];
	//设置文字颜色
	self.tabBar.tintColor = [UIColor orangeColor];
	
	//常规状态
	[[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
													   [UIColor lightGrayColor], NSForegroundColorAttributeName,
													   nil] forState:UIControlStateNormal];
	//选中状态
	[[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
													   [UIColor blackColor], NSForegroundColorAttributeName,
													   nil] forState:UIControlStateSelected];
	
	self.selectedIndex = 0;
	
}


-(void)setupAllChildViewControllers {
	OneViewController *one = [[OneViewController alloc] init];
	[self addChildViewController:one title:@"首页" imageName:@"tabbar_home" selectedImageName:@"tabbar_home_selected"];
	
	TwoViewController *two = [[TwoViewController alloc] init];
	[self addChildViewController:two title:@"探索" imageName:@"tabbar_discover"  selectedImageName:@"tabbar_discover_selected"];
	ThreeViewController *three = [[ThreeViewController alloc]init];
	[self addChildViewController:three title:@"个人" imageName:@"tabbar_profile"  selectedImageName:@"tabbar_profile_selected"];
	
	
}


/**
 *  初始化一个子控制器
 *
 *  @param childVc           需要初始化的子控制器
 *  @param title             标题
 *  @param imageName         图标
 *  @param selectedImageName 选中的图标
 */
- (void)addChildViewController:(UIViewController *)childVc title:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName
{
	// 始终绘制图片原始状态，不使用Tint Color,系统默认使用了Tint Color（灰色）
	[childVc.tabBarItem setImage:[[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
	[childVc.tabBarItem setSelectedImage:[UIImage imageNamed:selectedImageName]];
	childVc.tabBarItem.title = title;
	// 2.包装一个导航控制器
	ProNavViewController *nav = [[ProNavViewController alloc] initWithRootViewController:childVc];
	[self addChildViewController:nav];
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
