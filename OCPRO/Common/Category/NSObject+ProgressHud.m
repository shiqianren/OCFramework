//
//  NSObject+ProgressHud.m
//  OCPRO
//
//  Created by shiqianren on 2017/6/14.
//  Copyright © 2017年 shiqianren. All rights reserved.
//

#import "NSObject+ProgressHud.h"
#import "Macros.h"
#import "UIImage+GIF.h"
@implementation NSObject (ProgressHud)


/** 获取当前屏幕的最上方正在显示的那个view */
- (UIView *)getCurrentView
{
	UIViewController *vc = [UIApplication sharedApplication].keyWindow.rootViewController;
	// vc: 导航控制器, 标签控制器, 普通控制器
	if ([vc isKindOfClass:[UITabBarController class]])
	{
		vc = [(UITabBarController *)vc selectedViewController];
	}
	if ([vc isKindOfClass:[UINavigationController class]])
	{
		vc = [(UINavigationController *)vc visibleViewController];
	}
	
	return vc.view;
}
/*弹出文字显示*/
-(void)Pro_showAlert:(NSString *)text{
	PRO_WEAKSELF;
	// 防止在非主线程中调用此方法,会报错
	dispatch_async(dispatch_get_main_queue(), ^{
		
		// 弹出新的提示之前,先把旧的隐藏掉
		//        [self hideProgress]; // 主线程中会先调用这个，所以速度很快
		
		[MBProgressHUD hideHUDForView:[weakSelf getCurrentView] animated:true];
		MBProgressHUD *progressHUD = [MBProgressHUD showHUDAddedTo:[weakSelf getCurrentView] animated:YES];
		
		progressHUD.mode = MBProgressHUDModeIndeterminate;
		progressHUD.label.text = text;
		//progressHUD.backgroundColor = [UIColor lightGrayColor];
		progressHUD.color = [UIColor blackColor];
		progressHUD.minSize = CGSizeMake(150.f, 100.f);
		[progressHUD hideAnimated:YES afterDelay:1.5];
	});
	
}
/** 弹出文字提示，自定义显示时间 */
- (void)Pro_showAlertWithTitle:(NSString *)text
{
	PRO_WEAKSELF;
	// 防止在非主线程中调用此方法,会报错
	dispatch_async(dispatch_get_main_queue(), ^{
		
		// 弹出新的提示之前,先把旧的隐藏掉
		//        [self hideProgress]; // 主线程中会先调用这个，所以速度很快
		[MBProgressHUD hideHUDForView:[weakSelf getCurrentView] animated:YES];
		MBProgressHUD *progressHUD = [MBProgressHUD showHUDAddedTo:[weakSelf getCurrentView] animated:YES];
		
		progressHUD.mode = MBProgressHUDModeText;
		progressHUD.label.text = text;
		//        progressHUD.color = BA_Orange_Color;
		//        if (!time || time == 0)
		//        {
		//            [progressHUD hide:YES afterDelay:1.5];
		//            return ;
		//        }
		progressHUD.color = [UIColor blackColor];
		[progressHUD hideAnimated:YES afterDelay:1.5];
	});
}


/** 显示忙 */
- (void)Pro_showBusy
{
	PRO_WEAKSELF;
	[[NSOperationQueue mainQueue] addOperationWithBlock:^{
		[MBProgressHUD hideHUDForView:[weakSelf getCurrentView] animated:YES];
		MBProgressHUD *progressHUD = [MBProgressHUD showHUDAddedTo:[weakSelf getCurrentView] animated:YES];
		progressHUD.backgroundView.style = MBProgressHUDBackgroundStyleSolidColor;
		progressHUD.minSize = CGSizeMake(150.f, 100.f);
		//progressHUD.backgroundView.color = [UIColor colorWithWhite:0.f alpha:0.1f];
		progressHUD.color = [UIColor blackColor];
		// 最长显示30秒
		[progressHUD hideAnimated:YES afterDelay:30];
	}];
}

-(void)Pro_checkMarkProgress:(NSString *)text{
	
	PRO_WEAKSELF;
	// 防止在非主线程中调用此方法,会报错
	dispatch_async(dispatch_get_main_queue(), ^{
		
		// 弹出新的提示之前,先把旧的隐藏掉
		//        [self hideProgress]; // 主线程中会先调用这个，所以速度很快
		[MBProgressHUD hideHUDForView:[weakSelf getCurrentView] animated:YES];
		
		MBProgressHUD *progressHUD = [MBProgressHUD showHUDAddedTo:[weakSelf getCurrentView] animated:YES];
		UIImage *image = [[UIImage imageNamed:@"Checkmark"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
		
		progressHUD.customView = [[UIImageView alloc] initWithImage:image];
		// Looks a bit nicer if we make it square.
		progressHUD.square = YES;
		progressHUD.label.text = text;
		progressHUD.mode = MBProgressHUDModeCustomView;
		progressHUD.color = [UIColor blackColor];
		//[progressHUD hideAnimated:YES afterDelay:1.5];
	});
}
-(void)Pro_progress{
	
	PRO_WEAKSELF;
	// 防止在非主线程中调用此方法,会报错
	dispatch_async(dispatch_get_main_queue(), ^{
		
		// 弹出新的提示之前,先把旧的隐藏掉
		//        [self hideProgress]; // 主线程中会先调用这个，所以速度很快
		[MBProgressHUD hideHUDForView:[weakSelf getCurrentView] animated:YES];
		UIImage  *image=[UIImage sd_animatedGIFNamed:@"run"];
		MBProgressHUD *progressHUD = [MBProgressHUD showHUDAddedTo:[weakSelf getCurrentView] animated:YES];
		UIImageView  *gifview=[[UIImageView alloc]initWithFrame:CGRectMake(0,0,image.size.width, image.size.height)];
		gifview.image = image;
		progressHUD.customView = [[UIImageView alloc] initWithImage:image];
		progressHUD.color = [UIColor clearColor];
		progressHUD.mode = MBProgressHUDModeCustomView;
		[progressHUD hideAnimated:YES afterDelay:1.5];
	});
}

/** 隐藏提示 */
- (void)BA_hideProgress
{
	PRO_WEAKSELF;
	[[NSOperationQueue mainQueue] addOperationWithBlock:^{
		[MBProgressHUD hideHUDForView:[weakSelf getCurrentView] animated:YES];
	}];
}

@end
