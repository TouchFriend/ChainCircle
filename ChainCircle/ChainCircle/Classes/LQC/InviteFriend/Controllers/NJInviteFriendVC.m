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

@interface NJInviteFriendVC () <UITableViewDataSource, UITableViewDelegate>
/********* <#注释#> *********/
@property(nonatomic,weak)UITableView * tableView;
/********* <#注释#> *********/
@property(nonatomic,strong)NJInviteFriendTableHeaderView * tableHeaderView;

@end

@implementation NJInviteFriendVC
static NSString * const ID = @"NJInviteRecordCell";
static NSString * const headerID = @"NJInviteRecordHeaderView";

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
        make.edges.mas_equalTo(self.view).mas_equalTo(UIEdgeInsetsMake(0, 15, 0, 15));
    }];
    
    self.tableView = tableView;
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.rowHeight = 31;
    tableView.backgroundColor = [UIColor clearColor];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.tableHeaderView = self.tableHeaderView;
    
    
    [tableView registerNib:[UINib nibWithNibName:NSStringFromClass([NJInviteRecordCell class]) bundle:nil] forCellReuseIdentifier:ID];
    
    [tableView registerNib:[UINib nibWithNibName:NSStringFromClass([NJInviteRecordHeaderView class]) bundle:nil] forHeaderFooterViewReuseIdentifier:headerID];
}

#pragma mark - UITableViewDataSource方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NJInviteRecordCell * cell = [tableView dequeueReusableCellWithIdentifier:ID forIndexPath:indexPath];
    return cell;
}

#pragma mark - UITableViewDelegate方法

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    NJInviteRecordHeaderView * headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerID];
    return headerView;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView * footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, NJScreenW, 71)];
//    [footerView addAllCornerRadius:8.0];
    footerView.backgroundColor = [UIColor clearColor];
    
    CAShapeLayer * circleCornerLayer = [CAShapeLayer layer];
    
    UIBezierPath * path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, NJScreenW - 30, 38) byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(8.0, 8.0)];
    
    circleCornerLayer.path = path.CGPath;
    
    circleCornerLayer.fillColor = [UIColor whiteColor].CGColor;
    [footerView.layer addSublayer:circleCornerLayer];
    
    return footerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 130.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 71.0;
}

#pragma mark - 事件
- (void)shareItemClick
{
    
}

#pragma mark - 懒加载
- (NJInviteFriendTableHeaderView *)tableHeaderView
{
    if(_tableHeaderView == nil)
    {
        _tableHeaderView = [NJInviteFriendTableHeaderView NJ_loadViewFromXib];
        _tableHeaderView.frame = CGRectMake(0, 0, NJScreenW - 30, 563);
    }
    return _tableHeaderView;
}

@end
