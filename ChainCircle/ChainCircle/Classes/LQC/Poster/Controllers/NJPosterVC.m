//
//  NJPosterVC.m
//  ChainCircle
//
//  Created by TouchWorld on 2018/6/5.
//  Copyright © 2018年 Redirect. All rights reserved.
//

#import "NJPosterVC.h"
#import "NJPosterView.h"
#import "NJPosterItem.h"
#import "UIImage+NJImage.h"

@interface NJPosterVC ()
/********* <#注释#> *********/
@property(nonatomic,weak)NJPosterView * posterView;
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
    
    [self setupPoster];
}

#pragma mark - 导航条
- (void)setupNaviBar
{
    self.title = @"选择素材邀请朋友";
    
    UIBarButtonItem * shareItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageOriginNamed:@"share_inviteFriend"] style:UIBarButtonItemStylePlain target:self action:@selector(shareItemClick)];
    
    self.navigationItem.rightBarButtonItems = @[shareItem];
}

#pragma mark - 海报
- (void)setupPoster
{
    NJPosterView * posterView = [[NJPosterView alloc] init];
    [self.view addSubview:posterView];
    [posterView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    
    self.posterView = posterView;
    posterView.item = self.item;
}


- (void)shareItemClick
{
    UIImage * shareImage = [self.posterView getShareImage];
    
    [self socialShareWithContent:@"加入LQC" images:@[shareImage] url:nil title:@"加入LQC"];
}
@end
