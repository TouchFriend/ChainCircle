//
//  AppDelegate.m
//  ChainCircle
//
//  Created by TouchWorld on 2018/5/30.
//  Copyright © 2018年 Redirect. All rights reserved.
//

#import "AppDelegate.h"
#import "NJMainVC.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [self setupInit];
    
    
    
    return YES;
}


- (void)setupInit
{
    //TabBar
    [self setupTabBaritem];
    
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




@end
