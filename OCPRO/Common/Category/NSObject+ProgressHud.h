//
//  NSObject+ProgressHud.h
//  OCPRO
//
//  Created by shiqianren on 2017/6/14.
//  Copyright © 2017年 shiqianren. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBProgressHUD.h"
@interface NSObject (ProgressHud)

/*!
 *  弹出文字提示（菊花转动）
 *
 *  @param text 提示内容
 */
- (void)Pro_showAlert:(NSString *)text;

/*!
 *  弹出文字提示，自定义显示时间(默认1.5秒)
 *
 *  @param text 提示内容
 */
- (void)Pro_showAlertWithTitle:(NSString *)text;

/*!
 *  显示忙
 */
- (void)Pro_showBusy;

/*!
 *  隐藏提示
 */
- (void)BA_hideProgress;

/*
 自定义图显示
 */
-(void)Pro_checkMarkProgress:(NSString *)text;

/*
 自定义GIF图显示
 */
-(void)Pro_progress;

@end
