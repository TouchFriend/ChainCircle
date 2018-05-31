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

@interface NJLqcVC () <UICollectionViewDataSource, UICollectionViewDelegate>
/********* <#注释#> *********/
@property(nonatomic,weak)UICollectionView * collectionView;
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
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:NJOrangeColor] forBarMetrics:UIBarMetricsDefault];
    
}


- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forBarMetrics:UIBarMetricsDefault];
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
}

#pragma mark - UICollectionViewDataSource方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 6;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NJLqcCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    return cell;
}

#pragma mark - UICollectionViewDelegate方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if(kind == UICollectionElementKindSectionHeader)
    {
        NJLqcHeaderView * headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerID forIndexPath:indexPath];
        return headerView;
    }
    else
    {
        NJLqcFooterView * footerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:footerID forIndexPath:indexPath];
        return footerView;
    }
}

#pragma mark - 事件
- (void)personBtnClick
{
    
}
@end
