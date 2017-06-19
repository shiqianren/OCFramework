//
//  theUtility.m
//  OCPRO
//
//  Created by shiqianren on 2017/5/3.
//  Copyright © 2017年 shiqianren. All rights reserved.
//

#import "theUtility.h"
#import "AppSetting.h"
#import <CommonCrypto/CommonDigest.h>
#import <SSKeychain/SSKeychain.h>
#import "NetWorkRequest.h"
#import "Macro.h"
#import "NetAddress.h"

@implementation theUtility

#pragma mark - 图片和颜色处理
+ (UIColor *)colorWithRed:(CGFloat) r green:(CGFloat)g blue:(CGFloat)b alpha:(CGFloat)a
{
    return [UIColor colorWithRed:(r / 255.0f)
                           green:(g / 255.0f)
                            blue:(b / 255.0f)
                           alpha:a];
}

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size
{
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    return image;
}

+ (UIImage *)makeRoundedImage:(UIImage *) image radius: (float) radius
{
    CALayer *imageLayer = [CALayer layer];
    imageLayer.frame = CGRectMake(0, 0, image.size.width, image.size.height);
    imageLayer.contents = (id) image.CGImage;
    
    imageLayer.masksToBounds = YES;
    imageLayer.cornerRadius = radius;
    
    UIGraphicsBeginImageContext(image.size);
    [imageLayer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *roundedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return roundedImage;
}

+ (UIImage *)tileImage:(UIImage *) image withSize:(CGSize)size
{
    UIGraphicsBeginImageContext(size);
    
    [image drawAsPatternInRect:CGRectMake(0, 0, size.width, size.width)];
    
    UIImage* imgBg = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return imgBg;
}

//根据图片的url获取图片的尺寸
+ (CGSize)getImageSizeWithUrlString:(NSString *)urlStirng{
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:urlStirng]];
    UIImage *image = [UIImage imageWithData:data];
    return image.size;
}

+ (UIImage*)getGrayImage:(UIImage*)sourceImage
{
    int width = sourceImage.size.width;
    int height = sourceImage.size.height;
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceGray();
    CGContextRef context = CGBitmapContextCreate (nil,width,height,8,0,colorSpace,kCGImageAlphaNone);
    CGColorSpaceRelease(colorSpace);
    
    if (context == NULL) {
        return nil;
    }
    
    CGContextDrawImage(context,CGRectMake(0, 0, width, height), sourceImage.CGImage);
    CGImageRef grayImageRef = CGBitmapContextCreateImage(context);
    UIImage *grayImage = [UIImage imageWithCGImage:grayImageRef];
    CGContextRelease(context);
    CGImageRelease(grayImageRef);
    
    return grayImage;
}

#pragma mark - url encode or decode

+(NSString *)urlDecode:(NSString *)urlString
{
    
    
    NSString *decodedString  = (__bridge_transfer NSString *)CFURLCreateStringByReplacingPercentEscapesUsingEncoding(NULL,
                                                                                                                     (__bridge CFStringRef)urlString,
                                                                                                                     CFSTR(""),
                                                                                                                     CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding));
    return decodedString;
    
}

+ (NSString *)urlEncode:(NSString *)urlString
{
    return (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                                 (CFStringRef)urlString,
                                                                                 NULL,
                                                                                 CFSTR("!*'();:@&=+$,/?%#[]"),
                                                                                 kCFStringEncodingUTF8));
}
+ (BOOL)isEmpty:(id) str
{
    if (str == nil || [@"" isEqual:str] || [[NSNull null] isEqual:str] || [@"null" isEqualToString:str] || [@"(null)" isEqualToString:str]) {
        return YES;
    }
    return NO;
}
+(NSData*)returnDataWithDictionary:(NSDictionary*)dict
{
    NSMutableData* data = [[NSMutableData alloc]init];
    NSKeyedArchiver* archiver = [[NSKeyedArchiver alloc]initForWritingWithMutableData:data];
    [archiver encodeObject:dict forKey:@"talkData"];
    [archiver finishEncoding];
    return data;
}
#pragma mark----notification
//+ (void)setHasNotifications
//{
//    [TheCacheManager setDefaultsBool:YES forKey:AllNotification];
//}
//
//+ (BOOL)hasUnreadNotifications
//{
//    BOOL exist =[TheCacheManager defaultsBoolForKey:AllNotification];
//    return exist;
//}
//
//+ (void)clearNotifications
//{
//    [TheCacheManager setDefaultsBool:NO forKey:AllNotification];
//}
#pragma mark-------时间转换







//NSString 封装好的相对时间（或者绝对时间）。例如，3 min ago，1 week ago，2014－04－05
+ (NSString *)relativeTimeFrom:(NSString *)createTime
{
    if (!createTime) {
        return nil;
    }
    
    NSDate *createDate = [self defaultFormattedDateFromString:createTime];
    NSInteger timeInterval = (NSInteger)fabs([createDate timeIntervalSinceNow]);//NSLog(@"timeinterval: %i", timeInterval);
    CGFloat timeFloat = timeInterval;
    CGFloat day = timeFloat / 60 / 60 / 24;
    
    NSString *relativeTimeIntervalString = nil;
    if (timeInterval < 60) {
        relativeTimeIntervalString = [NSString stringWithFormat:@"%li%@", (long)timeInterval, @"秒前"];
    }else if ((timeInterval / 60 < 60)) {
        relativeTimeIntervalString = [NSString stringWithFormat:@"%li%@", (long)timeInterval / 60, @"分钟前"];
    }else if ((timeInterval / 60 / 60 < 24)) {
        relativeTimeIntervalString = [NSString stringWithFormat:@"%li%@", (long)timeInterval / 60 / 60, @"小时前"];
    }else if (1 < day && day < 2){
        relativeTimeIntervalString = @"1天前";
    }else if (2 <= day && day < 3){
        relativeTimeIntervalString = @"2天前";
    }else if (3 <= day && day < 4){
        relativeTimeIntervalString = @"3天前";
    }else {
        NSString *time = [createTime.description substringToIndex:10];
        relativeTimeIntervalString = [NSString stringWithFormat:@"%@", time];
    }
    
    return relativeTimeIntervalString;
}

+(NSString *)timeFromeDate:(NSTimeInterval *)toDate{
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:(long long)toDate];
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateString = [dateFormat stringFromDate:date];
    NSLog(@"%@",dateString);
    
    return dateString;
    
}





+ (NSString *)sortRelativeTime:(NSString *)creatTime{
    
    
    //    NSDate *date = [self defaultFormattedDateFromString:creatTime];
    NSDate *date = [self defaultFormattedDateFromString:creatTime];
    NSTimeInterval secondsPerDay = 24 * 60 * 60;
    NSDate *today = [NSDate date];
    NSDate *yesterday,*beforeYesterDay;
    
    NSTimeZone *fromzone = [NSTimeZone systemTimeZone];
    NSInteger frominterval = [fromzone secondsFromGMTForDate: today];
    NSDate *maxdate = [today  dateByAddingTimeInterval: frominterval];
    NSLog(@"-----------------%@",date);
    
    yesterday = [maxdate dateByAddingTimeInterval: -secondsPerDay];
    beforeYesterDay = [maxdate dateByAddingTimeInterval:-secondsPerDay-secondsPerDay];
    
    //    NSString * dateString = [[date description] substringToIndex:10];
    // 10 first characters of description is the calendar date:
    NSString * yesterdayString = [[yesterday description] substringToIndex:10];
    NSString * beforeYesterDayString = [[beforeYesterDay description] substringToIndex:10];
    
    
    if ([creatTime isEqualToString:yesterdayString])
    {
        
        return @"昨日学情";
    }else if ([creatTime isEqualToString:beforeYesterDayString]){
        
        return @"前日学情";
    }else{//转为几月几日
        return [self monthDayAndWeek:creatTime];
        
    }
}


+(NSString *)monthDayAndWeek:(NSString *)creatTime{
    
    if(creatTime.length==0){
        
        return @"";
    }
    //    NSAssert(creatTime != nil, @"参数不能为空[HYUtility dateTimeWith:]");
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    
    NSDate *formatedDate = [formatter dateFromString:creatTime];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = nil;
    NSInteger unitFlags = NSCalendarUnitYear |
    NSCalendarUnitMonth |
    NSCalendarUnitDay |
    NSCalendarUnitWeekday |
    NSCalendarUnitHour |
    NSCalendarUnitMinute |
    NSCalendarUnitSecond;
    comps = [calendar components:unitFlags fromDate:formatedDate];
    
    NSInteger weekday = [comps weekday];
    NSInteger year = [comps year];
    NSInteger month = [comps month];
    NSInteger day = [comps day];
    NSString *str;
    switch ((long)weekday-1) {
        case 1:
            str = @"一";
            break;
        case 2:
            str = @"二";
            break;
        case 3:
            str = @"三";
            break;
        case 4:
            str = @"四";
            break;
        case 5:
            str = @"五";
            break;
        case 6:
            str = @"六";
            break;
        case 0:
            str = @"日";
            break;
            
        default:
            break;
    }
    NSLog(@"week-------------------------%@",str);
    
    NSString *formatedString = [NSString stringWithFormat:@"%02ld年%02ld月%02ld日周%@",(long)year,(long)month, (long)day,str];
    return formatedString;
}

//+(NSString *)weekString:(NSNumber *)week{
//
//
//
//
//}


+ (NSString *)newsRelativeTimeFrom:(NSString *)creatTime{
    
    NSDate *date = [self defaultFormattedDateFromString:creatTime];
    
    NSTimeInterval secondsPerDay = 24 * 60 * 60;
    NSDate *today = [[NSDate alloc] init];
    NSDate *tomorrow, *yesterday,*beforeYesterDay;
    
    tomorrow = [today dateByAddingTimeInterval: secondsPerDay];
    yesterday = [today dateByAddingTimeInterval: -secondsPerDay];
    beforeYesterDay = [today dateByAddingTimeInterval:-secondsPerDay-secondsPerDay];
    
    
    // 10 first characters of description is the calendar date:
    NSString * todayString = [[today description] substringToIndex:10];
    NSString * yesterdayString = [[yesterday description] substringToIndex:10];
    NSString * tomorrowString = [[tomorrow description] substringToIndex:10];
    
    NSString * dateString = [[date description] substringToIndex:10];
    
    if ([dateString isEqualToString:todayString])
    {
        NSArray *array1 = [creatTime componentsSeparatedByString:@" "];
        NSArray *array2 = [[array1 objectAtIndex:1] componentsSeparatedByString:@":"];
        NSString *time = [NSString stringWithFormat:@"%@:%@",[array2 objectAtIndex:0],[array2 objectAtIndex:1]];
        return time;
    } else if ([dateString isEqualToString:yesterdayString])
    {
        
        return @"昨天";
    }else if ([dateString isEqualToString:yesterdayString]){
        
        return @"前日学情";
    }else if ([dateString isEqualToString:tomorrowString])
    {
        return @"明天";
    }
    else
    {//转为几月几日
        if(creatTime.length==0){
            
            return @"";
        }
        
        NSAssert(creatTime != nil, @"参数不能为空[HYUtility dateTimeWith:]");
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        
        NSDate *formatedDate = [formatter dateFromString:creatTime];
        NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        NSDateComponents *comps = nil;
        NSInteger unitFlags = NSCalendarUnitYear |
        NSCalendarUnitMonth |
        NSCalendarUnitDay |
        NSCalendarUnitWeekday |
        NSCalendarUnitHour |
        NSCalendarUnitMinute |
        NSCalendarUnitSecond;
        comps = [calendar components:unitFlags fromDate:formatedDate];
        
        
        
        
        NSInteger year = [comps year];
        NSInteger month = [comps month];
        NSInteger day = [comps day];
        NSString *formatedString = [NSString stringWithFormat:@"%02ld/%02ld/%02ld",(long)year,(long)month, (long)day];
        return formatedString;
        
    }
    
}


+ (NSString *)sortRelativeTimeFrom:(NSString *)creatTime{
    
    NSDate *date = [self defaultFormattedDateFromString:creatTime];
    
    NSTimeInterval secondsPerDay = 24 * 60 * 60;
    NSDate *today = [[NSDate alloc] init];
    NSDate *tomorrow, *yesterday,*beforeYesterDay;
    
    tomorrow = [today dateByAddingTimeInterval: secondsPerDay];
    yesterday = [today dateByAddingTimeInterval: -secondsPerDay];
    beforeYesterDay = [today dateByAddingTimeInterval:-secondsPerDay-secondsPerDay];
    
    
    // 10 first characters of description is the calendar date:
    NSString * todayString = [[today description] substringToIndex:10];
    NSString * yesterdayString = [[yesterday description] substringToIndex:10];
    NSString * tomorrowString = [[tomorrow description] substringToIndex:10];
    
    NSString * dateString = [[date description] substringToIndex:10];
    
    if ([dateString isEqualToString:todayString])
    {
        return @"今天";
    } else if ([dateString isEqualToString:yesterdayString])
    {
        
        return @"昨天";
    }else if ([dateString isEqualToString:yesterdayString]){
        
        return @"前日学情";
    }else if ([dateString isEqualToString:tomorrowString])
    {
        return @"明天";
    }
    else
    {//转为几月几日
        return [self monthAndDayStringFrom:creatTime];
        
    }
}







+ (NSString *)monthAndDayStringFrom:(NSString *)creatTime{
    if(creatTime.length==0){
        
        return @"";
    }
    NSAssert(creatTime != nil, @"参数不能为空[HYUtility dateTimeWith:]");
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSDate *formatedDate = [formatter dateFromString:creatTime];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = nil;
    NSInteger unitFlags = NSCalendarUnitYear |
    NSCalendarUnitMonth |
    NSCalendarUnitDay |
    NSCalendarUnitWeekday |
    NSCalendarUnitHour |
    NSCalendarUnitMinute |
    NSCalendarUnitSecond;
    comps = [calendar components:unitFlags fromDate:formatedDate];
    NSInteger month = [comps month];
    NSInteger day = [comps day];
    [comps hour];
    [comps minute];
    [comps second];
    NSString *formatedString = [NSString stringWithFormat:@"%02ld月%02ld日", (long)month, (long)day];
    return formatedString;
}




+ (NSDate *)defaultFormattedDateFromString:(NSString *)dateString
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *formattedDate = [formatter dateFromString:dateString];
    
    
    
    //NSLog(@"print----------%@",formattedDate);
    
    
    return formattedDate;
}
+ (NSString *)relativeTimeFromUnixTimeStamp:(id)timeStamp
{
    NSTimeInterval unixDateTime = 0;
    if ([timeStamp isKindOfClass:[NSNumber class]]) {
        unixDateTime = [(NSNumber *)timeStamp doubleValue] /1000;
    }else if ([timeStamp isKindOfClass:[NSString class]]){
        unixDateTime = [timeStamp doubleValue] / 1000;
    }
    
    NSDate *rawDate = [NSDate dateWithTimeIntervalSince1970:unixDateTime];
    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    [formatter setLocale:[NSLocale currentLocale]];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateString = [formatter stringFromDate:rawDate];
    // NSLog(@"dateString---------------%@",dateString);
    
    return [self relativeTimeFrom:dateString];
}
+ (NSString *)relativeTimeStrFromDateString:(NSString *)dateString{
    NSTimeInterval unixDateTime = [dateString doubleValue] / 1000;
    
    NSDate *rawDate = [NSDate dateWithTimeIntervalSince1970:unixDateTime];
    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    [formatter setLocale:[NSLocale currentLocale]];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateStr = [formatter stringFromDate:rawDate];
    
    return dateStr;
    
}
//

+ (NSString *)relativeTimeStr2FromDateString:(NSString *)dateString{
    NSTimeInterval unixDateTime = [dateString doubleValue] / 1000;
    
    NSDate *rawDate = [NSDate dateWithTimeIntervalSince1970:unixDateTime];
    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    [formatter setLocale:[NSLocale currentLocale]];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateStr = [formatter stringFromDate:rawDate];
    
    return dateStr;
    
}

+ (NSString *)relativeTimeStr3FromDateString:(NSString *)dateString{
    NSTimeInterval unixDateTime = [dateString doubleValue] / 1000;
    
    NSDate *rawDate = [NSDate dateWithTimeIntervalSince1970:unixDateTime];
    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    [formatter setLocale:[NSLocale currentLocale]];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString *dateStr = [formatter stringFromDate:rawDate];
    
    return dateStr;
    
}

+ (NSString *)relativeTimeStrFromDateString:(NSString *)dateString withFormart:(NSString *)format{
    NSTimeInterval unixDateTime = [dateString doubleValue] / 1000;
    
    NSDate *rawDate = [NSDate dateWithTimeIntervalSince1970:unixDateTime];
    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    [formatter setLocale:[NSLocale currentLocale]];
    [formatter setDateFormat:format];
    NSString *dateStr = [formatter stringFromDate:rawDate];
    
    return dateStr;
    
}

+ (NSString *)relativeTimeNoDateStrFromDateString:(NSString *)dateString{
    NSTimeInterval unixDateTime = [dateString doubleValue] / 1000;
    
    NSDate *rawDate = [NSDate dateWithTimeIntervalSince1970:unixDateTime];
    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    [formatter setLocale:[NSLocale currentLocale]];
    [formatter setDateFormat:@"HH:mm:ss"];
    NSString *dateStr = [formatter stringFromDate:rawDate];
    
    return dateStr;
    
}

+ (NSString *)dateTimeWith2:(NSString *)dateTimeString
{
    if(dateTimeString.length==0){
        
        return @"";
    }
    NSAssert(dateTimeString != nil, @"参数不能为空[HYUtility dateTimeWith:]");
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSDate *formatedDate = [formatter dateFromString:dateTimeString];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = nil;
    NSInteger unitFlags = NSCalendarUnitYear |
    NSCalendarUnitMonth |
    NSCalendarUnitDay |
    NSCalendarUnitWeekday |
    NSCalendarUnitHour |
    NSCalendarUnitMinute |
    NSCalendarUnitSecond;
    comps = [calendar components:unitFlags fromDate:formatedDate];
    NSInteger year = [comps year];
    NSInteger month = [comps month];
    NSInteger day = [comps day];
    NSInteger hour = [comps hour];
    NSInteger min = [comps minute];
    NSString *minString = min < 10 ? [NSString stringWithFormat:@"0%ld", (long)min] : [NSString stringWithFormat:@"%ld", (long)min];
    
    NSString *formatedString = [NSString stringWithFormat:@"%ld-%02ld-%02ld %02ld:%@", (long)year,(long)month, (long)day, (long)hour, minString];
    return formatedString;
}


+ (NSString *)dateTimeWith:(NSString *)dateTimeString
{
    if(dateTimeString.length==0){
        
        return @"";
    }
    NSAssert(dateTimeString != nil, @"参数不能为空[HYUtility dateTimeWith:]");
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSDate *formatedDate = [formatter dateFromString:dateTimeString];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = nil;
    NSInteger unitFlags = NSCalendarUnitYear |
    NSCalendarUnitMonth |
    NSCalendarUnitDay |
    NSCalendarUnitWeekday |
    NSCalendarUnitHour |
    NSCalendarUnitMinute |
    kCFCalendarUnitSecond;
    comps = [calendar components:unitFlags fromDate:formatedDate];
    
    NSInteger month = [comps month];
    NSInteger day = [comps day];
    NSInteger hour = [comps hour];
    NSInteger min = [comps minute];
    NSString *minString = min < 10 ? [NSString stringWithFormat:@"0%ld", (long)min] : [NSString stringWithFormat:@"%ld", (long)min];
    
    NSString *formatedString = [NSString stringWithFormat:@"%ld月%ld日 %ld:%@", (long)month, (long)day, (long)hour, minString];
    return formatedString;
}
+ (NSString *)hoursAndMinutesTimeWith:(NSString *)dateTimeString{
    if(dateTimeString.length==0){
        
        return @"";
    }
    NSAssert(dateTimeString != nil, @"参数不能为空[HYUtility dateTimeWith:]");
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSDate *formatedDate = [formatter dateFromString:dateTimeString];
    NSTimeInterval secondsPerDay = 24 * 60 * 60;
    NSDate *today = [[NSDate alloc] init];
    NSDate *tomorrow, *yesterday,*beforeYesterDay;
    
    tomorrow = [today dateByAddingTimeInterval: secondsPerDay];
    yesterday = [today dateByAddingTimeInterval: -secondsPerDay];
    beforeYesterDay = [today dateByAddingTimeInterval:-secondsPerDay-secondsPerDay];
    
    // 10 first characters of description is the calendar date:
    NSString * todayString = [[today description] substringToIndex:10];
    NSString * yesterdayString = [[yesterday description] substringToIndex:10];
    //    NSString * tomorrowString = [[tomorrow description] substringToIndex:10];
    
    NSString * dateString = [[formatedDate description] substringToIndex:10];
    NSString *formatedString;
    
    if ([dateString isEqualToString:todayString])
    {
        
        NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        NSDateComponents *comps = nil;
        NSInteger unitFlags = NSCalendarUnitYear |
        NSCalendarUnitMonth |
        NSCalendarUnitDay |
        NSCalendarUnitWeekday |
        NSCalendarUnitHour |
        NSCalendarUnitMinute |
        kCFCalendarUnitSecond;
        comps = [calendar components:unitFlags fromDate:formatedDate];
        NSInteger hour = [comps hour];
        NSInteger min = [comps minute];
        NSString *minString = min < 10 ? [NSString stringWithFormat:@"0%ld", (long)min] : [NSString stringWithFormat:@"%ld", (long)min];
        if(hour >=0 && hour < 6){
            formatedString  = [NSString stringWithFormat:@"凌晨%ld:%@",  (long)hour, minString];
        }else if (hour >=6 && hour <12){
            formatedString  = [NSString stringWithFormat:@"上午%ld:%@",  (long)hour, minString];
        }else if (hour >= 12 && hour < 18){
            formatedString  = [NSString stringWithFormat:@"下午%ld:%@",  (long)(hour == 12?hour:hour-12), minString];
        }else if (hour >= 18 && hour < 24){
            formatedString  = [NSString stringWithFormat:@"晚上%ld:%@",  (long)hour -12, minString];
        }
        return formatedString;
    } else if ([dateString isEqualToString:yesterdayString])
    {
        NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        NSDateComponents *comps = nil;
        NSInteger unitFlags = NSCalendarUnitYear |
        NSCalendarUnitMonth |
        NSCalendarUnitDay |
        NSCalendarUnitWeekday |
        NSCalendarUnitHour |
        NSCalendarUnitMinute |
        kCFCalendarUnitSecond;
        comps = [calendar components:unitFlags fromDate:formatedDate];
        NSInteger hour = [comps hour];
        NSInteger min = [comps minute];
        NSString *minString = min < 10 ? [NSString stringWithFormat:@"0%ld", (long)min] : [NSString stringWithFormat:@"%ld", (long)min];
        if(hour >=0 && hour < 6){
            formatedString  = [NSString stringWithFormat:@"昨天 凌晨%ld:%@",  (long)hour, minString];
        }else if (hour >=6 && hour <12){
            formatedString  = [NSString stringWithFormat:@"昨天 上午%ld:%@",  (long)hour, minString];
        }else if (hour >= 12 && hour < 18){
            formatedString  = [NSString stringWithFormat:@"昨天 下午%ld:%@",  (long)(hour == 12?hour:hour-12), minString];
        }else if (hour >= 18 && hour < 24){
            formatedString  = [NSString stringWithFormat:@"昨天 晚上%ld:%@",  (long)hour-12, minString];
        }
        return formatedString;
    }else
    {//转为几月几日
        NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        NSDateComponents *comps = nil;
        NSInteger unitFlags = NSCalendarUnitYear |
        NSCalendarUnitMonth |
        NSCalendarUnitDay |
        NSCalendarUnitWeekday |
        NSCalendarUnitHour |
        NSCalendarUnitMinute |
        kCFCalendarUnitSecond;
        comps = [calendar components:unitFlags fromDate:formatedDate];
        NSInteger year = [comps year];
        NSInteger month = [comps month];
        NSInteger day = [comps day];
        NSInteger hour = [comps hour];
        NSInteger min = [comps minute];
        NSString *minString = min < 10 ? [NSString stringWithFormat:@"0%ld", (long)min] : [NSString stringWithFormat:@"%ld", (long)min];
        if(hour >=0 && hour < 6){
            formatedString = [NSString stringWithFormat:@"%ld年%ld月%ld日 凌晨%ld:%@",(long)year ,(long)month, (long)day, (long)hour, minString];
        }else if (hour >=6 && hour <12){
            formatedString = [NSString stringWithFormat:@"%ld年%ld月%ld日 上午%ld:%@",(long)year ,(long)month, (long)day, (long)hour, minString];
        }else if (hour >= 12 && hour < 18){
            formatedString = [NSString stringWithFormat:@"%ld年%ld月%ld日 下午%ld:%@",(long)year ,(long)month, (long)day, hour==12? (long)hour:hour-12, minString];
        }else if (hour >= 18 && hour < 24){
            formatedString = [NSString stringWithFormat:@"%ld年%ld月%ld日 晚上%ld:%@",(long)year ,(long)month, (long)day, (long)hour-12, minString];
        }
        return formatedString;
        //        return [self monthAndDayStringFrom:creatTime];
    }
}
+ (NSString *)monthANdDayTimeWith:(NSString *)dateTimeString{
    if(dateTimeString.length==0){
        
        return @"";
    }
    NSAssert(dateTimeString != nil, @"参数不能为空[HYUtility dateTimeWith:]");
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSDate *formatedDate = [formatter dateFromString:dateTimeString];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = nil;
    NSInteger unitFlags = NSCalendarUnitYear |
    NSCalendarUnitMonth |
    NSCalendarUnitDay |
    NSCalendarUnitWeekday |
    NSCalendarUnitHour |
    NSCalendarUnitMinute |
    kCFCalendarUnitSecond;
    comps = [calendar components:unitFlags fromDate:formatedDate];
    
    NSInteger month = [comps month];
    NSInteger day = [comps day];
    
    NSString *formatedString = [NSString stringWithFormat:@"%ld月%ld日", (long)month, (long)day];
    return formatedString;
}

+ (NSString *)getHoursAndMinutesStringWith:(NSString *)dateTimeString
{
    if(dateTimeString.length==0){
        
        return @"";
    }
    NSAssert(dateTimeString != nil, @"参数不能为空[HYUtility dateTimeWith:]");
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSDate *formatedDate = [formatter dateFromString:dateTimeString];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = nil;
    NSInteger unitFlags = NSCalendarUnitYear |
    NSCalendarUnitMonth |
    NSCalendarUnitDay |
    NSCalendarUnitWeekday |
    NSCalendarUnitHour |
    NSCalendarUnitMinute |
    kCFCalendarUnitSecond;
    comps = [calendar components:unitFlags fromDate:formatedDate];
    
    NSInteger hour = [comps hour];
    NSInteger min = [comps minute];
    NSString *minString = min < 10 ? [NSString stringWithFormat:@"0%ld", (long)min] : [NSString stringWithFormat:@"%ld", (long)min];
    
    NSString *formatedString = [NSString stringWithFormat:@"%ld:%@", (long)hour, minString];
    return formatedString;
}
#pragma mark - dateFormat

+(NSString*)dateFormat2String:(NSDate*)date strFormat:(NSString*)strFormat
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:strFormat];
    //用[NSDate date]可以获取系统当前时间
    NSString *currentDateStr = [dateFormatter stringFromDate:date];
    
    return currentDateStr;
}

+(NSString*)dateFormat2String:(NSDate*)date
{
    return [self dateFormat2String:date strFormat:@"yyyy-MM-dd"];;
}

+ (NSDate*)StringFormat2Date:(NSString*)date dateFormat:(NSString*)strFormat

{
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
    [inputFormatter setDateFormat:strFormat];
    NSDate* inputDate = [inputFormatter dateFromString:date];
    return inputDate;
}

+ (NSDate*)StringFormat2Date:(NSString*)date
{
    return [self StringFormat2Date:date dateFormat:@"yyyy-MM-dd"];
}

+(NSString *)dateToDateOfDay:(NSString *)dateTimeString{
    
    
    NSString *dateStr=dateTimeString;//传入时间
    //将传入时间转化成需要的格式
    NSDateFormatter *format=[[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *fromdate=[format dateFromString:dateStr];
    //获取当前时间
    NSDate *date = [NSDate date];
    
    
    NSString *dateString = [[fromdate description]substringToIndex:10];
    NSLog(@"%@",dateString);
    NSString *todayString = [[date description]substringToIndex:10];
    NSLog(@"%@",todayString);
    
    if ([dateString isEqualToString:todayString]) {
        return 0;
    }
    
    
    NSTimeZone *fromzone = [NSTimeZone systemTimeZone];
    NSInteger frominterval = [fromzone secondsFromGMTForDate: fromdate];
    NSDate *fromDate = [fromdate  dateByAddingTimeInterval: frominterval];
    NSLog(@"fromdate=%@",fromDate);
    
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate: date];
    NSDate *localeDate = [date  dateByAddingTimeInterval: interval];
    NSLog(@"enddate=%@",localeDate);
    //    double intervalTime = [fromDate timeIntervalSince1970] - [localeDate timeIntervalSince1970];
    
    double intervalTime = [localeDate timeIntervalSince1970 ] - [fromDate timeIntervalSince1970];
    
    long lTime = (long)intervalTime;
    NSLog(@"相差多少毫秒－－－－%ld",lTime);
    
    NSInteger iDays = lTime/(24*60*60);
    
    NSString * iDaysString = [NSString stringWithFormat:@"%ld",(long)iDays];
    
    NSLog(@"相差多少天－－－－%@",iDaysString);
    
    return iDaysString;
}

//获取昨天的日期 20151015
+ (NSString *)getYesterdayDate
{
    NSDate *yesterday = [NSDate dateWithTimeIntervalSinceNow: - (60 * 60 * 24)];
    NSDateFormatter *dateformatter = [[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"YYYYMMdd"];
    NSString *locationString=[dateformatter stringFromDate:yesterday];
    NSLog(@"locationString:%@",locationString);
    
    return locationString;
}

+ (NSString *)getCurrentTime{
    //    NSDate *fromdate = [NSDate date];//获取当前时间，日期
    //    NSTimeZone *fromzone = [NSTimeZone systemTimeZone];
    //    NSInteger frominterval = [fromzone secondsFromGMTForDate: fromdate];
    //    NSDate *fromDate = [fromdate  dateByAddingTimeInterval: frominterval];
    //    NSData *currentDate = [NSDate dateWithTimeIntervalSinceNow:fromDate];
    NSDate *currentDate = [NSDate date];//获取当前时间，日期
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //    [dateFormatter setDateFormat:@"YYYY/MM/dd HH:mm:ss"];
    [dateFormatter setDateFormat:@"YYYY/MM/dd"];
    NSString *dateString = [dateFormatter stringFromDate:currentDate];
    NSLog(@"dateString:%@",dateString);
    return dateString;
    
}

//将时间转为秒
+ (NSInteger)turnTimeToSecond:(NSNumber *)time{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *formattedDate = [formatter dateFromString:[NSString stringWithFormat:@"%@",time]];
    
    NSInteger timeInterval = (NSInteger)fabs([formattedDate timeIntervalSinceNow]);//NSLog(@"timeinterval: %i", timeInterval);
    return timeInterval;
}

+ (long)getTimeSp {
    long time;
    NSDate *fromdate=[NSDate date];
    time=(long)[fromdate timeIntervalSince1970];
    return time;
}

+ (NSString *)timeSerFromSecond:(NSUInteger)second {
    NSInteger days = second / (3600*24);
    NSInteger remainingTime = second % (3600 * 24);
    NSInteger hours = remainingTime / 3600;
    remainingTime = remainingTime % 3600;
    NSInteger minutes = remainingTime / 60;
    NSInteger seconds = remainingTime % 60;
    
    return [NSString stringWithFormat:@"%ld天%ld时%ld分%ld秒", days, hours, minutes, seconds];
}

//秒转分钟，不够一分钟按分钟
+ (NSString *)secondTurnToMinutes:(NSString *)time{
    float minutes = time.floatValue/60;
    NSLog(@"minutes-------------%f",minutes);
    NSString *timeString;
    if(minutes == 0.0){
        timeString = @"0";
    }else if (minutes > 0.1){
        timeString = [NSString stringWithFormat:@"%.1f",minutes];
    }else{
        timeString = @"0.1";
    }
    return timeString;
}

//显示未读消息条数

+ (void)ShowNewsMessageTabbarBadgeCount{
    //    BOOL first = [[NSUserDefaults standardUserDefaults]boolForKey:NEWS_RED_CATETYPE_EIGHT_BOOL];
    //    BOOL second = [[NSUserDefaults standardUserDefaults]boolForKey:NEWS_RED_CATETYPE_ZERO_BOOL];
    //    BOOL three = [[NSUserDefaults standardUserDefaults]boolForKey:NEWS_RED_CATETYPE_SIX_BOOL];
    //    BOOL four = [[NSUserDefaults standardUserDefaults]boolForKey:NEWS_RED_CATETYPE_ONE_BOOL];
    //    BOOL five = [[NSUserDefaults standardUserDefaults]boolForKey:NEWS_RED_CATETYPE_TWO_BOOL];
    //    BOOL six = [[NSUserDefaults standardUserDefaults]boolForKey:NEWS_RED_CATETYPE_THREE_BOOL];
    //    BOOL seven = [[NSUserDefaults standardUserDefaults]boolForKey:NEWS_RED_CATETYPE_FIVE_BOOL];
    //    BOOL eight = [[NSUserDefaults standardUserDefaults]boolForKey:NEWS_RED_CATETYPE_SEVEN_BOOL];
    //    NSInteger badge = first + second + three + four + five + six + seven + eight;
    //     [TheAppDelegate showBadgeForIndex:1 andMessageNum: badge];
    
}

//画分割线
+ (void)addLineTo:(UIView*)view withColor:(UIColor*) color atYPosition:(CGFloat)yPosition
{
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(PADDING_LEFT, yPosition, SCREEN_WIDTH - PADDING_LEFT - PADDING_RIGHT, 1)];
    line.backgroundColor = color;
    
    line.tag = LINE_TAG;
    
    [view addSubview:line];
}

//画分割线
+ (void)addLineTo:(UIView*)view withColor:(UIColor*) color atYPosition:(CGFloat)yPosition withPadding:(CGFloat)padding
{
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(padding, yPosition, SCREEN_WIDTH - padding*2, 1)];
    line.backgroundColor = color;
    
    line.tag = LINE_TAG;
    
    [view addSubview:line];
}


+ (UIImage *)compressImage:(UIImage *)image
{
    UIImage *compressedImage = image;
    if (compressedImage.size.width > 1000) {
        CGFloat imageWidht = 1000;
        CGFloat imageHeight = image.size.height/image.size.width*1000;
        compressedImage = [self imageWithImage:compressedImage scaledToSize:CGSizeMake(imageWidht, imageHeight)];
    }
    if (compressedImage.size.height > 1000) {
        CGFloat imageWidht = image.size.width/image.size.height*1000;
        CGFloat imageHeight = 1000;
        compressedImage = [self imageWithImage:compressedImage scaledToSize:CGSizeMake(imageWidht, imageHeight)];
    }
    
    if (UIImageJPEGRepresentation(image, 1.0).length / 1024 > 100) {
        compressedImage = [UIImage imageWithData:UIImageJPEGRepresentation(compressedImage, 0.3)];
    }
    
    return compressedImage;
}







//对图片尺寸进行压缩--

+ (UIImage *)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize
{
    // Create a graphics image context
    UIGraphicsBeginImageContext(newSize);
    
    // Tell the old image to draw in this new context, with the desired
    // new size
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    
    // Get the new image from the context
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // End the context
    UIGraphicsEndImageContext();
    
    // Return the new image.
    return newImage;
}


+ (BOOL)checkTel:(NSString *)phone{
    
    if ([phone length] == 0) {
        return NO;
    }
    
    NSString *regex = @"^(1)\\d{10}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:phone];
    
    if (!isMatch) {
        return NO;
    }
    
    return YES;
    
}

+ (NSString *)getPhonePlantForm{
    //手机型号。
    
    size_t size;
    
    sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    
    char *machine = (char*)malloc(size);
    
    sysctlbyname("hw.machine", machine, &size, NULL, 0);
    
    NSString *platform = [NSString stringWithCString:machine encoding:NSUTF8StringEncoding];
    return platform;
    
}

+(NSString *)getUniquePhoneTag{
    
    NSString *identifierForVendor = [[UIDevice currentDevice].identifierForVendor UUIDString];
    return identifierForVendor;
}

+(NSString*)getHYCfuuid
{
    NSString *fbuuid = [SSKeychain passwordForService:@"HY_cfuuid" account:@"com.checkanswer"];
    
    if (fbuuid == nil) {
        NSString *uuid = [NSString stringWithFormat:@"%@%@", @"HYUUID-", [[[UIDevice currentDevice] identifierForVendor] UUIDString]];
        [SSKeychain setPassword:uuid forService:@"HY_cfuuid" account:@"com.checkanswer"];
    }
    return fbuuid = [SSKeychain passwordForService:@"HY_cfuuid" account:@"com.checkanswer"] ;
}

+(void)postLogWithEvent:(NSString *)event
{
    NSString *mobileCode = [theUtility getHYCfuuid];
    NSString* phoneModel = [[UIDevice currentDevice] model];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:mobileCode forKey:@"mobileCode"];
    [params setValue:event forKey:@"key"];
    [params setValue:[AppSetting appVersion] forKey:@"version"];
    [params setValue:phoneModel forKey:@"equipment"];
    [params setValue:@"" forKey:@"object"];

    //[NetWorkRequest sendRequest:KURL_LOG params:params];
	
}

+(void)postLogWithEvent:(NSString *)event params:(NSDictionary *)param
{
    NSString *mobileCode = [theUtility getHYCfuuid];
    NSString* phoneModel = [[UIDevice currentDevice] model];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:mobileCode forKey:@"mobileCode"];
    [params setValue:event forKey:@"key"];
    [params setValue:[AppSetting appVersion] forKey:@"version"];
    [params setValue:phoneModel forKey:@"equipment"];
    [params setValue:[theUtility dictionaryToJson:param] forKey:@"object"];
    
    //[NetWorkRequest sendRequest:KURL_LOG params:params];
}

+ (NSString*)dictionaryToJson:(NSDictionary *)dic
{
    NSError *parseError = nil;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

//活动网络图片的尺寸大小
+ (CGSize)downloadImageSizeWithURL:(id)imageURL
{
    NSURL* URL = nil;
    if([imageURL isKindOfClass:[NSURL class]]){
        URL = imageURL;
    }
    if([imageURL isKindOfClass:[NSString class]]){
        URL = [NSURL URLWithString:imageURL];
    }
    if(URL == nil)
        return CGSizeZero;
    
    NSString* absoluteString = URL.absoluteString;
    
#ifdef dispatch_main_sync_safe
    if([[SDImageCache sharedImageCache] diskImageExistsWithKey:absoluteString])
    {
        UIImage* image = [[SDImageCache sharedImageCache] imageFromMemoryCacheForKey:absoluteString];
        if(!image)
        {
            NSData* data = [[SDImageCache sharedImageCache] performSelector:@selector(diskImageDataBySearchingAllPathsForKey:) withObject:URL.absoluteString];
            image = [UIImage imageWithData:data];
        }
        if(image)
        {
            return image.size;
        }
    }
#endif
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:URL];
    NSString* pathExtendsion = [URL.pathExtension lowercaseString];
    
    CGSize size = CGSizeZero;
    if([pathExtendsion isEqualToString:@"png"]){
        size =  [self downloadPNGImageSizeWithRequest:request];
    }
    else if([pathExtendsion isEqual:@"gif"])
    {
        size =  [self downloadGIFImageSizeWithRequest:request];
    }
    else{
        size = [self downloadJPGImageSizeWithRequest:request];
    }
    if(CGSizeEqualToSize(CGSizeZero, size))
    {
        NSData* data = [NSURLConnection sendSynchronousRequest:[NSURLRequest requestWithURL:URL] returningResponse:nil error:nil];
        UIImage* image = [UIImage imageWithData:data];
        if(image)
        {
#ifdef dispatch_main_sync_safe
            [[SDImageCache sharedImageCache] storeImage:image recalculateFromImage:YES imageData:data forKey:URL.absoluteString toDisk:YES];
#endif
            size = image.size;
        }
    }
    return size;
}
-(id)diskImageDataBySearchingAllPathsForKey:(id)key{return nil;}

+ (CGSize)downloadPNGImageSizeWithRequest:(NSMutableURLRequest*)request
{
    [request setValue:@"bytes=16-23" forHTTPHeaderField:@"Range"];
    NSData* data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    if(data.length == 8)
    {
        int w1 = 0, w2 = 0, w3 = 0, w4 = 0;
        [data getBytes:&w1 range:NSMakeRange(0, 1)];
        [data getBytes:&w2 range:NSMakeRange(1, 1)];
        [data getBytes:&w3 range:NSMakeRange(2, 1)];
        [data getBytes:&w4 range:NSMakeRange(3, 1)];
        int w = (w1 << 24) + (w2 << 16) + (w3 << 8) + w4;
        int h1 = 0, h2 = 0, h3 = 0, h4 = 0;
        [data getBytes:&h1 range:NSMakeRange(4, 1)];
        [data getBytes:&h2 range:NSMakeRange(5, 1)];
        [data getBytes:&h3 range:NSMakeRange(6, 1)];
        [data getBytes:&h4 range:NSMakeRange(7, 1)];
        int h = (h1 << 24) + (h2 << 16) + (h3 << 8) + h4;
        return CGSizeMake(w, h);
    }
    return CGSizeZero;
}
+ (CGSize)downloadGIFImageSizeWithRequest:(NSMutableURLRequest*)request
{
    [request setValue:@"bytes=6-9" forHTTPHeaderField:@"Range"];
    NSData* data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    if(data.length == 4)
    {
        short w1 = 0, w2 = 0;
        [data getBytes:&w1 range:NSMakeRange(0, 1)];
        [data getBytes:&w2 range:NSMakeRange(1, 1)];
        short w = w1 + (w2 << 8);
        short h1 = 0, h2 = 0;
        [data getBytes:&h1 range:NSMakeRange(2, 1)];
        [data getBytes:&h2 range:NSMakeRange(3, 1)];
        short h = h1 + (h2 << 8);
        return CGSizeMake(w, h);
    }
    return CGSizeZero;
}
+ (CGSize)downloadJPGImageSizeWithRequest:(NSMutableURLRequest*)request
{
    [request setValue:@"bytes=0-209" forHTTPHeaderField:@"Range"];
    NSData* data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    if ([data length] <= 0x58) {
        return CGSizeZero;
    }
    
    if ([data length] < 210) {// 肯定只有一个DQT字段
        short w1 = 0, w2 = 0;
        [data getBytes:&w1 range:NSMakeRange(0x60, 0x1)];
        [data getBytes:&w2 range:NSMakeRange(0x61, 0x1)];
        short w = (w1 << 8) + w2;
        short h1 = 0, h2 = 0;
        [data getBytes:&h1 range:NSMakeRange(0x5e, 0x1)];
        [data getBytes:&h2 range:NSMakeRange(0x5f, 0x1)];
        short h = (h1 << 8) + h2;
        return CGSizeMake(w, h);
    } else {
        short word = 0x0;
        [data getBytes:&word range:NSMakeRange(0x15, 0x1)];
        if (word == 0xdb) {
            [data getBytes:&word range:NSMakeRange(0x5a, 0x1)];
            if (word == 0xdb) {// 两个DQT字段
                short w1 = 0, w2 = 0;
                [data getBytes:&w1 range:NSMakeRange(0xa5, 0x1)];
                [data getBytes:&w2 range:NSMakeRange(0xa6, 0x1)];
                short w = (w1 << 8) + w2;
                short h1 = 0, h2 = 0;
                [data getBytes:&h1 range:NSMakeRange(0xa3, 0x1)];
                [data getBytes:&h2 range:NSMakeRange(0xa4, 0x1)];
                short h = (h1 << 8) + h2;
                return CGSizeMake(w, h);
            } else {// 一个DQT字段
                short w1 = 0, w2 = 0;
                [data getBytes:&w1 range:NSMakeRange(0x60, 0x1)];
                [data getBytes:&w2 range:NSMakeRange(0x61, 0x1)];
                short w = (w1 << 8) + w2;
                short h1 = 0, h2 = 0;
                [data getBytes:&h1 range:NSMakeRange(0x5e, 0x1)];
                [data getBytes:&h2 range:NSMakeRange(0x5f, 0x1)];
                short h = (h1 << 8) + h2;
                return CGSizeMake(w, h);
            }
        } else {
            return CGSizeZero;
        }
    }
}

+ (int)compareDate:(NSString*)firstDate withDate:(NSString*)secondDate{

	int comparisonResult;
	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
	[formatter setDateFormat:@"yyyy-MM-dd"];
	NSDate *date1 = [[NSDate alloc] init];
	NSDate *date2 = [[NSDate alloc] init];
	date1 = [formatter dateFromString:firstDate];
	date2 = [formatter dateFromString:secondDate];
	NSComparisonResult result = [date1 compare:date2];
	NSLog(@"result==%ld",(long)result);
	switch (result)
	{
			//date02比date01大
		case NSOrderedAscending:
			comparisonResult = 1;
			break;
			//date02比date01小
		case NSOrderedDescending:
			comparisonResult = -1;
			break;
			//date02=date01
		case NSOrderedSame:
			comparisonResult = 0;
			break;
		default:
			NSLog(@"erorr dates %@, %@", date1, date2);
			break;
	}
	return comparisonResult;
}

@end
