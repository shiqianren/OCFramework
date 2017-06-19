//
//  DetailViewController.m
//  OCPRO
//
//  Created by shiqianren on 2017/6/14.
//  Copyright © 2017年 shiqianren. All rights reserved.
//

#import "DetailViewController.h"
#import "NSObject+ProgressHud.h"
#import "UIViewController+ProAlertView.h"
#import "Masonry.h"
#import "Macros.h"
#import "UIViewController+BackButtonHandler.h"
#import "HomeWebservice.h"
@interface DetailViewController ()
@property (nonatomic , strong) UIButton *redirectButton;
@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	self.title = @"测试详情信息";
	self.view.backgroundColor = [UIColor whiteColor];
	[self.view addSubview:self.redirectButton];
    // Do any additional setup after loading the view.
}
-(UIButton *)redirectButton{
	if (!_redirectButton) {
		_redirectButton = [[UIButton alloc] init];
		_redirectButton.backgroundColor = [UIColor redColor];
		[_redirectButton addTarget:self action:@selector(redirect) forControlEvents:UIControlEventTouchUpInside];
		[self.view addSubview:_redirectButton];
		[_redirectButton setTitle:@"跳转成功" forState:UIControlStateNormal];
		[_redirectButton.titleLabel setFont:PRO_FontSize(16)];
		[_redirectButton mas_makeConstraints:^(MASConstraintMaker *make) {
			make.center.equalTo(self.view);
			make.size.mas_equalTo(CGSizeMake(100, 100));
		}];
		
	}
 
	return _redirectButton;
	
}

-(void)redirect{
	
	[[HomeWebservice shareInstance] getGradeList:^(BOOL success, BaseResponse *response) {
	
		if (success == true) {
			NSLog(@"获取相应数据-----%@",	response.object);
		}else {
		
		}
		
		
	}];
	NSLog(@"%@", self.navigationController.childViewControllers);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)navigationShouldPopOnBackButton{
	[[[UIAlertView alloc] initWithTitle:@"提示" message:@"确定返回上一界面?"
							   delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil] show];
	return NO;
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
