//
//  OneViewController.m
//  OCPRO
//
//  Created by shiqianren on 2017/5/3.
//  Copyright © 2017年 shiqianren. All rights reserved.
//

#import "OneViewController.h"
#import "Masonry.h"
#import "Macros.h"
#import "OneViewController.h"
#import "DetailViewController.h"
#import "XRCarouselView.h"
@interface OneViewController ()
@property (nonatomic , strong) UIButton *redirectButton;
@end

@implementation OneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	self.view.backgroundColor = [UIColor whiteColor];
	self.title = @"首页";
	[self.view addSubview:self.redirectButton];
    // Do any additional setup after loading the view.
}


-(UIButton *)redirectButton{
	/**
	XRCarouselView *view = [XRCarouselView carouselViewWithImageArray:imageUrls describeArray:nil];
	view.time = 2.0;
	view.delegate = self;
	view.frame = self.contentView.bounds;
	[self.contentView addSubview:view];
	*/
	if (!_redirectButton) {
		_redirectButton = [[UIButton alloc] init];
		_redirectButton.backgroundColor = [UIColor redColor];
		[_redirectButton addTarget:self action:@selector(redirect) forControlEvents:UIControlEventTouchUpInside];
		[self.view addSubview:_redirectButton];
		[_redirectButton setTitle:@"跳转" forState:UIControlStateNormal];
		[_redirectButton.titleLabel setFont:PRO_FontSize(16)];
		[_redirectButton mas_makeConstraints:^(MASConstraintMaker *make) {
			make.center.equalTo(self.view);
			make.size.mas_equalTo(CGSizeMake(100, 100));
		}];
		
	}
 
	return _redirectButton;

}

-(void)redirect{
	
	DetailViewController *onview = [[DetailViewController alloc] init];
	[self.navigationController pushViewController:onview animated:true];
	

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
