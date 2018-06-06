//
//  NJLqcFooterView.m
//  ChainCircle
//
//  Created by TouchWorld on 2018/5/31.
//  Copyright © 2018年 Redirect. All rights reserved.
//

#import "NJLqcFooterView.h"
#import "NJMethodCell.h"
#import "NJMethodHeaderView.h"
#import "NJMethodFooterView.h"
#import "NJUserItem.h"

@interface NJLqcFooterView () <UITableViewDataSource, UITableViewDelegate>
/********* <#注释#> *********/
@property(nonatomic,weak)UITableView * tableView;

/********* <#注释#> *********/
@property(nonatomic,strong)NSArray<NSDictionary *> * dataArr;

@end
@implementation NJLqcFooterView
static NSString * const ID = @"NJMethodCell";
static NSString * const headerID = @"NJMethodHeaderView";
static NSString * const footerID = @"NJMethodFooterView";

- (instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        [self setupInit];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(signInSuccess) name:NotificationLoginSuccess object:nil];
    }
    return self;
}

#pragma mark - 设置初始化
- (void)setupInit
{
    UITableView * tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    [self addSubview:tableView];
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
    self.tableView = tableView;
    tableView.backgroundColor = NJBgColor;
    tableView.rowHeight = 44;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.scrollEnabled = NO;
    
    tableView.dataSource = self;
    tableView.delegate = self;
    [tableView registerNib:[UINib nibWithNibName:NSStringFromClass([NJMethodCell class]) bundle:nil] forCellReuseIdentifier:ID];
    [tableView registerNib:[UINib nibWithNibName:NSStringFromClass([NJMethodHeaderView class]) bundle:nil] forHeaderFooterViewReuseIdentifier:headerID];
    [tableView registerNib:[UINib nibWithNibName:NSStringFromClass([NJMethodFooterView class]) bundle:nil] forHeaderFooterViewReuseIdentifier:footerID];
}

#pragma mark - UITableViewDataSource方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NJMethodCell * cell = [tableView dequeueReusableCellWithIdentifier:ID forIndexPath:indexPath];
    NSDictionary * dataDic = self.dataArr[indexPath.row];
    cell.dataDic = dataDic;
    if(self.signInBlock != nil)
    {
        cell.signInBlock = self.signInBlock;
    }
    return cell;
}


#pragma mark - UITableViewDataDelegate方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(self.methodClick != nil)
    {
        self.methodClick(indexPath.row);
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    NJMethodHeaderView * headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerID];
    return headerView;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    NJMethodFooterView * footerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:footerID];
    return footerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 52.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 238;
}

#pragma mark - 懒加载
- (NSArray<NSDictionary *> *)dataArr
{
    if(_dataArr == nil)
    {
        NJUserItem * userItem = [NJLoginTool getCurrentUser];
        NSNumber * siSign = @(0);
        if(userItem != nil)
        {
            siSign = userItem.is_sign;
        }
        _dataArr = @[
                     @{
                         @"title" : @"每日签到获得1-5LQC",
                         @"isBtn" : @(YES),
                         @"isSign" : siSign
                         },
                     @{
                         @"title" : @"邀请朋友获得2级奖励",
                         @"isBtn" : @(NO)
                         },
                     @{
                         @"title" : @"绑定朋友邀请码获得",
                         @"isBtn" : @(NO)
                         },
                     @{
                         @"title" : @"提交微信群或者QQ群获得",
                         @"isBtn" : @(NO)
                         }
                     
                     
                     ];
    }
    return _dataArr;
}


#pragma mark - 事件和通知
- (void)signInSuccess
{
    self.dataArr = nil;
    
    [self.tableView reloadData];
}
#pragma mark - 其他


- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
