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

/********* <#注释#> *********/
@property(nonatomic,strong)UIImage * shareImage;

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
    
    NJWeakSelf;
    self.customItemBlock = ^(NSInteger index) {
        [weakSelf customItemBtnClick:index];
    };
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
    
    self.shareImage = shareImage;
    
    [self socialShareLocalSaveWithContent:@"加入LQC" images:@[shareImage] url:nil title:@"加入LQC"];
}

- (void)customItemBtnClick:(NSInteger)index
{
    NJLog(@"%ld", index);
    
    switch (index) {
        case 0://保存到本地
        {
            if(self.shareImage == nil)
            {
                return;
            }
            
            [SVProgressHUD show];
            UIImageWriteToSavedPhotosAlbum(self.shareImage, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
        }
            break;
        case 1://更多
        {
            if(self.shareImage == nil)
            {
                return;
            }
            
            NSString * info = @"加入LQC";
            
            NSArray * items = @[info, self.shareImage];;
            
            UIActivityViewController * activityVC = [[UIActivityViewController alloc] initWithActivityItems:items applicationActivities:nil];
            [self presentViewController:activityVC animated:YES completion:nil];
        }
            break;
            
        default:
            break;
    }
    
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error
  contextInfo:(void *)contextInfo
{
    
    if(error == nil)
    {
        [SVProgressHUD showSuccessWithStatus:@"保存成功"];
        [SVProgressHUD dismissWithDelay:1.2];
        NSLog(@"保存成功");
    }
    else
    {
        [SVProgressHUD showErrorWithStatus:@"保存失败"];
        [SVProgressHUD dismissWithDelay:1.2];
        NSLog(@"%@",error.localizedDescription);
    }
    
    
}
@end
