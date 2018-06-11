//
//  NJInviteFriendVC.m
//  ChainCircle
//
//  Created by TouchWorld on 2018/5/31.
//  Copyright © 2018年 Redirect. All rights reserved.
//

#import "NJInviteFriendVC.h"
#import "UIImage+NJImage.h"
#import "NJInviteRecordCell.h"
#import "NJInviteRecordHeaderView.h"
#import "NJInviteFriendTableHeaderView.h"
#import "NJInviteCodeVC.h"
#import "NJUserItem.h"
#import "NJInviteCodeListVC.h"
#import "NJInviteRecordFooterView.h"
#import "NJRecordItem.h"
#import <MJExtension.h>
#import "NJSettingItem.h"

@interface NJInviteFriendVC () <UITableViewDataSource, UITableViewDelegate>
/********* <#注释#> *********/
@property(nonatomic,weak)UITableView * tableView;
/********* <#注释#> *********/
@property(nonatomic,strong)UIView * tableHeaderView;

/********* <#注释#> *********/
@property(nonatomic,strong)NSArray<NJRecordItem *> * recordArr;

/********* <#注释#> *********/
@property(nonatomic,strong)NSArray<NJSettingItem *> * settingArr;

@end

@implementation NJInviteFriendVC
static NSString * const ID = @"NJInviteRecordCell";
static NSString * const headerID = @"NJInviteRecordHeaderView";
static NSString * const footerID = @"NJInviteRecordFooterView";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupInit];
}

#pragma mark - 设置初始化
- (void)setupInit
{
    UIImageView * bgImageV = [[UIImageView alloc] init];
    [self.view addSubview:bgImageV];
    [bgImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    bgImageV.image = [UIImage imageNamed:@"bg_inviteFriend"];
    
    [self setupNaviBar];
    
    
    [self setupTableView];
    
    [self getInviteRecordListRequest];
    
    [self getSettingRequest];
}

#pragma mark - 导航条
- (void)setupNaviBar
{
    self.title = @"邀请朋友";
    
    UIBarButtonItem * shareItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageOriginNamed:@"share_inviteFriend"] style:UIBarButtonItemStylePlain target:self action:@selector(shareItemClick)];
    
    self.navigationItem.rightBarButtonItems = @[shareItem];
}

#pragma mark - tableView
- (void)setupTableView
{
    UITableView * tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    [self.view addSubview:tableView];
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.mas_equalTo(self.view).mas_equalTo(UIEdgeInsetsMake(0, 15, 0, 15));
        make.edges.mas_equalTo(self.view);
    }];
    
    self.tableView = tableView;
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.rowHeight = 31;
    tableView.backgroundColor = [UIColor clearColor];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    tableView.contentInset = UIEdgeInsetsMake(30, 0, 0, 0);
    tableView.tableHeaderView = self.tableHeaderView;
    
    [tableView registerNib:[UINib nibWithNibName:NSStringFromClass([NJInviteRecordCell class]) bundle:nil] forCellReuseIdentifier:ID];
    
    [tableView registerNib:[UINib nibWithNibName:NSStringFromClass([NJInviteRecordHeaderView class]) bundle:nil] forHeaderFooterViewReuseIdentifier:headerID];
    [tableView registerClass:[NJInviteRecordFooterView class] forHeaderFooterViewReuseIdentifier:footerID];
}

#pragma mark - 网络请求
- (void)getInviteRecordListRequest
{
    [SVProgressHUD show];
    [NetRequest getInviteInfoWithCompleted:^(id data, int flag) {
        [SVProgressHUD dismiss];
        if(flag == GetInviteInfo)
        {
            if(getIntInDict(data, DictionaryKeyCode) == ResultTypeSuccess)
            {
                NSDictionary * dataDic = getDictionaryInDict(data, DictionaryKeyData);
                NSArray * dataArr = getArrayInDict(dataDic, @"list");
                self.recordArr = [NJRecordItem mj_objectArrayWithKeyValuesArray:dataArr];
                [self.tableView reloadData];
            }
            else
            {
                
                [SVProgressHUD showErrorWithStatus:getStringInDict(data, DictionaryKeyData)];
                [SVProgressHUD dismissWithDelay:1.5];
            }
        }
    }];
}

//获取配置
- (void)getSettingRequest
{
    [NetRequest getSettingWithCompleted:^(id data, int flag) {
        if(flag == GetSetting)
        {
            if(getIntInDict(data, DictionaryKeyCode) == ResultTypeSuccess)
            {
                NSArray * dataArr = getArrayInDict(data, DictionaryKeyData);
                self.settingArr = [NJSettingItem mj_objectArrayWithKeyValuesArray:dataArr];
                [self.tableView reloadData];
            }
            else
            {
                
                [SVProgressHUD showErrorWithStatus:getStringInDict(data, DictionaryKeyData)];
                [SVProgressHUD dismissWithDelay:1.5];
            }
        }
    }];
}

#pragma mark - UITableViewDataSource方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.recordArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NJInviteRecordCell * cell = [tableView dequeueReusableCellWithIdentifier:ID forIndexPath:indexPath];
    
    NJRecordItem * item = self.recordArr[indexPath.row];
    cell.item = item;
    return cell;
}

#pragma mark - UITableViewDelegate方法

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    NJInviteRecordHeaderView * headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerID];
    headerView.invitedNum = self.recordArr.count;
    headerView.settingArr = self.settingArr;
    NJWeakSelf;
    headerView.myInviteBlock = ^{
        [weakSelf myInviteBtnClick];
    };
    return headerView;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
//    UIView * footerView = [[UIView alloc] initWithFrame:CGRectMake(15, 0, NJScreenW, 71)];
////    [footerView addAllCornerRadius:8.0];
//    footerView.backgroundColor = [UIColor clearColor];
//
//    CAShapeLayer * circleCornerLayer = [CAShapeLayer layer];
//
//    UIBezierPath * path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, NJScreenW - 30, 38) byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(8.0, 8.0)];
//
//    circleCornerLayer.path = path.CGPath;
//
//    circleCornerLayer.fillColor = [UIColor whiteColor].CGColor;
//    [footerView.layer addSublayer:circleCornerLayer];
    NJInviteRecordFooterView * footerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:footerID];
    
    return footerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 191.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 71.0;
}

#pragma mark - 事件
- (void)shareItemClick
{
    NJUserItem * userItem = [NJLoginTool getCurrentUser];
    NSString * url = [@"http://lianquan.chongdx.com/wap/share.html?id=" stringByAppendingString:userItem.ID];

    [self socialShareWithContent:@"加入LQC" images:@[@"side"] url:url title:@"加入LQC"];
}

- (void)myInviteBtnClick
{
//    NJInviteCodeVC * inviteCodeVC = [[NJInviteCodeVC alloc] init];
//    [self.navigationController pushViewController:inviteCodeVC animated:YES];
    NJInviteCodeListVC * inviteCodeListVC = [[NJInviteCodeListVC alloc] init];
    [self.navigationController pushViewController:inviteCodeListVC animated:YES];
    
}

#pragma mark - 懒加载
- (UIView *)tableHeaderView
{
    if(_tableHeaderView == nil)
    {
        _tableHeaderView = [[UIView alloc] init];
        _tableHeaderView.frame = CGRectMake(0, 0, NJScreenW - 30, 30);
        _tableView.backgroundColor = [UIColor clearColor];
    }
    return _tableHeaderView;
}

- (NSArray<NJRecordItem *> *)recordArr
{
    if(_recordArr == nil)
    {
        _recordArr = [NSArray array];
    }
    return _recordArr;
}

- (NSArray<NJSettingItem *> *)settingArr
{
    if(_settingArr == nil)
    {
        _settingArr = [NSArray array];
    }
    return _settingArr;
}
@end
