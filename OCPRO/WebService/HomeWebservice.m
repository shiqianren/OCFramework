//
//  HomeWebservice.m
//  OCPRO
//
//  Created by shiqianren on 2017/6/19.
//  Copyright © 2017年 shiqianren. All rights reserved.
//

#import "HomeWebservice.h"
#import "BaseResponse.h"
#import "NetAddress.h"
#import "NetWorkRequest.h"
#import "NSObject+ProgressHud.h"
@implementation HomeWebservice
+(instancetype) shareInstance{
	static HomeWebservice *webService;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		webService =  [[HomeWebservice alloc]init];
	});
	return webService;
}



-(void)getGradeList:(HomeResponseBlock)homeResponseBlock{
	
	DidFinishRequestBlock success = ^(id object, NSInteger code){
		[self Pro_showAlertWithTitle:@"加载数据成功"];
		homeResponseBlock(YES,object);
	};
	
	DidFailRequestBlock fail = ^ (BaseResponse *object) {
		if(object.msg.length){
			[self Pro_showAlertWithTitle:@"加载数据失败"];
		}
		homeResponseBlock(NO,object);
	};
	
	[NetWorkRequest sendRequestUseAFN:KURL_HOMEWORK_LIST params:nil reqType:REQ_GET eType:NO_ENCRYPT success:success fail:fail];


}


@end
