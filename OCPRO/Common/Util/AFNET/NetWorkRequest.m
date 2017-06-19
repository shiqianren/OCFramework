//
//  NetWorkRequest.m
//  OCPRO
//
//  Created by shiqianren on 2017/5/3.
//  Copyright © 2017年 shiqianren. All rights reserved.
//

#import "NetWorkRequest.h"
#import "AppSetting.h"
#import "NSData+Base64.h"
#import "NetWorkObserver.h"
#import "Macro.h"
#import "AFAppDotNetAPIClient.h"
#import <CommonCrypto/CommonDigest.h>
#import "Reachability.h"

@implementation NetWorkRequest
+(void )sendRequest:(NSString*)requestUrl params:(NSMutableDictionary *)params reqType:(NSInteger)reqType eType:(NSInteger)eType success:(DidFinishRequestBlock)successBlock fail:(DidFailRequestBlock)failBlock
{
    switch (reqType) {
        case REQ_POST:
        {
            
            [self post:requestUrl params:params eType:eType completion:^(NSDictionary *object, NSInteger finishCode) {
                BaseResponse *response = [BaseResponse modelObjectWithDictionary:object];
                if (response && [response.code isEqualToString:ASK_SERVER_SUCCESS]) {
                    if (successBlock) {
                        successBlock(response, finishCode);
                    }
                }else {
                    if (failBlock) {
                        failBlock(response);
                    }
                }
            }];
        }
            break;
        case REQ_GET:
            
            break;
        default:
            break;
    }
}
- (void)post:(NSString *)urlStirng andParams:(NSMutableDictionary *)params andType:(NSInteger)reqType getAddressBook:(void(^)(NSDictionary* ,NSString *))complete{
    NSError * error = nil;
    NSData * jsonData = nil;
    if (params) {
        jsonData = [NSJSONSerialization dataWithJSONObject:params
                                                   options:NSJSONWritingPrettyPrinted
                                                     error:&error];
    }
    
    [self assimbleNetRequestDate:urlStirng
              withNetRequestType:NetPost
                        postData:jsonData
                withFunctionName:@"getServiceItem"
                   withBackBlock:complete];
}

+ (void )post:(NSString *)baseUrl params:(NSMutableDictionary *)params eType:(NSInteger)eType completion:(void (^)(NSDictionary *object, NSInteger code))completion
{
    __block NetWorkRequest * list = [[NetWorkRequest alloc] init];
    [list post:baseUrl andParams:params andType:eType getAddressBook:^(NSDictionary *result, NSString * message) {
        completion(result, 1);
        
    }];
}

#pragma mark----USE AFN
+ (void)sendRequestUseAFN:(NSString*)requestUrl params:(id)params reqType:(NSInteger)reqType eType:(NSInteger)eType success:(DidFinishRequestBlock)successBlock fail:(DidFailRequestBlock)failBlock{
    // 判断联网情况
    //如果没有联网，直接failBlock，并return
    // 借助Reachability 否则恢复网络之后，不能检测到
    BOOL isReachable = [AFNetworkReachabilityManager sharedManager].reachable;
    if (!isReachable) {
        Reachability *reachability = [Reachability reachabilityForInternetConnection];
        NetworkStatus networkStatus = [reachability currentReachabilityStatus];
        if (networkStatus != NotReachable) {
            isReachable = YES;
        } else {
            isReachable = NO;
        }
    }
    if (!isReachable) {
        NSDictionary *responseDic = [[NSDictionary alloc] initWithObjectsAndKeys:@"当前无网络连接",@"message", ASK_NET_FAILED, @"code", @"NONET",@"data",nil];
        BaseResponse *response = [BaseResponse modelObjectWithDictionary:responseDic];
        failBlock(response);
        return;
    }
    
    AFHTTPSessionManager *manager =nil;
    NSLog(@"Params: %@", params);
    switch (reqType) {
        case REQ_POST:
        {
            NSString * urlString = [NSString stringWithFormat:@"%@%@",kLSDBaseNetURL,requestUrl];
            NSLog(@"URL: %@", urlString);
            manager= [self postUseAFN:urlString params:params completion:^(NSDictionary *object, NSInteger finishCode) {
                BaseResponse *response = [BaseResponse modelObjectWithDictionary:object];
                if (response && finishCode) {
                    if (successBlock) {
                        successBlock(response, finishCode);
                    }
                }else {
                    if (failBlock) {
                        failBlock(response);
                    }
                }
            }];
        }
            break;
        case REQ_GET:
        {
            NSString * urlString = [NSString stringWithFormat:@"%@%@",kLSDBaseNetURL,requestUrl];
            NSLog(@"URL: %@", urlString);
            manager= [self getUseAFN:urlString params:params completion:^(NSDictionary *object, NSInteger finishCode) {
                BaseResponse *response = [BaseResponse modelObjectWithDictionary:object];
                if (response && finishCode) {
                    if (successBlock) {
                        successBlock(response, finishCode);
                    }
                }else {
                    if (failBlock) {
                        failBlock(response);
                    }
                }
            }];
        }
            
            break;
        default:
            break;
    }
}

+ (AFAppDotNetAPIClient *)postUseAFN:(NSString *)baseUrl params:(id)params completion:(void (^)(NSDictionary *object, NSInteger code))completion
{
    AFAppDotNetAPIClient *manager = [self getManager];
    
    [manager POST:baseUrl
       parameters:params
         progress:nil
          success:[self successBlockWithParams:params completion:completion baseUrl:baseUrl]
          failure:[self failureBlockWithParams:params completion:completion baseUrl:baseUrl]];
    
    return manager;
}

+ (AFAppDotNetAPIClient *)getUseAFN:(NSString *)baseUrl params:(id)params completion:(void (^)(NSDictionary *object, NSInteger code))completion
{
    AFAppDotNetAPIClient *manager = [self getManager];
    
    [manager GET:baseUrl
      parameters:params
        progress:nil
         success:[self successBlockWithParams:params completion:completion baseUrl:baseUrl]
         failure:[self failureBlockWithParams:params completion:completion baseUrl:baseUrl]];
    
    return manager;
}

+(void)sendRequest:(NSString *)requesturl params:(NSMutableDictionary *)param{
    NSString * urlString = [NSString stringWithFormat:@"%@%@",kLSDBaseNetURL,requesturl];
    
    AFAppDotNetAPIClient *manager = [self getManager];
    
    [manager POST:urlString parameters:param progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
//        NSLog(@"hhhhhh%@",responseObject);
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
//        NSLog(@"hhhhhh%@",error);
    }];
}

+ (AFAppDotNetAPIClient *)getManager
{
    AFAppDotNetAPIClient *manager = [AFAppDotNetAPIClient sharedClient];
    
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [manager.requestSerializer setValue:@"application/json"forHTTPHeaderField:@"Accept"];
    
     
    [manager.requestSerializer setValue:@"application/json"forHTTPHeaderField:@"Content-Type"];
    
    [manager.requestSerializer setValue:@"XMLHttpRequest"forHTTPHeaderField:@"X-Requested-With"];
    /**
    NSString *token = [[TheLoginManeger shareManager] Token];
    
    NSLog(@"token: %@",token);
    
    UserInfo * userInfo = [[TheLoginManeger shareManager] getUserInfo];
    
    if (userInfo != nil) {
        [manager.requestSerializer setValue:userInfo.token forHTTPHeaderField:@"Authorization"];
        NSLog(@"Authorization: %@",userInfo.token);
    }
    
    if(![theUtility isEmpty:token]){
        [manager.requestSerializer setValue:token forHTTPHeaderField:@"token"];
    }
	 [manager.requestSerializer setValue:[AppSetting appVersion] forHTTPHeaderField:@"version"];
	 NSString *mobileCode = [[TheLoginManeger shareManager] getMobileCode];
	 NSLog(@"mobileCode: %@",mobileCode);
	 if (![theUtility isEmpty: mobileCode]) {
	 [manager.requestSerializer setValue:mobileCode forHTTPHeaderField:@"mobileCode"];
	 }
	 
    **/
    [manager.requestSerializer setValue:@"ios" forHTTPHeaderField:@"from"];
    [manager.requestSerializer setTimeoutInterval:60];
  
    return manager;
}

+ (void (^)(NSURLSessionDataTask * _Nonnull, id _Nullable))successBlockWithParams:(id)params
                                                                       completion:(void (^)(NSDictionary *object, NSInteger code))completion
                                                                          baseUrl:(NSString *)baseUrl
{
    return ^(NSURLSessionDataTask *task, id responseObject) {
        
        NSMutableDictionary *responseDic = [NSMutableDictionary dictionaryWithDictionary:responseObject];
        [responseDic setValue:params forKey:@"params"];
        
        NSString  *result = [NSString stringWithFormat:@"%@", responseDic[@"code"]];
        
        if ([result isEqualToString: ASK_SERVER_SUCCESS]) {                                             //成功
            if (completion) {
                completion(responseDic, 1);
            }
        } else if ([result isEqualToString: ASK_NO_RECORD]) {                                           //成功，没有找到参数
            if (completion) {
                completion(responseDic, 1);
            }
        } else if ([result isEqualToString: ASK_SERVER_FAILED] || [result isEqualToString: @"3"]) {     //失败
            if (completion) {
                completion(responseDic, 0);
            }
        } else if ([result isEqualToString: ASK_SERVER_ERROR]) {
            if (completion) {
                NSDictionary *response = [[NSDictionary alloc] initWithObjectsAndKeys:@"请求报错了！",@"message", ASK_NET_FAILED, @"code", nil];
                completion(response, 0);
            }
        } else if ([result isEqualToString: ASK_SERVER_RELOGIN]) {
            if (completion) {
                completion(responseDic, 0);
            }
        } else if ([result isEqualToString: ASK_SERVER_LOWVERSION]) {
            if (completion) {
                completion(responseDic, 0);
            }
        } else if ([result isEqualToString:TOKEN_IDERROR]) {
			/*
            if (completion) {
                NSString *lastLoginGrade = [[NSUserDefaults standardUserDefaults] objectForKey:@"lastLoginGrade"];
                NSString *lastLoginProvince = [[NSUserDefaults standardUserDefaults] objectForKey:@"lastLoginProvince"];
                lastLoginGrade = lastLoginGrade == nil ? @"4" : lastLoginGrade;
                [[CheckAnswerWebservice shareInstance] loginWithGrade:lastLoginGrade province:lastLoginProvince checkSb:^(BOOL success, BaseResponse *response)
                 {
                     if (success) {
                         [[NSUserDefaults standardUserDefaults] setObject:response.object forKey:@"token"];
                         [self postUseAFN:baseUrl params:params  completion:completion];
                     } else {
                         NSDictionary *response = [[NSDictionary alloc] initWithObjectsAndKeys:@"请求报错了！",@"message", TOKEN_IDERROR, @"code", nil];
                         completion(response, 0);
                     }
                 }];
            }
			 */
        } else {
            if (completion) {
                completion(responseDic, 0);
            }
        }
    };
}

+ (void (^)(NSURLSessionDataTask * _Nullable, NSError * _Nonnull))failureBlockWithParams:(id)params
                                                                              completion:(void (^)(NSDictionary *object, NSInteger code))completion
                                                                                 baseUrl:(NSString *)baseUrl
{
    return ^(NSURLSessionDataTask *task, NSError *error){
        
        NSLog(@"请求失败－－－》%@ \n %@  \n and error code %ld  %@",error.localizedDescription,error.localizedFailureReason,(long)error.code,baseUrl);
        
        NSString *netType = [[NetWorkObserver netWorkObserverShare] getNetWorkType];
        if ([netType isEqualToString:@"unknown"]) {                             // 网络无连接错误
            NSDictionary *response = [[NSDictionary alloc] initWithObjectsAndKeys:@"当前无网络连接",@"message", ASK_NET_FAILED, @"code", @"NONET",@"data",nil];
            if (completion) {
                completion(response, 0);
            }
        } else if ([error.localizedDescription containsString:@"unauthorized (401)"]){                                                                // 别的未知错误,服务器正在维护，请稍后再试
            if (completion) {
                NSDictionary *response = [[NSDictionary alloc] initWithObjectsAndKeys:@"用户已在其他设备登陆，请重新登陆",@"message", ASK_SERVER_RELOGIN, @"code", nil];
                completion(response, 0);
            }
        } else {                                                                // 别的未知错误,服务器正在维护，请稍后再试
            if (completion) {
                NSString *errorString  = [NSString stringWithFormat:@"请求出错,请稍后重试,错误原因:%@",error.localizedDescription];
                NSDictionary *response = [[NSDictionary alloc] initWithObjectsAndKeys:errorString,@"message", ASK_SERVER_FAILED, @"code", nil];
                completion(response, 0);
            }
        }
    };
}

@end
