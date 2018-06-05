//
//  NJPosterVC.m
//  ChainCircle
//
//  Created by TouchWorld on 2018/6/5.
//  Copyright © 2018年 Redirect. All rights reserved.
//

#import "NJPosterVC.h"

@interface NJPosterVC ()

@end

@implementation NJPosterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupInit];
}

#pragma mark - 设置初始化
- (void)setupInit
{
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupNaviBar];
}

#pragma mark - 导航条
- (void)setupNaviBar
{
    self.title = @"选择素材邀请朋友";
}


@end
