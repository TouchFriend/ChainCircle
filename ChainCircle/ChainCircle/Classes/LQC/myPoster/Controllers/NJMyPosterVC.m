//
//  NJMyPosterVC.m
//  ChainCircle
//
//  Created by TouchWorld on 2018/6/5.
//  Copyright © 2018年 Redirect. All rights reserved.
//

#import "NJMyPosterVC.h"
#import "NJInviteCardView.h"
#import "UIImage+NJImage.h"


@interface NJMyPosterVC ()

/********* <#注释#> *********/
@property(nonatomic,weak)UIScrollView * scrollView;

/********* <#注释#> *********/
@property(nonatomic,weak)UIView * posterView;

/********* <#注释#> *********/
@property(nonatomic,strong)UIImage * shareImage;

/********* 邀请人数 *********/
@property(nonatomic,assign)NSInteger invitedNum;

/********* <#注释#> *********/
@property(nonatomic,weak)NJInviteCardView * inviteCardView;
@end

@implementation NJMyPosterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupInit];
}
- (void)setupInit
{
    self.invitedNum = 0;
    
    [self setupNaviBar];
    
    [self setupScrollView];
    
    NJWeakSelf;
    self.customItemBlock = ^(NSInteger index) {
        [weakSelf customItemBtnClick:index];
    };
    
    [self getInviteRecordListRequest];
}

#pragma mark - 导航条
- (void)setupNaviBar
{
    self.title = @"链圈15亿LQC免费领取说明";
    
    UIBarButtonItem * shareItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageOriginNamed:@"share_inviteFriend"] style:UIBarButtonItemStylePlain target:self action:@selector(shareItemClick)];

    self.navigationItem.rightBarButtonItems = @[shareItem];
}

#pragma mark - 导航条
- (void)setupScrollView
{
    UIScrollView * scrollView = [[UIScrollView alloc] init];
    [self.view addSubview:scrollView];
    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    scrollView.backgroundColor = [UIColor whiteColor];
    self.scrollView = scrollView;
    
    UIView * contentView = [[UIView alloc] init];
    [scrollView addSubview:contentView];
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(scrollView);
        make.width.mas_equalTo(scrollView);
        
    }];
    UIImageView * bgImageV = [[UIImageView alloc] init];
    
    [contentView addSubview:bgImageV];
    [bgImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(contentView);
        //        make.height.mas_equalTo(1000);
    }];
    bgImageV.image = [UIImage imageNamed:@"bg_myPoster"];
    
    UIView * posterView = [[UIView alloc] init];
    [contentView addSubview:posterView];
    [posterView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(contentView);
    }];
    self.posterView = posterView;
    [self setupPostViewChildView];
    
    NJInviteCardView * inviteCardView = [NJInviteCardView NJ_loadViewFromXib];
    [scrollView addSubview:inviteCardView];
    [inviteCardView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(posterView.mas_bottom);
        make.left.mas_equalTo(contentView).mas_offset(15);
        make.right.bottom.mas_equalTo(contentView).mas_offset(-15);
        make.height.mas_equalTo(442);
    }];
    
    self.inviteCardView = inviteCardView;
    [inviteCardView addAllCornerRadius:8.0];
}

- (void)setupPostViewChildView
{
    UIImageView * iconImageV = [[UIImageView alloc] init];
    [self.posterView addSubview:iconImageV];
    [iconImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(70, 70));
        make.top.mas_equalTo(self.posterView.mas_top).mas_offset(30);
        make.centerX.mas_equalTo(self.posterView);
    }];
    iconImageV.image = [UIImage imageNamed:@"icon"];
    
    
    UILabel * appNameLabel = [[UILabel alloc] init];
    [self.posterView addSubview:appNameLabel];
    [appNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(iconImageV.mas_bottom).mas_offset(10);
        make.left.right.mas_equalTo(self.posterView);
        make.height.mas_equalTo(25);
    }];
    appNameLabel.text = @"链圈";
    appNameLabel.textColor = [UIColor whiteColor];
    appNameLabel.font = [UIFont systemFontOfSize:18.0];
    appNameLabel.textAlignment = NSTextAlignmentCenter;
    
    UILabel * desLabel = [[UILabel alloc] init];
    [self.posterView addSubview:desLabel];
    [desLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(appNameLabel.mas_bottom).mas_offset(10);
        make.left.right.mas_equalTo(self.posterView);
        make.height.mas_equalTo(20);
    }];
    desLabel.text = @"中国领先的区块链社群";
    desLabel.textColor = [UIColor whiteColor];
    desLabel.font = [UIFont systemFontOfSize:14.0];
    desLabel.textAlignment = NSTextAlignmentCenter;
    
    UILabel * titleLabel = [[UILabel alloc] init];
    [self.posterView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.posterView);
        make.top.mas_equalTo(desLabel.mas_bottom).mas_offset(10);
        make.height.mas_equalTo(43);
    }];
    titleLabel.text = @"15亿LQC免费大放送";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont boldSystemFontOfSize:32];
    titleLabel.textColor = NJOrangeColor;
    
    CGFloat margin = 15;
    
    UILabel * nameDesLabel = [[UILabel alloc] init];
    [self.posterView addSubview:nameDesLabel];
    [nameDesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(titleLabel.mas_bottom).mas_offset(30);
        make.left.mas_equalTo(self.posterView).mas_offset(margin);
        make.height.mas_equalTo(25);
    }];
    nameDesLabel.text = @"链圈简介：";
    nameDesLabel.textColor = NJOrangeColor;
    nameDesLabel.font = [UIFont systemFontOfSize:18.0];
    nameDesLabel.textAlignment = NSTextAlignmentLeft;
    
    UILabel * textLabel1 = [[UILabel alloc] init];
    [self.posterView addSubview:textLabel1];
    [textLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(nameDesLabel.mas_bottom).mas_offset(5);
        make.left.mas_equalTo(self.posterView).mas_offset(margin);
        make.right.mas_equalTo(self.posterView).mas_offset(-margin);
    }];
    textLabel1.text = @"链圈是基于区块链技术、激励模型、分配机制共识的一项社会实践，意在让每个人都能更简单明了、直观的体会到区块链浪潮带来的社会变革和更开放的共享经济生态，更轻松就能获得自身的生存价值感。\n\n链圈也是一个真正明确的能为社会做出改变的落地项目，我们最先要挑战的是传统互联网广告业务市场，其存在几大弊端或不足：";
    textLabel1.textColor = [UIColor whiteColor];
    textLabel1.font = [UIFont systemFontOfSize:14.0];
    textLabel1.textAlignment = NSTextAlignmentLeft;
    textLabel1.numberOfLines = 0;
    
    UILabel * textLabel2 = [[UILabel alloc] init];
    [self.posterView addSubview:textLabel2];
    [textLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(textLabel1.mas_bottom).mas_offset(5);
        make.left.mas_equalTo(self.posterView).mas_offset(margin);
        make.right.mas_equalTo(self.posterView).mas_offset(-margin);
    }];
    textLabel2.text = @"1.我们作为互联网的一名用户:更多是被动接受广告受众的单一角色，广告商投放的广告收入和我们没有半毛钱关系；\n2.作为广告商：互联网平台的垄断性，不仅广告费成本高昂，且预充值广告费不能退，现金流被平台占用了；\n3.现有的互联网企业巨头走的是传统公司化运作与融资方式，大都是资本（外资）占比比例很大，可以理解为巨头公司都是打工仔，利润都是上缴给资本方。";
    textLabel2.textColor = NJColor(201, 134, 247);
    textLabel2.font = [UIFont systemFontOfSize:14.0];
    textLabel2.textAlignment = NSTextAlignmentLeft;
    textLabel2.numberOfLines = 0;
    
    UILabel * textLabel3 = [[UILabel alloc] init];
    [self.posterView addSubview:textLabel3];
    [textLabel3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(textLabel2.mas_bottom).mas_offset(25);
        make.left.mas_equalTo(self.posterView).mas_offset(margin);
        make.right.mas_equalTo(self.posterView).mas_offset(-margin);
    }];
    textLabel3.text = @"链圈的优势是：\n1.我们将不仅仅是广告受众的单一角色，摇身一变能成为广告渠道资源提供方，获得广告商投放的广告收入；\n2.广告商投放不再是向平台付费，而是由用户直接贡献的渠道资源，采用Token记账方式向用户收购Token进行投放，剩余Token可以出售变现、甚至增值获利。\n3.链圈打破组织边界重组互联网广告业务市场，采用Token记账，从一开始就让每个人能够获得Token，小小的贡献自己的力量就能实现价值共享，是共赢的关系。";
    textLabel3.textColor = [UIColor whiteColor];
    textLabel3.font = [UIFont systemFontOfSize:14.0];
    textLabel3.textAlignment = NSTextAlignmentLeft;
    textLabel3.numberOfLines = 0;
    
    UILabel * textLabel4 = [[UILabel alloc] init];
    [self.posterView addSubview:textLabel4];
    [textLabel4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(textLabel3.mas_bottom).mas_offset(30);
        make.left.mas_equalTo(self.posterView).mas_offset(margin);
        make.right.mas_equalTo(self.posterView).mas_offset(-margin);
    }];
    textLabel4.text = @"LQC简介：";
    textLabel4.textColor = NJOrangeColor;
    textLabel4.font = [UIFont systemFontOfSize:18.0];
    textLabel4.textAlignment = NSTextAlignmentLeft;
    textLabel4.numberOfLines = 0;
    
    UILabel * textLabel5 = [[UILabel alloc] init];
    [self.posterView addSubview:textLabel5];
    [textLabel5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(textLabel4.mas_bottom);
        make.left.mas_equalTo(self.posterView).mas_offset(margin);
        make.right.mas_equalTo(self.posterView).mas_offset(-margin);
        make.bottom.mas_equalTo(self.posterView).mas_offset(-40);
    }];
    textLabel5.text = @"LQCoin，简称LQC，是链圈专为创新型区块链互联网广告市场方便记账使用发起的Token，每个人都可以轻松免费参与获得LQC，可出售给广告商用于投放推广，并可以用于链圈的消费、兑换等。";
    textLabel5.textColor = [UIColor whiteColor];
    textLabel5.font = [UIFont systemFontOfSize:14.0];
    textLabel5.textAlignment = NSTextAlignmentLeft;
    textLabel5.numberOfLines = 0;
    
}

- (void)shareItemClick
{
    UIImage * shareImage = [self getShareImage];
    
    self.shareImage = shareImage;
    
    [self socialShareLocalSaveWithContent:@"LQC免费领取说明" images:@[shareImage] url:nil title:@"链圈15亿LQC免费领取说明"];
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
            
            NSString * info = @"链圈15亿LQC免费领取说明";
            
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

#pragma mark - 网络请求

- (void)getInviteRecordListRequest
{
    [SVProgressHUD show];
    [NetRequest getInviteInfoWithCompleted:^(id data, int flag) {
        [SVProgressHUD dismissWithDelay:0.2];
        if(flag == GetInviteInfo)
        {
            if(getIntInDict(data, DictionaryKeyCode) == ResultTypeSuccess)
            {
                NSDictionary * dataDic = getDictionaryInDict(data, DictionaryKeyData);
                NSNumber * userNum = dataDic[@"user_num"];
                if(userNum != nil)
                {
                    self.invitedNum = userNum.integerValue;
                    self.inviteCardView.invitedNum = self.invitedNum;
                }
            }
            else
            {
                
                [SVProgressHUD showErrorWithStatus:getStringInDict(data, DictionaryKeyData)];
                [SVProgressHUD dismissWithDelay:1.5];
            }
        }
    }];
}

#pragma mark - 事件


- (UIImage *)getShareImage
{
    return [UIImage longPic:self.scrollView];
}

@end
