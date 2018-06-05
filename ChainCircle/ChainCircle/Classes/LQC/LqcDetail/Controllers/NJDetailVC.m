//
//  NJDetailVC.m
//  ChainCircle
//
//  Created by TouchWorld on 2018/6/5.
//  Copyright © 2018年 Redirect. All rights reserved.
//

#import "NJDetailVC.h"
#import "NJDetailCell.h"

@interface NJDetailVC () <UITableViewDataSource, UITableViewDelegate>
/********* <#注释#> *********/
@property(nonatomic,weak)UITableView * tableView;
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

}

#pragma mark - UITableViewDataSource方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NJDetailCell * cell = [tableView dequeueReusableCellWithIdentifier:ID forIndexPath:indexPath];
    return cell;
}

@end
