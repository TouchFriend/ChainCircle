//
//  AppDelegate.m
//  ChainCircle
//
//  Created by TouchWorld on 2018/5/30.
//  Copyright © 2018年 Redirect. All rights reserved.
//

#import "AppDelegate.h"
#import "NJMainVC.h"
#import <IQKeyboardManager.h>
#import <AFNetworkReachabilityManager.h>

//微信
#import <WXApi.h>


//mob分享
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKConnector/ShareSDKConnector.h>

//QQ
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>

// 引入JPush功能所需头文件
#import "JPUSHService.h"

// iOS10注册APNs所需头文件
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif



@interface AppDelegate () <JPUSHRegisterDelegate>

@end

@implementation AppDelegate

/** 微信分享AppID */
#define WeiXinAppID @"wx2cfdcda5eb394acb"
/** 微信分享AppSecrect */
#define WeiXinAppSecrect @"d38fa2c02e0224c0fafacbd8c1ad6e37"

/** QQ分享AppID */
#define QQAppID @"1106745570"
/** QQ分享AppKey */
#define QQAppKey @"EBhVIUQ8UuwBBixj"

//极光推送
#define JPushAppKey @"fc352ef398664fd3a53ad0aa"


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [NSThread sleepForTimeInterval:2.0];
    
    [self setupInit:launchOptions];
    
    
    return YES;
}


- (void)setupInit:(NSDictionary *)launchOptions
{
    //TabBar
    [self setupTabBaritem];
    
    //设置键盘
    [self setupIQKeyboardManager];
    
    //HUD
    [self setupSVProgressHUD];
    
    //社交分享
    [self setupSocialShare];
    
    //极光推送
    [self setupJPush:launchOptions];
    
    //监听网络状态
    [self observeNetworkState];
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    NJMainVC * mainVC = [[NJMainVC alloc] init];
    
    self.window.rootViewController = mainVC;
    
    [self.window makeKeyAndVisible];
}

#pragma mark - 设置TabBar字体颜色
- (void)setupTabBaritem
{
    UITabBarItem * item = [UITabBarItem appearance];
    NSDictionary * attriNormalDic = @{
                                      NSForegroundColorAttributeName : NJColor(122, 126, 131),
                                      };
    NSDictionary * attriSelectedDic = @{
                                        NSForegroundColorAttributeName : NJOrangeColor,
                                        };
    [item setTitleTextAttributes:attriNormalDic forState:UIControlStateNormal];
    [item setTitleTextAttributes:attriSelectedDic forState:UIControlStateSelected];
}

#pragma mark - 设置键盘
- (void)setupIQKeyboardManager
{
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
    [IQKeyboardManager sharedManager].enableAutoToolbar = YES;
    [IQKeyboardManager sharedManager].toolbarDoneBarButtonItemText = @"完成";
    
    [IQKeyboardManager sharedManager].shouldShowToolbarPlaceholder = NO;
}

#pragma mark - SVProgressHUD
- (void)setupSVProgressHUD
{
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
}
    
#pragma mark - 极光推送
- (void)setupJPush:(NSDictionary *)launchOptions
{
    //添加初始化APNs代码
    JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
    entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound;
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        // 可以添加自定义categories
        // NSSet<UNNotificationCategory *> *categories for iOS10 or later
        // NSSet<UIUserNotificationCategory *> *categories for iOS8 and iOS9
    }
    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
    
    //添加初始化JPush代码
    // Required
    // init Push
    // notice: 2.1.5版本的SDK新增的注册方法，改成可上报IDFA，如果没有使用IDFA直接传nil
    // 如需继续使用pushConfig.plist文件声明appKey等配置内容，请依旧使用[JPUSHService setupWithOption:launchOptions]方式初始化。
    [JPUSHService setupWithOption:launchOptions appKey:JPushAppKey
                          channel:@"AppStore"
                 apsForProduction:YES
            advertisingIdentifier:nil];
    
    
    //接收自定义消息
//    NSNotificationCenter * defaultCenter = [NSNotificationCenter defaultCenter];
//    [defaultCenter addObserver:self selector:@selector(networkDidReceiveMessage:) name:kJPFNetworkDidReceiveMessageNotification object:nil];
}

#pragma mark - 监听网络状态
- (void)observeNetworkState
{
    AFNetworkReachabilityManager * manager = [AFNetworkReachabilityManager sharedManager];
    //开始监听
    [manager startMonitoring];
    
    
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusNotReachable:{
                NSLog(@"无网络");
                [SVProgressHUD showErrorWithStatus:@"网络错误"];
                [SVProgressHUD dismissWithDelay:1.2];
                break;
            }
                
            case AFNetworkReachabilityStatusReachableViaWiFi:{
                NSLog(@"WiFi网络");
                //重发数据
                [[NSNotificationCenter defaultCenter] postNotificationName:NotificationWifiNetwork object:nil];
                break;
                
            }
                
            case AFNetworkReachabilityStatusReachableViaWWAN:{
                NSLog(@"无线网络");
                
                //重发数据
                [[NSNotificationCenter defaultCenter] postNotificationName:NotificationWWAN_Networkd object:nil];
                break;
                
            }
                
            default:
            {
                [SVProgressHUD showErrorWithStatus:@"网络错误"];
                [SVProgressHUD dismissWithDelay:1.2];
            }
                break;
                
        }
        
        
    }];
    
}

#pragma mark - 社交分享
- (void)setupSocialShare
{
    
    [ShareSDK registerActivePlatforms:@[
                                        @(SSDKPlatformTypeWechat),
                                        @(SSDKPlatformTypeQQ),
                                        ]
                             onImport:^(SSDKPlatformType platformType)
     {
         switch (platformType)
         {
             case SSDKPlatformTypeWechat:
                 [ShareSDKConnector connectWeChat:[WXApi class]];
                 break;
             case SSDKPlatformTypeQQ:
                 [ShareSDKConnector connectQQ:[QQApiInterface class] tencentOAuthClass:[TencentOAuth class]];
                 break;
             default:
                 break;
         }
     }
                      onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo)
     {
         
         switch (platformType)
         {
             case SSDKPlatformTypeWechat:
                 [appInfo SSDKSetupWeChatByAppId:WeiXinAppID
                                       appSecret:WeiXinAppSecrect];
                 break;
             case SSDKPlatformTypeQQ:
                 [appInfo SSDKSetupQQByAppId:QQAppID
                                      appKey:QQAppKey
                                    authType:SSDKAuthTypeBoth];
                 break;
             default:
                 break;
         }
         
     }];
}

#pragma mark - 注册APNs
    //注册APNs成功并上报DeviceToken
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    [JPUSHService registerDeviceToken:deviceToken];
}
    
    //实现注册APNs失败接口
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    //Optional
    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
}
    


    
// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger options))completionHandler API_AVAILABLE(ios(10.0)){
    // Required
    NSDictionary * userInfo = notification.request.content.userInfo;
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    //处理接收的消息
    [self dealtMsg:userInfo];
    
    completionHandler(UNNotificationPresentationOptionAlert); // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以选择设置
}
    
    
// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void(^)())completionHandler    API_AVAILABLE(ios(10.0)){
    // Required
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    //处理接收的消息
    [self dealtMsg:userInfo];
    completionHandler();  // 系统要求执行这个方法
    
    
}
    
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    //处理接收的消息
    [self dealtMsg:userInfo];
    
    // Required, iOS 7 Support
    [JPUSHService handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
}
    
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    //处理接收的消息
    [self dealtMsg:userInfo];
    
    // Required,For systems with less than or equal to iOS6
    [JPUSHService handleRemoteNotification:userInfo];
}
    
#pragma mark - UIApplicationDelegate方法
- (void)applicationWillEnterForeground:(UIApplication *)application {
    [application setApplicationIconBadgeNumber:0];
    [application cancelAllLocalNotifications];
}
    
- (void)applicationDidEnterBackground:(UIApplication *)application {
    
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
}
    
#pragma mark - 处理接收的消息
- (void)dealtMsg:(NSDictionary *)userInfo
{
    NSLog(@"userInfo:%@", userInfo);
}


@end
