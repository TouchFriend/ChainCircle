//
//  NJViewController.m
//  SmartCity
//
//  Created by TouchWorld on 2018/3/30.
//  Copyright © 2018年 Redirect. All rights reserved.
//

#import "NJViewController.h"
#import "NJLoginVC.h"
#import "NJNavigationController.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKUI/ShareSDKUI.h>
#import "LBXAlertAction.h"

@interface NJViewController ()

@end

@implementation NJViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (void)showLoginVCWithCompletion:(void (^ __nullable)(void))completion
{
    NJLoginVC * loginVC = [[NJLoginVC alloc] init];
    NJNavigationController * naviController = [[NJNavigationController alloc] initWithRootViewController:loginVC];
    
    [self presentViewController:naviController animated:YES completion:completion];
}


- (void)socialShareWithContent:(NSString *)content images:(NSArray *)images url:(NSString *)url title:(NSString *)title
{
    //（注意：图片必须要在Xcode左边目录里面，名称必须要传正确，如果要分享网络图片，可以这样传iamge参数 images:@[@"http://mob.com/Assets/images/logo.png?v=20150320"]）

    NSMutableDictionary * shareParames = [NSMutableDictionary dictionary];
    [shareParames SSDKSetupShareParamsByText:content images:images url:[NSURL URLWithString:url] title:title type:SSDKContentTypeAuto];
     //有的平台要客户端分享需要加此方法，例如微博
    [shareParames SSDKEnableUseClientShare];

    [ShareSDK showShareActionSheet:nil items:nil shareParams:shareParames onShareStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
        switch (state) {
            case SSDKResponseStateSuccess:
            {
                [LBXAlertAction showAlertWithTitle:@"分享成功" msg:nil buttonsStatement:@[@"确定"] chooseBlock:^(NSInteger buttonIdx) {

                }];

                break;
            }
            case SSDKResponseStateFail:
            {
                [LBXAlertAction showAlertWithTitle:@"分享失败" msg:[NSString stringWithFormat:@"%@",error] buttonsStatement:@[@"确定"] chooseBlock:^(NSInteger buttonIdx) {

                }];
                break;
            }
            default:
                break;
        }
    }];
}

@end
