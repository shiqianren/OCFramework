//
//  AppSetting.m
//  OCPRO
//
//  Created by shiqianren on 2017/5/3.
//  Copyright © 2017年 shiqianren. All rights reserved.
//

#import "AppSetting.h"
#import <UIKit/UIScreen.h>
#import <UIKit/UITraitCollection.h>
#import <UIKit/UIView.h>
#import <SSKeychain/SSKeychain.h>
@implementation AppSetting
void RUN_ON_MAIN_THREAD(dispatch_block_t block)
{
    if ([NSThread isMainThread])
        block();
    else
        dispatch_sync(dispatch_get_main_queue(), block);
}

+(NSString*)getHYCfuuid
{
    NSString *fbuuid = [SSKeychain passwordForService:@"HY_cfuuid" account:@"com.huayouwang"];
    
    if (fbuuid == nil) {
        NSString *uuid = [NSString stringWithFormat:@"%@%@", @"HYUUID-", [[[UIDevice currentDevice] identifierForVendor] UUIDString]];
        [SSKeychain setPassword:uuid forService:@"HY_cfuuid" account:@"com.huayouwang"];
    }
    return fbuuid;
}

+ (NSString *)appVersion
{
    NSDictionary *infoDict = [[NSBundle mainBundle] infoDictionary];
    NSString *version = [infoDict objectForKey:@"CFBundleShortVersionString"];
    //NSLog(@"current app version : %@", version);
    return version;
}

+ (NSString *)appBuildVersion
{
    NSDictionary *infoDict = [[NSBundle mainBundle] infoDictionary];
    NSString *buildVersion = [infoDict objectForKey:@"CFBundleVersion"];
    //NSLog(@"current app build : %@", buildVersion);
    return buildVersion;
}

+ (NSString *)filePathToDocumentWithFileName:(NSString *)fileName
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentPath = [paths objectAtIndex:0];
    NSString *filePath = [documentPath stringByAppendingPathComponent:fileName];
    
    return filePath;
}

+ (CGSize)mainScreenPixel
{
    UIScreen *mainScreen = [UIScreen mainScreen];
    CGFloat scale= [mainScreen scale];
    CGFloat width = mainScreen.bounds.size.width * scale;
    CGFloat height = mainScreen.bounds.size.height * scale;
    
    return CGSizeMake(width, height);
}


+(NSString *)getUniqueStrByUUID {
    CFUUIDRef uuidRef = CFUUIDCreate(NULL);
    CFStringRef uuidStrRef= CFUUIDCreateString(NULL, uuidRef);
    CFRelease(uuidRef);
    NSString *retStr = [NSString stringWithString:(__bridge NSString *)uuidStrRef];
    CFRelease(uuidStrRef);
    return retStr;
    
    
}

@end
