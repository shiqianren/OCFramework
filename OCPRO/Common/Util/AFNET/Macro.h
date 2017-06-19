//
//  Macro.h
//  OCPRO
//
//  Created by shiqianren on 2017/5/3.
//  Copyright © 2017年 shiqianren. All rights reserved.
//
#ifndef IntelligentBuilding_Macro_h
#define IntelligentBuilding_Macro_h


//设备版本
#pragma mark - device

#define CURRENT_IOS_VER             [[[UIDevice currentDevice] systemVersion] floatValue]
#define CURRENT_SYSTEN_VER          [[UIDevice currentDevice] systemVersion]
#define CURRENT_SOFT_VER            [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)kCFBundleVersionKey]
#define CURRENT_LANGUAGE            [[NSLocale preferredLanguages] objectAtIndex:0]


//屏幕、控件尺寸
#pragma mark - UI

#define UI_NAVIGATION_BAR_HEIGHT        44
#define UI_TOOL_BAR_HEIGHT              44
#define UI_TAB_BAR_HEIGHT               49
#define UI_STATUS_BAR_HEIGHT            20
#define UI_SCREEN_HEIGHT_IP4            480
#define UI_SCREEN_HEIGHT_IP5            568
#define UI_SCREEN_WIDTH_IP4            320

#define UI_SCREEN_HEIGHT                ([[UIScreen mainScreen] bounds].size.height)
#define UI_SCREEN_WIDTH                 ([[UIScreen mainScreen] bounds].size.width)

#define UI_SCREEN_D_HEIGHT              UI_SCREEN_HEIGHT - UI_SCREEN_HEIGHT_IP4
#define UI_STATUS_BAR_FRAME_H  [[UIApplication sharedApplication] statusBarFrame].size.height

#define isRetina                        ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)
#define isIP5                           ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define isPad                           (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

#define BottomEdgeYOfView(view)             view.frame.origin.y + view.frame.size.height


//颜色
#pragma mark - color
#define ColorWithRGB(r,g,b)             [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0]
#define ColorWithRGBA(r,g,b,a)          [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#define ColorWithWhite(w)               [UIColor colorWithWhite:w alpha:1.0]
#define ColorWithWhiteAlpha(w,a)        [UIColor colorWithWhite:w alpha:a]

#define BACKGROUND_COLOR                ColorWithRGB(242,242,239)
#define ORANGE_COLOR                    ColorWithRGB(234,67,28)
#define CLEAR_COLOR                     [UIColor clearColor]
#define WHITE_COLOR                     [UIColor whiteColor]
#define BLACK_COLOR                     [UIColor blackColor]
#define GRAY_COLOR                      [UIColor grayColor];
#define TABLE_SELECTED_COLOR            ColorWithRGB(238,238,238)

#define TABLEVIEWBACKGROUND_COLOR       ColorWithRGB(232,232,230)
#define VIEWBACKGROUND_COLOR            ColorWithRGB(240,240,240)

#define TABLEVIEWCELL_COLOR       ColorWithRGB(134,146,164)

#define VIP_TICKET_COLOR                ColorWithRGB(54, 120, 179)
#define TICKET_COLOR                    ColorWithRGB(234, 85, 20)

#define ColorWithHex(hexValue,alphaValue)   [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16))/255.0 green:((float)((hexValue & 0xFF00) >> 8))/255.0 blue:((float)(hexValue & 0xFF))/255.0 alpha:alphaValue];


//字体
#pragma mark - font
#define FontWithNameSize(name, size)    [UIFont fontWithName:name size:size]
#define FontWithSize(size)              [UIFont systemFontOfSize:size]
#define BoldFontWithSize(size)          [UIFont boldSystemFontOfSize:size]


//图片
#pragma mark - iamge

#define ImageNamed(name)                [UIImage imageNamed:name]
#define ImageWithFile(fileName)         [UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:fileName ofType:@"png"]]


//线程
#pragma mark - GCD

#define Global(block)                   dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block)
#define Main(block)                     dispatch_async(dispatch_get_main_queue(),block)
#define kTmpQueue                       dispatch_queue_create("com.lierda.ib", NULL)


#pragma mark - URL
//preproduct地址
//#define kLSDBaseNetURL   @"http://tgcheck.helpedu.com"

//qa地址
//#define kLSDBaseNetURL   @"https://tgcheck.hengtiansoft.com"

// live qa地址
#define kLSDBaseNetURL   @"https://tgcheck.hengtiansoft.com/"

//本地环境
//#define kLSDBaseNetURL   @"http://172.16.15.120:9080"

//product地址
//#define   kLSDBaseNetURL    @"https://checkanswer.helpedu.com"

//uat地址
//#define   kLSDBaseNetURL    @"https://livetg.hengtiansoft.com"

//性能测试地址
//#define kLSDBaseNetURL   @"http://checkpeg.hengtiansoft.com"

//#define kLSDBaseNetURL   @"http://localhost:8081"


#pragma mark - user

#define USERNAME  @"userName"

#define USERPASSWORD  @"userPassWord"
#define USERICON  @"userIcon"
#define USERID  @"userId"
#define USERVERSIOM @"userVersion"
#define WIEGAND  @"wiegand" //韦根号
#define COMPANYADDRESS    @"companyAddress"
#define TEMEMENTID    @"tenementId"
#define JURISDICTION @"jurisdiction"

#define AUTOMATICLOGIN @"AutomaticLogin"

#define kReloadNetDataTimeInterval  5
#define kReloadNetDataTimeIntervalWithNoData  10

#define kLoginNameNotNull -1
#define kLoginPassWordNotNull -2
#define kNotWork -1 // 数据不起作用
#define kDeviceStateNotClear -10
#define kDeviceStateNotClearMessage @"设备状态不明确，不能操作"
//logo地址：/zx_upload/app_icon/ws_ic_launcher.png
//跳转地址：http://tgcheck.hengtiansoft.com/app/download   根据环境改变域名
#define ShareMsg  @"我刚用《作业大师》App校对了暑假作业答案，小伙伴们也一起来用吧！点击下载"
#define ShareLogo @"http://admin.helpedu.com/zx_upload/app_icon/ws_ic_launcher.png"
#define ShareUrl  @"/app/download"


#pragma  mark - blue
//蓝牙
#define kBlePeripheralUUID      @"FFF1"
#define kBleServerUUIDStr       @"FF12"


#pragma mark - popup
/*
 LKPopupMenuControllerSizeSmall = 120,
 LKPopupMenuControllerSizeMedium = 160,
 LKPopupMenuControllerSizeLarge = 200
 */
#define kPopupMenuWidth 200

#define kPopupMenuPointX (UI_SCREEN_WIDTH/2 - 160/2)
#define kPopupMenuPointY 0

#define kRightAndLiftButtonWith  80
#define kDidSelectPopupMenu @"didSelectPopupMenu"//当选择了其他menu item 的时候刷新数据

#define kCGMK(x,y,w,h) CGRectMake(x, y, w, h)

//算 宽加X坐标的和
#define kWIDTH_X(view)  view.frame.size.width + view.frame.origin.x
//算 高加Y坐标的和
#define kHEIGHT_Y(view)  view.frame.size.height + view.frame.origin.y

//计算相对位置的高度
#define  kRELATIVE_H(values) (values * (UI_SCREEN_HEIGHT /568.0))
#define  kRELATIVE_W(values) (values * (UI_SCREEN_WIDTH /320.0))


#pragma mark - light list
#define kDefaultSaturationValues  4
#define kDefaultBrightnessValues  7


#pragma mark - Area List
#define kAreaId  @"areaIdList"
#define kAreaName  @"areaName"
#define kStoreAreaId @"storeArea"


#pragma mark  - brief
#define kScrollImageCount   2
#define kScrollImageHeight   130
#define kServicePageSize 4


#pragma mark - button tag
#define kIntrodtction 143
#define kAreaControl  144
#define kParkService  145
#define kAttendance   146
#define kPayService   147
#define kParking      148
#define kExpress      149
#define kGuidance     150
#define kIndividual   151
#define kAddressBook  228


//result  结果   1 表示成功 －1002 app 手机网络问题  -2001 服务器的数据格式错误 -1001 没有回应
#pragma mark -  Net Respone code
#define kNetSucess 8001
#define kNetNoData 9003
#define kLastPage 9008

#define kStateNoClear 9200
#define kServerNoRespone   -1001
#define kPhoneNetworkError -1002
#define kDataFormatError   -2001
#define kCouldNotConnectToTheServer -1004
#define  kPhoneOffLine   -1009

#define kServerNoResponeMessage   @"请求超时"
#define kPhoneNetworkErrorMessage @"手机网络有问题"
#define kDataFormatErrorMessage   @"数据有问题"
#define kCouldNotConnectToTheServerMessage @"链接不到服务器，请稍后再试"
#define kNetOtherMessage @"服务器正在维护，请稍后再试"
#define kPhoneOffLineMessage @"查看手机网络是否正常"

#endif
