//
//  AppSetting.h
//  OCPRO
//
//  Created by shiqianren on 2017/5/3.
//  Copyright © 2017年 shiqianren. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>
#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import <UIKit/UIKitDefines.h>
#import <UIKit/UIScreen.h>
#import <UIKit/UITraitCollection.h>
#import <UIKit/UIView.h>
#import "HexColor.h"
#import "theUtility.h"
#import "UIView+HYAddtion.h"
#import "UILabel+StringFrame.h"
//#import "metamacros.h"
//#import "NSStringAdditions.h"
//#import "UITableViewAdditions.h"
#import "NSString+MD5.h"

//字体

#define FONT_SIZE_NUMBER        8 //图标栏中的数字提醒
#define FONT_SIZE_NOTE          12 //注释性的文字，产品基础信息，产品活动信息
#define FONT_SIZE_SECONDARY     14 //导航栏，图标栏中的文字，部分次要文字，划去价格
#define FONT_SIZE_TITLE         18 //菜单栏，商品标题，按钮字体
#define FONT_SIZE_PRICE         22 //主显示价格
#define FONT_SIZE_BIG_TITLE     20 //大标题
#define NavBarTitleFont         FONT_SIZE_BIG_TITLE
#define BUTTONFONT              FONT_SIZE_TITLE

//布局
#define PADDING_LEFT        12
#define PADDING_RIGHT       12
#define PADDING_VERTICAL    12
#define BOTTOM_VIEW_HEIGHT  50 //底部操作栏高度

//  delegate
#define TheAppDelegate ((AppDelegate *)([UIApplication sharedApplication].delegate))
#define LOCAL_HISTORY_NOTIFICATION @"LOCAL_HISTORY_NOTIFICATION"

//app加密key
#define MD5_key @"143b53053d9f2001e01407daf0bd57d0"


//app corner radius
//#define CORNER_RADIUS 5

#define ASK_SERVER_SUCCESS      @"ACK"                      //接口回调成功
#define ASK_SERVER_FAILED       @"NACK"                     //接口回调失败
#define ASK_NO_RECORD           @"NO_RECORD"                //找不到参数
#define ASK_WRONG_BARCODE       @"WRONG_BARCODE"            //条形码不正确
#define TOKEN_IDERROR           @"TOKEN_ID_ERROR"           //token和mobileCode不一致
#define ASK_SERVER_RELOGIN      @"2"                        //重新登录 TOKEN_ID_ERROR
#define ASK_SERVER_LOWVERSION   @"4"                        //版本太低
#define ASK_NET_FAILED          @"NET_CONNECT_FAILED"       //网络未连接
#define ASK_SERVER_FIRST_LOGIN  @"FIRST_LOGIN"              //第一次登陆
#define ASK_SERVER_ERROR        @"<null>"                   //后台报null


//用户信息存储的key
#define TONGGUAN_USERNAME    @"theUsername"
#define TONGGUAN_PASSWARD    @"thePassward"
#define TONGGUAN_UNIOCODE    @"theUniocode"



// color config
#define ClearColor              [UIColor clearColor]
#define BlueColor               [theUtility colorWithRed:72 green:149 blue:290 alpha:1]
#define TouchDownBlueColor      [theUtility colorWithRed:21 green:122 blue:232 alpha:1]
#define GreenColor              [theUtility colorWithRed:12 green:183 blue:109 alpha:1]
#define NavBarBlackColor        [theUtility colorWithRed:42 green:42 blue:48 alpha:1]
#define SelectTextColor         [theUtility colorWithRed:244 green:106 blue:40 alpha:1]
#define lineBackColor           [theUtility colorWithRed:230 green:230 blue:230 alpha:1]


#define BlueChuXiaoColor        [theUtility colorWithRed:34 green:131 blue:201 alpha:1];

#define VineBlueColor           [UIColor colorWithHexString:@"#00C08E"]
#define DarkGrayColor           [UIColor colorWithHexString:@"#7D7D7D"]
#define LightDarkDarkGrayColor  [UIColor colorWithHexString:@"#C3C3C3"]
#define LightDarkGrayColor      [UIColor colorWithHexString:@"#E3E3E3"]
#define LightGrayLineColor      [UIColor colorWithHexString:@"#F0F0F0"]
#define LightGrayColor          [UIColor colorWithHexString:@"#F5F5F5"]
#define NavBarColor             [UIColor colorWithHexString:@"#0090ec"]
#define SubmitButtonColor       [UIColor colorWithHexString:@"#FF7F00"]
#define AlertRedColor           [theUtility colorWithRed:243 green:67 blue:48 alpha:1]
#define WhiteColor              [UIColor whiteColor]
#define TouchDownWhiteColor     [UIColor colorWithWhite:1.0 alpha:0.4]
#define BlackColor              [UIColor blackColor]
#define InputTextColor          [theUtility colorWithRed:40 green:40 blue:40 alpha:1]
#define GrayColor               [theUtility colorWithRed:141 green:141 blue:141 alpha:1]
#define BorderColor             [theUtility colorWithRed:206 green:206 blue:206 alpha:1]
#define DefaultBackgroundColor          [UIColor colorWithPatternImage:[UIImage imageNamed:@"background_gray"]]
#define BlackTextColor                  [UIColor colorWithHexString:@"#282828"]
#define DeepDarkColor                   [UIColor colorWithRed:0.1176 green:0.1176 blue:0.1176 alpha:1.0]
#define MediumReviewColor       [theUtility colorWithRed:217 green:137 blue:32 alpha:1]

//边框灰：#E4E4E4
//边框绿：#ACD1A0
//背景绿：#E3FFD9
//边框黄：#E9C67E
//背景黄：#FFEBBA
#define COLORBKGREEN           [UIColor colorWithHexString:@"#ACD1A0"]
#define COLORBACKGREEN          [UIColor colorWithHexString:@"#E3FFD9"]
#define COLORBKYELLOW           [UIColor colorWithHexString:@"#E9C67E"]
#define COLORBACKYELLOW         [UIColor colorWithHexString:@"#FFEBBA"]

//客户指定颜色
#define CONTENT_RED_COLOR   [UIColor colorWithHexString:@"#ff0100"]
#define GOODS_BORDER_COLOR  [UIColor colorWithHexString:@"#F0F0F0"]
#define UN_SELF_SALE_COLOR  [UIColor colorWithHexString:@"#058868"]
#define CURRENT_PRICE_COLOR [UIColor colorWithHexString:@"#ff0100"]
#define ORDER_BUTTON_COLOR  [UIColor colorWithHexString:@"#ff3c00"]
#define LineLightGrayColor  [UIColor colorWithHexString:@"#F0F0F0"]
#define GrayBackgroundColor [theUtility colorWithRed:229 green:230 blue:231 alpha:1]
#define Black_COLOR  [UIColor colorWithHexString:@"#333333"]

//used in new main
#define ORANGE_INSIDE_COLOR    [theUtility colorWithRed:232 green:63 blue:76 alpha:1]
#define BLUE_INSIDE_COLOR    [theUtility colorWithRed:104 green:182 blue:245 alpha:1]

//main frame size
#define PortraitWidth           [[UIScreen mainScreen] bounds].size.width
#define PortraitHeight          [[UIScreen mainScreen] bounds].size.height
#define UIColorRGBA(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]

// 判断长短屏幕
#define iPhone5 (([UIScreen mainScreen].bounds.size.height > 480) ? YES : NO)
// 判断系统版本是否为iOS 7或以上	。
#define iOS7_or_Later ([[UIDevice currentDevice] systemVersion].floatValue >= 7.0 ? YES : NO)
// 判断系统版本是不是iOS 8或之后
#define iOS8_or_Later ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
// 获取整个屏幕的bounds
#define __SCREEN__ [[UIScreen mainScreen] bounds]
//获取当前版本号
#define HYVERSION  [[[NSBundle mainBundle] infoDictionary] valueForKey:@"CFBundleShortVersionString"]

#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_RETINA ([[UIScreen mainScreen] scale] >= 2.0)

#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
#define SCREEN_MAX_LENGTH (MAX(SCREEN_WIDTH, SCREEN_HEIGHT))
#define SCREEN_MIN_LENGTH (MIN(SCREEN_WIDTH, SCREEN_HEIGHT))

#define IS_IPHONE_4_OR_LESS (IS_IPHONE && SCREEN_MAX_LENGTH < 568.0)
#define IS_IPHONE_5 (IS_IPHONE && SCREEN_MAX_LENGTH == 568.0)
#define IS_IPHONE_6 (IS_IPHONE && SCREEN_MAX_LENGTH == 667.0)
#define IS_IPHONE_6P (IS_IPHONE && SCREEN_MAX_LENGTH == 736.0)

//本地化存储
#define UserDefaults                        [NSUserDefaults standardUserDefaults]


#pragma mark - 友盟数据统计

#define kUMengAppKey @"57862d1067e58e6a03002ba0"
#define kTalkingDataAppKey @"A37E525D2B4A499E8A0F8B2C8C13C355"


@interface AppSetting : NSObject
/**
 *  run on main thread
 */
void RUN_ON_MAIN_THREAD(dispatch_block_t block);
///**
// *  获取UUID(现在用identifierForVendor代替)
// */
+(NSString *)getHYCfuuid;

/**
 *  获取当前app版本号
 */
+ (NSString *)appVersion;
/**
 *  获取当前app build版本号
 */
+ (NSString *)appBuildVersion;

/**
 *  获取Document路径，并生成最终路径
 */
+ (NSString *)filePathToDocumentWithFileName:(NSString *)fileName;

/**
 * 获取手机屏幕像素值
 */
+ (CGSize)mainScreenPixel;


+ (NSString *)getUniqueStrByUUID;
@end
