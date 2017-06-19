//
//  LBGNetRequest.m
//  BlueGenie
//
//  Created by lsd on 14-8-18.
//  Copyright (c) 2014年 LSD_SDBU(软件事业部). All rights reserved.
//

#import "LSDBaseNetRequest.h"
#import "theUtility.h"
#import "Macro.h"
#import "NetWorkObserver.h"
static NSInteger firstStart;
@interface  LSDBaseNetRequest() <NSURLConnectionDataDelegate>


@property (nonatomic,strong) NSMutableData * receiveData;



#define TIMEOUTINTERVAL  20
#define NETNAME  @"netName"



/**
 *  连接失败
 *
 *  @param error 返回一个 NSError 的失败信息
 */
- (void)netConnectionDidFailWithError:(NSError *)error;

/**
 *  获取数据成功
 *
 *  @param theConnectionData 返回NSData 的json 数据，
 */
-(void) netConnectionDidFinishLoading:(NSData *)theConnectionData;

@end

@implementation LSDBaseNetRequest


-(void)assimbleNetRequestDate:(NSString *)withReq withNetRequestType:(NetRequestType)netType postData:(NSData *)param withFunctionName:(NSString *)funcName withBackBlock:(void(^)(NSDictionary *result,NSString * message))complete{
    
#ifdef kInDebug
    complete(kNetSucess,@"测试");
    return;
#endif
    
    NSMutableString * str = [[NSMutableString alloc] init];
   
    firstStart = 1;
    
    _functionName = funcName;
    _netRequestBlock = complete;
    
    NSString * netName = kLSDBaseNetURL;
    
    [str appendString:netName];
 
    [str appendString:withReq];
    
    NSString * method = nil;
    
    if (netType == NetGet ) {
        method = @"GET";
    }else if (netType == NetPost ) {
        method = @"POST";

    }else if (netType == NetPut ) {
        method = @"PUT";
    }
    NSLog(@"请求的地址为******%@",str);
    [self startRequestNetDataWithUrl:str withParam:param withNetRequestMethod:method];

    
}

-(void)startRequestNetDataWithUrl:(NSString *)urlStr withParam:(NSData *)param withNetRequestMethod:(NSString *)method{
    NSMutableURLRequest *request = nil;
    NSString *urlRequstStr = nil;
    if ([method isEqualToString:@"POST"]||[method isEqualToString:@"PUT"]) {
        urlRequstStr = [urlStr stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
        
        NSURL * requestUrl = [NSURL URLWithString:urlRequstStr];
        NSLog(@"requestUrl == %@",requestUrl);
        
        request = [[NSMutableURLRequest alloc]initWithURL:requestUrl cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:TIMEOUTINTERVAL];
        
        [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];

      /**  NSString *token = [[TheLoginManeger shareManager] Token];
        
        NSLog(@"token------%@",token);
        if(![theUtility isEmpty:token]){
            [request addValue:token forHTTPHeaderField:@"token"];
        }
	   */
        request.HTTPMethod = method;
        if (param) {
            request.HTTPBody = param;
            
        }
    }else{
        
        NSMutableString * mutStr = [[NSMutableString alloc] init];
        [mutStr  appendString:urlStr];
//        [mutStr appendString:[[NSString alloc] initWithData:param encoding:NSUTF8StringEncoding]];
        
        urlRequstStr = [mutStr stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
        
        NSURL * requestUrl = [NSURL URLWithString:urlRequstStr];
        NSLog(@"requestUrl == %@",requestUrl);
        
        
        request = [[NSMutableURLRequest alloc]initWithURL:requestUrl cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:TIMEOUTINTERVAL];
    }
    
    NSURLConnection *connection = [[NSURLConnection alloc]initWithRequest:request delegate:self];
    [connection start];
    
    
}


#pragma mark --- NSURLConnection delegate

-(void) connection:(NSURLConnection *)theConnection didReceiveResponse:(NSURLResponse *)response{
    _receiveData = [[NSMutableData alloc] init ];
    //    [_receiveData setLength:0];
}

-(void) connection:(NSURLConnection *)theConnection didReceiveData:(NSData *)data{
    [_receiveData appendData:data];
    
}


- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    [self netConnectionDidFailWithError:error];
    
}

-(void) connectionDidFinishLoading:(NSURLConnection *)theConnection{
    
    [theConnection cancel];
    
    [self netConnectionDidFinishLoading:_receiveData];
}



/**
 *  连接失败
 *
 *  @param error 返回一个 NSError 的失败信息
 */
- (void)netConnectionDidFailWithError:(NSError *)error{
    NSString * message = nil;
    NSInteger code = 0;
    
    NSString *netType = [[NetWorkObserver netWorkObserverShare] getNetWorkType];
    if ([netType isEqualToString:@"unknown"])
    {
        message = @"您的网络已断开";
    }else{
         message = @"";
    }
   
    [self netDataWithResult:code withMessage:message withInfoDic:nil withBlock:^(){
        
        if ([self.delegate respondsToSelector:@selector(LBGNetRequestDelegateFinish:withMessage:WithFunctionName:)]) {
            [self.delegate LBGNetRequestDelegateFinish:code withMessage:message WithFunctionName:_functionName];
        }
        if (self.netRequestBlock) {
              NSDictionary *response = [[NSDictionary alloc] initWithObjectsAndKeys:message,@"message",ASK_SERVER_FAILED, @"code", nil];
            self.netRequestBlock(response,message);
        }
    }];

}

/**
 *  获取数据成功
 *
 *  @param theConnectionData 返回NSData 的json 数据，子类进行解析处理
 */
-(void) netConnectionDidFinishLoading:(NSData *)theConnectionData{
    if(firstStart == 1){
        firstStart = 10;
        NSString * ss = [[NSString alloc] initWithData:theConnectionData encoding:NSASCIIStringEncoding];
        NSLog(@"ss 日志报告== %@",ss);
        
        
        NSError * error = nil;
        
        NSDictionary * dataDic = (NSDictionary *)[NSJSONSerialization JSONObjectWithData:theConnectionData options:NSJSONReadingMutableContainers error:&error];
        
        NSLog(@"dataDic == %@",dataDic);
        if (!dataDic) {
            [self netConnectionDidFailWithError:nil];
            return;
            
        }
        if (!dataDic || ![dataDic isKindOfClass:[NSDictionary class]]) {
            
            
            if ([self.delegate respondsToSelector:@selector(LBGNetRequestDelegateFinish:withMessage:WithFunctionName:)]) {
                [self.delegate LBGNetRequestDelegateFinish:kDataFormatError withMessage:error.localizedDescription WithFunctionName:_functionName];
                
            }
            if (self.netRequestBlock) {
                self.netRequestBlock (dataDic,error.localizedDescription);
            }
            return;
        }
        //    NSLog(@"dataDic == %@",dataDic);
        
        NSDictionary * dic = [NSDictionary dictionaryWithDictionary:dataDic
                              ];
        NSString * result = [dic objectForKey:@"code"];
        NSString * message = [dic objectForKey:@"message"];
        NSInteger resultInt;
        
        if ([result isEqual:ASK_SERVER_SUCCESS]) {
            resultInt = 1;
            
        }else
            resultInt  = 0;
        
        
        
        if (resultInt == 1 ) {
            message = @"操作成功";
        }
        if (resultInt ==0 ) {
            message = @"状态不明确";
        }
        // 子类实现一定要放在前面，子类完成以后回调给用户 结果
        [self netDataWithResult:resultInt withMessage:message withInfoDic:dic withBlock:^{
            
            if ([self.delegate respondsToSelector:@selector(LBGNetRequestDelegateFinish:withMessage:WithFunctionName:)]) {
                [self.delegate LBGNetRequestDelegateFinish:resultInt withMessage:message WithFunctionName:_functionName];
            }
            
            if (self.netRequestBlock) {
                self.netRequestBlock(dic,message);
            }
            
        }];
        
    }
    
}

- (void)netDataWithResult:(NSInteger)code withMessage:(NSString *)message withInfoDic:(NSDictionary *)infoDic withBlock:(void(^)())complete{
    complete();
}


@end
