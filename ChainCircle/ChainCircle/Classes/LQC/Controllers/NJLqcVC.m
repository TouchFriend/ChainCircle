//
//  NJLqcVC.m
//  ChainCircle
//
//  Created by TouchWorld on 2018/5/30.
//  Copyright © 2018年 Redirect. All rights reserved.
//

#import "NJLqcVC.h"
#import "NJLqcCell.h"
#import "NJLqcHeaderView.h"
#import "NJLqcFooterView.h"
#import "UIImage+NJImage.h"
#import "NJInviteFriendVC.h"
#import "NJLoginVC.h"
#import "NJBindInviteCodeVC.h"
#import "LBXAlertAction.h"
#import <MJRefresh.h>
#import "NJUserItem.h"
#import "FileManager.h"

@interface NJLqcVC () <UICollectionViewDataSource, UICollectionViewDelegate>
/********* <#注释#> *********/
@property(nonatomic,weak)UICollectionView * collectionView;

/********* <#注释#> *********/
@property(nonatomic,strong)NSArray * dataArr;

/********* <#注释#> *********/
@property(nonatomic,weak)NJLqcHeaderView * headerView;
@end

@implementation NJLqcVC
static NSString * const ID = @"NJLqcCell";
static NSString * const headerID = @"NJLqcHeaderView";
static NSString * const footerID = @"NJLqcFooterView";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupInit];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:NJColor(255, 132, 3)] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setTitleTextAttributes:@{
                                                                      NSForegroundColorAttributeName : [UIColor whiteColor],
                                                                      }];
}


- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forBarMetrics:UIBarMetricsDefault];
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{
                                                                      NSForegroundColorAttributeName : [UIColor blackColor],
                                                                      }];
}

#pragma mark - 设置初始化
- (void)setupInit
{
    self.view.backgroundColor = NJBgColor;
    [self setupNaviBar];
    
    [self setupCollectionView];
    

    
}

#pragma mark - 导航条
- (void)setupNaviBar
{
    self.title = @"LQC";
    
    UIBarButtonItem * personItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageOriginNamed:@"person"] style:UIBarButtonItemStylePlain target:self action:@selector(personBtnClick)];
    
    self.navigationItem.leftBarButtonItems = @[personItem];
}

#pragma mark - collectionView
- (void)setupCollectionView
{
    UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc] init];
    CGFloat itemWidth = (NJScreenW - 4)/3.0;
    flowLayout.itemSize = CGSizeMake(itemWidth, itemWidth / 0.847);
    flowLayout.minimumLineSpacing = 2;
    flowLayout.minimumInteritemSpacing = 2;
    flowLayout.headerReferenceSize = CGSizeMake(NJScreenW, 369);
    flowLayout.footerReferenceSize = CGSizeMake(NJScreenW, 460);
    
    UICollectionView * collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    
    [self.view addSubview:collectionView];
    [collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    
    self.collectionView = collectionView;
    collectionView.backgroundColor = NJBgColor;
    collectionView.dataSource = self;
    collectionView.delegate = self;
    
    
    [collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([NJLqcCell class]) bundle:nil] forCellWithReuseIdentifier:ID];
    
    [collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([NJLqcHeaderView class]) bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerID];
    [collectionView registerClass:[NJLqcFooterView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:footerID];
    
    collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(getMyAwardNumRequest)];
}

#pragma mark - 网络请求
//首次登录奖励
- (void)firstLoginRewardRequest
{
    [NetRequest getFirstLoginAwardWithCompleted:^(id data, int flag) {
        if(flag == GetFirstLoginAward)
        {
            if(getIntInDict(data, DictionaryKeyCode) == ResultTypeSuccess)
            {
                NJUserItem * userItem = [NJLoginTool getCurrentUser];
                userItem.is_first_login_get = @(1);
                
                [NJLoginTool setCurrentUser:userItem];
                
                [SVProgressHUD showSuccessWithStatus:@"领取成功"];
                [SVProgressHUD dismissWithDelay:1.5];
                
                [self getMyAwardNumRequest];
            }
            else
            {
                
                [SVProgressHUD showErrorWithStatus:getStringInDict(data, DictionaryKeyData)];
                [SVProgressHUD dismissWithDelay:1.5];
            }
        }
    }];
}

//获取可领取奖励LQC数量
- (void)getMyAwardNumRequest
{
    [NetRequest getMyAwardNumWithCompleted:^(id data, int flag) {
        [self.collectionView.mj_header endRefreshing];
        if(flag == GetMyAwardNum)
        {
            if(getIntInDict(data, DictionaryKeyCode) == ResultTypeSuccess)
            {
                NSNumber * num = getNumberInDict(data, DictionaryKeyCode);
                
                NJLog(@"num:%@", num);
                
                self.headerView.canReceiveNumLabel.text = num.stringValue;
            }
            else
            {
                [SVProgressHUD showErrorWithStatus:getStringInDict(data, DictionaryKeyData)];
                [SVProgressHUD dismissWithDelay:1.5];
            }
        }
    }];
}

//获取可领取奖励
- (void)getMyAwardRequest
{
    
    [NetRequest getMyAwardWithCompleted:^(id data, int flag) {
        
        if(flag == GetMyAward)
        {
            if(getIntInDict(data, DictionaryKeyCode) == ResultTypeSuccess)
            {
                self.headerView.canReceiveNumLabel.text = @"0";
                [SVProgressHUD showSuccessWithStatus:@"领取成功"];
                [SVProgressHUD dismissWithDelay:1.5];
            }
            else
            {
                
                [SVProgressHUD showErrorWithStatus:getStringInDict(data, DictionaryKeyData)];
                [SVProgressHUD dismissWithDelay:1.5];
            }
        }
    }];
}

#pragma mark - UICollectionViewDataSource方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NJLqcCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    NSDictionary * dataDic = self.dataArr[indexPath.row];
    cell.dataDic = dataDic;
    return cell;
}

#pragma mark - UICollectionViewDelegate方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [SVProgressHUD showInfoWithStatus:@"即将上线"];
    [SVProgressHUD dismissWithDelay:1.5];
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if(kind == UICollectionElementKindSectionHeader)
    {
        NJLqcHeaderView * headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerID forIndexPath:indexPath];
        self.headerView = headerView;
        NJWeakSelf;
        headerView.receiveBlock = ^{
            [weakSelf receiveBtnClick];
        };
        return headerView;
    }
    else
    {
        NJLqcFooterView * footerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:footerID forIndexPath:indexPath];
        NJWeakSelf;
        footerView.methodClick = ^(NSInteger index) {
            [weakSelf methodClick:index];
        };
        return footerView;
    }
}

#pragma mark - 事件
- (void)personBtnClick
{
    if([NJLoginTool isLogin])
    {
        
        [LBXAlertAction showAlertWithTitle:@"是否退出登录" msg:@"" buttonsStatement:@[@"取消", @"确认"] chooseBlock:^(NSInteger buttonIdx) {
            if(buttonIdx == 1)
            {
                [SVProgressHUD showSuccessWithStatus:@"退成登录成功"];
                [SVProgressHUD dismissWithDelay:1.2 completion:^{
                    [self gotoLoginVC];
                }];
            }
        }];
        
        
    }
    
    [self gotoLoginVC];
}

//前往登录界面
- (void)gotoLoginVC
{
    //退出登录
    [NJLoginTool doLoginOut];
    
    NJLoginVC * loginVC = [[NJLoginVC alloc] init];
    [self.navigationController pushViewController:loginVC animated:YES];
}

- (void)methodClick:(NSInteger)index
{
    if(![NJLoginTool isLogin])
    {
        NJLoginVC * loginVC = [[NJLoginVC alloc] init];
        [self.navigationController pushViewController:loginVC animated:YES];
        return;
    }
    
    switch (index) {
        case 0://初次登录免费获得
        {
            [self getAward];
        }
            break;
        case 1://邀请朋友获得2级奖励
        {
            NJInviteFriendVC * inviteFriendVC = [[NJInviteFriendVC alloc] init];
            [self.navigationController pushViewController:inviteFriendVC animated:YES];
        }
            break;
        case 2://绑定朋友邀请码获得
        {
            NJBindInviteCodeVC * bindInviteCodeVC = [[NJBindInviteCodeVC alloc] init];
            [self.navigationController pushViewController:bindInviteCodeVC animated:YES];
        }
            break;
        case 3://提交微信群或者QQ群获得
        {
            
        }
            break;
            
        default:
            break;
    }
}

- (void)getAward
{
    NJUserItem * userItem = [NJLoginTool getCurrentUser];
    if(userItem.is_first_login_get.integerValue> 0)
    {
        [SVProgressHUD showInfoWithStatus:@"已经领取过"];
        [SVProgressHUD dismissWithDelay:1.5];
        return;
    }
    
    [self firstLoginRewardRequest];
}


#pragma mark - 懒加载
- (NSArray *)dataArr
{
    if(_dataArr == nil)
    {
        _dataArr = @[
                     @{
                         @"icon" : @"1_Lqc",
                         @"title" : @"夺宝iPhoneX"
                         },
                     @{
                         @"icon" : @"2_Lqc",
                         @"title" : @"手机充值"
                         },
                     @{
                         @"icon" : @"3_Lqc",
                         @"title" : @"交易出售"
                         },
                     @{
                         @"icon" : @"4_Lqc",
                         @"title" : @"在线购物"
                         },
                     @{
                         @"icon" : @"5_Lqc",
                         @"title" : @"线下消费"
                         },
                     @{
                         @"icon" : @"6_Lqc",
                         @"title" : @"投放广告"
                         },
                     ];
    }
    return _dataArr;
}


#pragma mark - 其他
- (void)receiveBtnClick
{
    if(![NJLoginTool isLogin])
    {
        NJLoginVC * loginVC = [[NJLoginVC alloc] init];
        [self.navigationController pushViewController:loginVC animated:YES];
        return;
    }
    
    [self getMyAwardRequest];
    
}
@end
