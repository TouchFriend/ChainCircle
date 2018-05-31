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

@interface NJLqcFooterView () <UITableViewDataSource, UITableViewDelegate>
/********* <#注释#> *********/
@property(nonatomic,weak)UITableView * tableView;

/********* <#注释#> *********/
@property(nonatomic,strong)NSArray<NSString *> * dataArr;

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
    NSString * titleStr = self.dataArr[indexPath.row];
    cell.titleStr = titleStr;
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
- (NSArray<NSString *> *)dataArr
{
    if(_dataArr == nil)
    {
        _dataArr = @[
                     @"初次登录免费获得",
                     @"邀请朋友获得2级奖励",
                     @"绑定朋友邀请码获得",
                     @"提交微信群或者QQ群获得"
                     ];
    }
    return _dataArr;
}
@end
