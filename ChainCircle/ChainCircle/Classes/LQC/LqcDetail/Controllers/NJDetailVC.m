//
//  NJDetailVC.m
//  ChainCircle
//
//  Created by TouchWorld on 2018/6/5.
//  Copyright © 2018年 Redirect. All rights reserved.
//

#import "NJDetailVC.h"
#import "NJDetailCell.h"
#import "NJDetailItem.h"
#import <MJExtension.h>
#import <MJRefresh.h>

@interface NJDetailVC () <UITableViewDataSource, UITableViewDelegate>
/********* <#注释#> *********/
@property(nonatomic,weak)UITableView * tableView;

/********* <#注释#> *********/
@property(nonatomic,strong)NSArray<NJDetailItem *> * dataArr;

@end

@implementation NJDetailVC
static NSString * const ID = @"NJDetailCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupInit];
}

#pragma mark - 设置初始化
- (void)setupInit
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupTableView];
    
    [self.tableView.mj_header beginRefreshing];
}

#pragma mark - tableView
- (void)setupTableView
{
    UITableView * tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    [self.view addSubview:tableView];
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    
    self.tableView = tableView;
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.rowHeight = 72;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.backgroundColor = NJBgColor;
    
    [tableView registerNib:[UINib nibWithNibName:NSStringFromClass([NJDetailCell class]) bundle:nil] forCellReuseIdentifier:ID];
    
    tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(getIncomeListRequest)];
}

#pragma mark - 网络请求
- (void)getIncomeListRequest
{
//    [SVProgressHUD show];
    self.typeStr = self.typeStr == nil ? @"0" : self.typeStr;
    [NetRequest getIncomeListWithType:self.typeStr completed:^(id data, int flag) {
//        [SVProgressHUD dismiss];
        [self.tableView.mj_header endRefreshing];
        if(flag == GetIncomeList)
        {
            if(getIntInDict(data, DictionaryKeyCode) == ResultTypeSuccess)
            {
                NSArray * dataArr = getArrayInDict(data, DictionaryKeyData);
                self.dataArr = [NJDetailItem mj_objectArrayWithKeyValuesArray:dataArr];
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
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NJDetailCell * cell = [tableView dequeueReusableCellWithIdentifier:ID forIndexPath:indexPath];
    NJDetailItem * item = self.dataArr[indexPath.row];
    cell.item = item;
    return cell;
}

#pragma mark - 懒加载
- (NSArray<NJDetailItem *> *)dataArr
{
    if(_dataArr == nil)
    {
        _dataArr = @[];
    }
    return _dataArr;
}

@end
