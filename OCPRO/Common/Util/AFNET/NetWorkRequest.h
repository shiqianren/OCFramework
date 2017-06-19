//
//  NetWorkRequest.h
//  OCPRO
//
//  Created by shiqianren on 2017/5/3.
//  Copyright © 2017年 shiqianren. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreFoundation/CoreFoundation.h>
#import "BaseResponse.h"
#import "LSDBaseNetRequest.h"
#import "AFNetworking.h"
#import "AFAppDotNetAPIClient.h"
/**
 *  请求成功/失败/进度block
 */
typedef void(^DidFinishRequestBlock)(id object, NSInteger code);
typedef void(^DidFailRequestBlock)(BaseResponse *object);
typedef void(^RequestProgressBlock)(float progressValue);

typedef enum
{
    NO_ENCRYPT = 0,  // 未加密
    AES_ENCRYPT = 1, // aes 登录后加密
    RSA_ENCRYPT = 2, // rsa 登录前加密
    MD5_ENCRYPT =3,  //md5 加密
}encryptType;

typedef enum
{
    REQ_POST = 0,  // post请求
    REQ_GET = 1, // get请求
    
}reqType;

@interface NetWorkRequest : LSDBaseNetRequest
//使用自己写的网络库
+(void)sendRequest:(NSString*)requestUrl params:(NSMutableDictionary *)params reqType:(NSInteger)reqType eType:(NSInteger)eType success:(DidFinishRequestBlock)successBlock fail:(DidFailRequestBlock)failBlock;
- (void)post:(NSString *)urlStirng andParams:(NSMutableDictionary *)params andType:(NSInteger)reqType getAddressBook:(void(^)(NSDictionary* ,NSString *))complete;


//使用afn网络请求
+ (void)sendRequestUseAFN:(NSString*)requestUrl params:(id)params reqType:(NSInteger)reqType eType:(NSInteger)eType success:(DidFinishRequestBlock)successBlock fail:(DidFailRequestBlock)failBlock;

+(void)sendRequest:(NSString *)requesturl params:(NSMutableDictionary *)param;

@end
