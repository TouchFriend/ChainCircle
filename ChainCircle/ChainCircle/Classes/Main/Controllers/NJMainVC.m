//
//  NJMainVC.m
//  ChainCircle
//
//  Created by TouchWorld on 2018/5/30.
//  Copyright © 2018年 Redirect. All rights reserved.
//

#import "NJMainVC.h"
#import "NJViewController.h"
#import "UIImage+NJImage.h"
#import "NJNavigationController.h"

@interface NJMainVC () <UITabBarControllerDelegate>
/********* 子控制器数据 *********/
@property(nonatomic,strong)NSArray<NSDictionary *> * childVCDatas;
@end

@implementation NJMainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupInit];
}

- (void)setupInit
{
    self.tabBar.backgroundColor = [UIColor whiteColor];
    self.delegate = self;
    [self addChildViewControllers];
}
- (void)addChildViewControllers
{
    for (NSDictionary * dic in self.childVCDatas)
    {
        [self addChildViewControllers:dic[@"className"] title:dic[@"title"] image:dic[@"image"]];
    }
}

/**
 添加TabBar子控制器
 
 @param childVCName 子控制器类名
 @param title 标题
 @param imageName 图片迷宫
 */
- (void)addChildViewControllers:(NSString *)childVCName title:(NSString *)title image:(NSString *)imageName
{
    Class childClass = NSClassFromString(childVCName);
    NJViewController * childVC = [[childClass alloc]init];
    
    UITabBarItem * tabBarItem = [[UITabBarItem alloc]init];
    [tabBarItem setImage:[UIImage imageOriginNamed:imageName]];
    [tabBarItem setSelectedImage:[UIImage imageOriginNamed:[imageName stringByAppendingString:@"_pre"]]];
    [tabBarItem setTitle:title];
    childVC.tabBarItem = tabBarItem;
    
    NJNavigationController * navVC = [[NJNavigationController alloc]init];
    [navVC pushViewController:childVC animated:YES];
    [self addChildViewController:navVC];
    
}

#pragma mark - 懒加载
- (NSArray<NSDictionary *> *)childVCDatas
{
    if(_childVCDatas == nil)
    {
        NSArray<NSDictionary *> * childVCDatas = @[
                                                   @{
                                                       @"className" : @"NJLqcVC",
                                                       @"title" : @"LQC",
                                                       @"image" : @"Lqc",
                                                       },
                                                   @{
                                                       @"className" : @"NJCheckGroupVC",
                                                       @"title" : @"审核群",
                                                       @"image" : @"CheckGroup",
                                                       },
                                                   @{
                                                       @"className" : @"NJRobAdVC",
                                                       @"title" : @"抢广告",
                                                       @"image" : @"robAd",
                                                       },
                                                   
                                                   ];
        _childVCDatas = childVCDatas;
    }
    return _childVCDatas;
}


@end
