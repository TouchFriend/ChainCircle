//
//  NJLqcDetailVC.m
//  ChainCircle
//
//  Created by TouchWorld on 2018/6/5.
//  Copyright © 2018年 Redirect. All rights reserved.
//

#import "NJLqcDetailVC.h"
#import <SGPagingView.h>
#import "NJDetailVC.h"

@interface NJLqcDetailVC () <SGPageTitleViewDelegate, SGPageContentViewDelegate>
/********* <#注释#> *********/
@property(nonatomic,weak)SGPageTitleView * titleView;

/********* <#注释#> *********/
@property(nonatomic,weak)SGPageContentView * contentView;
@end

@implementation NJLqcDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupInit];
}

#pragma mark - 设置初始化
- (void)setupInit
{
    self.title = @"LQC明细";
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSArray * titleArr = @[@"收入", @"支出"];
    
    SGPageTitleViewConfigure * titleConfigure = [SGPageTitleViewConfigure pageTitleViewConfigure];
    titleConfigure.bottomSeparatorColor = NJGrayColor(156);
    titleConfigure.titleColor = NJGrayColor(156);
    titleConfigure.titleSelectedColor = NJOrangeColor;
    titleConfigure.indicatorFixedWidth = NJScreenW * 1.0 / titleArr.count;
    titleConfigure.indicatorColor = NJOrangeColor;
    titleConfigure.indicatorStyle = SGIndicatorStyleFixed;
    
    
    SGPageTitleView * titleView = [[SGPageTitleView alloc] initWithFrame:CGRectMake(0, 0, NJScreenW, 44) delegate:self titleNames:titleArr configure:titleConfigure];
    self.titleView = titleView;
    titleView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:titleView];
    
    NJDetailVC * incomeDetailVC = [[NJDetailVC alloc] init];
    incomeDetailVC.typeStr = @"0";
    NJDetailVC * expenseDetailVC = [[NJDetailVC alloc] init];
    expenseDetailVC.typeStr = @"1";
    
    NSArray * childVCs =@[incomeDetailVC, expenseDetailVC];
    
    SGPageContentView * contentView = [[SGPageContentView alloc] initWithFrame:CGRectMake(0, titleView.NJ_height, NJScreenW, NJScreenH - NAVIGATION_BAR_Max_Y - titleView.NJ_height) parentVC:self childVCs:childVCs];
    self.contentView = contentView;
    contentView.delegatePageContentView = self;
    
    [self.view addSubview:contentView];
}


#pragma mark - SGPageTitleViewDelegate方法
- (void)pageTitleView:(SGPageTitleView *)pageTitleView selectedIndex:(NSInteger)selectedIndex
{
    [self.contentView setPageContentViewCurrentIndex:selectedIndex];
}

#pragma mark - SGPageContentViewDelegate方法
- (void)pageContentView:(SGPageContentView *)pageContentView offsetX:(CGFloat)offsetX
{
    
}

- (void)pageContentView:(SGPageContentView *)pageContentView progress:(CGFloat)progress originalIndex:(NSInteger)originalIndex targetIndex:(NSInteger)targetIndex
{
    [self.titleView setPageTitleViewWithProgress:progress originalIndex:originalIndex targetIndex:targetIndex];
}

@end
