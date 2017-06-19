//
//  theUtility.h
//  tongguanedu
//
//  OCPRO
//
//  Created by shiqianren on 2017/5/3.
//  Copyright © 2017年 shiqianren. All rights reserved.
//
//

#import <Foundation/Foundation.h>
 #import "HexColor.h"
#include <sys/types.h>

#include <sys/sysctl.h>
//#import "TheCacheManager.h"
// Notification Constants

#define NEW_NOTIFICATION_KEY                         @"NEW_NOTIFICATION_KEY"
#define NOTIFICATION_READ_KEY                        @"NOTIFICATION_READ_KEY"
#define AllNotification                              @"AllNotification"
#define SERVICES_PLAY_SYSTEM_SOUND                       @"SERVICES_PLAY_SYSTEM_SOUND" // 版本 //@"AppFirstLaunch"

#define LINE_TAG 10010
@interface theUtility : NSObject

+ (UIColor *)colorWithRed:(CGFloat)r green:(CGFloat)g blue:(CGFloat)b alpha:(CGFloat)a;
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;
//图片切圆角
+ (UIImage *)makeRoundedImage:(UIImage *) image radius:(float)radius;
+ (UIImage*)getGrayImage:(UIImage*)sourceImage;
//平铺图片
+ (UIImage *)tileImage:(UIImage *) image withSize:(CGSize)size;
//根据图片的url获取图片的尺寸
+ (CGSize)getImageSizeWithUrlString:(NSString *)urlStirng;

+ (NSString *)urlEncode:(NSString *)urlString;

+(NSString *)urlDecode:(NSString *)urlString;
+ (BOOL) isEmpty:(id) str;
+(NSData*)returnDataWithDictionary:(NSDictionary*)dict;
#pragma mark---notification
/* -------------------------- notification -------------------------  */
///**
// *  是否有未读通知
// */
//+ (BOOL)hasUnreadNotifications;
///**
// *  设置是否有通知
// */
//+ (void)setHasNotifications;
///**
// * 清除通知
// */
//+ (void)clearNotifications;
//

//==================================turn time=======================
/**
 @abstract 计算作品发布时间和当前时间的差值
 @param createTime 作品发布时间
 @return NSString 封装好的相对时间（或者绝对时间）。例如，3 min ago，1 week ago，2014－04－05
 */
+ (NSString *)relativeTimeFrom:(NSString *)createTime;
//独立的一个方法，设置消息的时间格式
+ (NSString *)newsRelativeTimeFrom:(NSString *)creatTime;
//时间计算为今天、昨天、04－05的格式
+ (NSString *)sortRelativeTimeFrom:(NSString *)creatTime;

+ (NSString *)sortRelativeTime:(NSString *)creatTime;

//时间计算为昨天，前天，几月几日类型
+(NSString *)timeFromeDate:(NSTimeInterval *)toDate;

//将时间字符串转为几月几日类型
+ (NSString *)monthAndDayStringFrom:(NSString *)creatTime;

// 从unix时间戳转换成（几秒前这样的）字符串
+ (NSString *)relativeTimeFromUnixTimeStamp:(id)timeStamp;

//从unix时间戳换成08-26 14:12的字符串
+ (NSString *)relativeTimeStrFromDateString:(NSString *)dateString;

//从unix时间戳换成08/26 14:12的字符串
+ (NSString *)relativeTimeStr2FromDateString:(NSString *)dateString;

//从unix时间戳换成08-26 14:12的字符串
+ (NSString *)relativeTimeStr3FromDateString:(NSString *)dateString;

+ (NSString *)relativeTimeStrFromDateString:(NSString *)dateString withFormart:(NSString *)format;

//从unix时间戳换成14:12:22的字符串
+ (NSString *)relativeTimeNoDateStrFromDateString:(NSString *)dateString;
/**
 @abstract 格式化时间，不现实年份 入7月15日 14:32:30
 @param dateTimeString  要格式化的时间字符串
 @return NSString 格式化过的字符串
 */
+ (NSString *)dateTimeWith:(NSString *)dateTimeString;
//9月22日
+ (NSString *)monthANdDayTimeWith:(NSString *)dateTimeString;
+ (NSString *)getHoursAndMinutesStringWith:(NSString *)dateTimeString;

//9:30
+ (NSString *)hoursAndMinutesTimeWith:(NSString *)dateTimeString;

+ (NSString *)dateTimeWith2:(NSString *)dateTimeString;

//根据时间计算相差多少天
+ (NSString *)dateToDateOfDay:(NSString *)dateTimeString;

//获取昨天的时间 20151015
+ (NSString *)getYesterdayDate;

+ (NSString *)getCurrentTime;
//将时间转为秒
+ (NSInteger)turnTimeToSecond:(NSNumber *)time;

+ (long)getTimeSp;

+ (NSString *)timeSerFromSecond:(NSUInteger)second;
//时间转分钟
+ (NSString *)secondTurnToMinutes:(NSString *)time;

/* -------------------------- 时间转换 -------------------------  */

+(NSString*)dateFormat2String:(NSDate*)date strFormat:(NSString*)strFormat;

+(NSString*)dateFormat2String:(NSDate*)date;

+ (NSDate*)StringFormat2Date:(NSString*)date dateFormat:(NSString*)strFormat;

+ (NSDate*)StringFormat2Date:(NSString*)date;
//xianshi tabbar的条数badge
+ (void)ShowNewsMessageTabbarBadgeCount;

+ (void)addLineTo:(UIView*)view withColor:(UIColor*) color atYPosition:(CGFloat)yPosition;

+ (void)addLineTo:(UIView*)view withColor:(UIColor*) color atYPosition:(CGFloat)yPosition withPadding:(CGFloat)padding;

+ (UIImage *)compressImage:(UIImage *)image;

+ (BOOL)checkTel:(NSString *)phone;

/**
 
 获取手机版本
 */
+(NSString *) getPhonePlantForm;

/*
  获取设备唯一标示
 */

+(NSString *) getUniquePhoneTag;

///**
// *  获取UUID(现在用identifierForVendor代替)
// */
+(NSString *)getHYCfuuid;

+(void)postLogWithEvent:(NSString *)event;

+(void)postLogWithEvent:(NSString *)event params:(NSDictionary *)params;

+ (NSString*)dictionaryToJson:(NSDictionary *)dic;


//活动网络图片的尺寸大小
+ (CGSize)downloadImageSizeWithURL:(id)imageURL;
-(id)diskImageDataBySearchingAllPathsForKey:(id)key;

+ (CGSize)downloadPNGImageSizeWithRequest:(NSMutableURLRequest*)request;
+ (CGSize)downloadGIFImageSizeWithRequest:(NSMutableURLRequest*)request;
+ (CGSize)downloadJPGImageSizeWithRequest:(NSMutableURLRequest*)request;

//比较两个时间的大小

+ (int)compareDate:(NSString*)firstDate withDate:(NSString*)secondDate;

@end
