//
//  NJWebVC.m
//  SmartCity
//
//  Created by TouchWorld on 2018/5/6.
//  Copyright © 2018年 Redirect. All rights reserved.
//

#import "NJWebVC.h"
#import <WebKit/WebKit.h>
#import "UIImage+NJImage.h"

@interface NJWebVC () <WKUIDelegate>

@end

@implementation NJWebVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //设置初始化
    [self setupInit];
}
#pragma mark - 设置初始化
- (void)setupInit
{
    [self setupNaviBar];
    
    [self setupWebView];
    
    NJWeakSelf;
    self.customItemBlock = ^(NSInteger index) {
        [weakSelf customBtnClick:index];
    };
}
#pragma mark - 导航条
- (void)setupNaviBar
{
    self.navigationItem.title = self.titleStr;
    
    UIBarButtonItem * shareItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageOriginNamed:@"share_inviteFriend"] style:UIBarButtonItemStylePlain target:self action:@selector(shareItemClick)];
    
    self.navigationItem.rightBarButtonItems = @[shareItem];
}

#pragma mark - webView
- (void)setupWebView
{
    WKWebViewConfiguration * config = [[WKWebViewConfiguration alloc]init];
    WKWebView * webView = [[WKWebView alloc] initWithFrame:CGRectZero configuration:config];
    [self.view addSubview:webView];
    
    [webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    webView.UIDelegate = self;
    
    NSURL * url = [NSURL URLWithString:self.urlStr];
    NSURLRequest * request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
    
    
    
}

#pragma mark - 事件
- (void)shareItemClick
{
    [self socialShareAndMoreWithContent:self.contentStr images:@[[UIImage imageNamed:@"icon"]] url:self.urlStr title:self.titleStr];
}

- (void)customBtnClick:(NSInteger)index
{
    if(index == 1)//更多
    {
        NSString * info = self.titleStr;
        NSString * content = self.contentStr;
        UIImage * image = [UIImage imageNamed:@"icon"];
        NSURL * url = [NSURL URLWithString:self.urlStr];
        NSArray * items = @[info, content, image, url];
        
        UIActivityViewController * activityVC = [[UIActivityViewController alloc] initWithActivityItems:items applicationActivities:nil];
        
        [self presentViewController:activityVC animated:YES completion:nil];
    }
}

@end
