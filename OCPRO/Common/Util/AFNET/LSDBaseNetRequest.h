//
//  LBGNetRequest.h
//  BlueGenie
//
//  Created by lsd on 14-8-18.
//  Copyright (c) 2014年 LSD_SDBU(软件事业部). All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppSetting.h"
@protocol LBGNetRequestDelegate <NSObject>

//-(void)LBGNetRequestDelegateSucess:(NSDictionary *)infoDic;
/**
 *  代理
 *
 *  @param result  结果   1 表示成功 －1002 app 手机网络问题  －10001 服务器的数据格式错误 -1001 超时
 *  @param message 对结果的描述
 */
-(void)LBGNetRequestDelegateFinish:(NSInteger)result withMessage:(NSString *)message WithFunctionName:(NSString *)functionName;

@end

/**
 *  block 回调
 *
 *  @param result  请求结果
 *  @param message 请求结果描述
 */
typedef void(^LBGNetRequestBlock)(NSDictionary *result,NSString * message);

typedef NS_ENUM(NSInteger, NetRequestType) {
    NetGet,
    NetPost,
    NetPut
};


@interface LSDBaseNetRequest : NSObject


@property (nonatomic, weak)id <LBGNetRequestDelegate>delegate;

@property (nonatomic,copy) LBGNetRequestBlock netRequestBlock;

@property (nonatomic, strong) NSString * functionName; //回调区分



/**
 *  最后一步组装要发送的数据，所有请求数据都要经过此步骤
 *
 *  @param withReq  withReq 由于服务器用rest方法，都是资源路径
 *  @param netType  post、get、put方法
 *  @param param    参数，http的body数据
 *  @param funcName delegate 回调函数的区分标志
 *  @param complete 如果不使用delegete 则使用block 回调  如果 result ＝ 1 表示成功，返回成功的数据， 否则失败 ，infoDic 为nil message 为对result 的解释
 */
-(void)assimbleNetRequestDate:(NSString *)withReq withNetRequestType:(NetRequestType)netType postData:(NSData *)param withFunctionName:(NSString *)funcName withBackBlock:(void(^)(NSDictionary  *result,NSString * message))complete;


/**
 *  子类重写，如果不进行数据处理也可以不重写  infoDic 是数据字典
 *
 *  @param code    数据结果，
 *  @param message 数据结果解释
 *  @param infoDic 如果成功，成功的数据
 */
- (void)netDataWithResult:(NSInteger)code withMessage:(NSString *)message withInfoDic:(NSDictionary *)infoDic withBlock:(void(^)())complete;

@end
