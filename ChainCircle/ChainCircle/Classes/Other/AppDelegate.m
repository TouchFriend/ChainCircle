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

@interface AppDelegate ()

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



- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [self setupInit];
    
    
    
    return YES;
}


- (void)setupInit
{
    //TabBar
    [self setupTabBaritem];
    
    //设置键盘
    [self setupIQKeyboardManager];
    
    //HUD
    [self setupSVProgressHUD];
    
    //社交分享
    [self setupSocialShare];
    
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

                break;
                
            }
                
            case AFNetworkReachabilityStatusReachableViaWWAN:{
                NSLog(@"无线网络");
                //重发数据

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


@end
