//
//  NJInviteCodeListVC.m
//  ChainCircle
//
//  Created by TouchWorld on 2018/6/5.
//  Copyright © 2018年 Redirect. All rights reserved.
//

#import "NJInviteCodeListVC.h"
#import "NJInviteCardCell.h"
#import "NJPosterItem.h"
#import <MJExtension.h>
#import <iCarousel.h>

@interface NJInviteCodeListVC () <UICollectionViewDataSource, UICollectionViewDelegate>
/********* <#注释#> *********/
@property(nonatomic,weak)UIButton * shareBtn;

/********* <#注释#> *********/
@property(nonatomic,strong)NSArray<NJPosterItem *> * posterArr;

/********* <#注释#> *********/
@property(nonatomic,weak)UICollectionView * collectionView;

/********* <#注释#> *********/
@property(nonatomic,strong)iCarousel * carousel;

@end

@implementation NJInviteCodeListVC
static NSString * const ID = @"NJInviteCardCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupInit];
}

#pragma mark - 设置初始化
- (void)setupInit
{
    self.view.backgroundColor = NJOrangeColor;
    [self setupNaviBar];
    
    [self setupBottomBtn];
    
    [self setupCollectionView];
    
    [self getPosterListRequest];
}

#pragma mark - 导航条
- (void)setupNaviBar
{
    self.title = @"选择素材邀请朋友";
    
}

#pragma mark - bottomBtn
- (void)setupBottomBtn
{
    UIButton * shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:shareBtn];
    [shareBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).mas_offset(17);
        make.right.mas_equalTo(self.view).mas_offset(-17);
        make.height.mas_equalTo(42);
        make.bottom.mas_equalTo(self.view).mas_offset(-30);
    }];
    
    self.shareBtn = shareBtn;
    [shareBtn setTitle:@"一键分享这张海报邀请朋友" forState:UIControlStateNormal];
    [shareBtn addBorderWidth:1.0 color:[UIColor whiteColor] cornerRadius:4.0];
    [shareBtn setBackgroundColor:NJOrangeColor];
    [shareBtn addTarget:self action:@selector(shareBtnClick) forControlEvents:UIControlEventTouchUpInside];
    shareBtn.titleLabel.font = [UIFont systemFontOfSize:17.0];
    
}

#pragma mark - collectionView
- (void)setupCollectionView
{
    UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake(NJScreenW, NJScreenH - 112 - NAVIGATION_BAR_Max_Y);
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flowLayout.minimumLineSpacing = 0;
    flowLayout.minimumInteritemSpacing = 0;
    
    
    UICollectionView * collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    [self.view addSubview:collectionView];
    [collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).mas_offset(10);
        make.left.right.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.shareBtn.mas_top).mas_offset(-30);
    }];
    
    self.collectionView = collectionView;
    collectionView.backgroundColor = [UIColor clearColor];
    collectionView.dataSource = self;
    collectionView.delegate = self;
    collectionView.pagingEnabled = YES;
    collectionView.showsVerticalScrollIndicator = NO;
    collectionView.showsHorizontalScrollIndicator = NO;
    
    [collectionView registerClass:[NJInviteCardCell class] forCellWithReuseIdentifier:ID];
}

#pragma mark - 网络请求
- (void)getPosterListRequest
{
    [SVProgressHUD show];
    [NetRequest getPosterWithCompleted:^(id data, int flag) {
        [SVProgressHUD dismiss];
        if(flag == GetPoster)
        {
            if(getIntInDict(data, DictionaryKeyCode) == ResultTypeSuccess)
            {
                NSArray * dataArr = getArrayInDict(data, DictionaryKeyData);
                self.posterArr = [NJPosterItem mj_objectArrayWithKeyValuesArray:dataArr];
                [self.collectionView reloadData];
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
    return self.posterArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NJInviteCardCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    NJPosterItem * item = self.posterArr[indexPath.row];
    cell.item = item;
    return cell;
}

#pragma mark - 事件
- (void)shareBtnClick
{
    NJInviteCardCell * cell = (NJInviteCardCell *)[self.collectionView visibleCells].lastObject;
    UIImage * shareImage = [cell getShareImage];
    
    [self socialShareWithContent:@"加入LQC" images:@[shareImage] url:nil title:@"加入LQC"];
}

#pragma mark - 懒加载
- (NSArray<NJPosterItem *> *)posterArr
{
    if(_posterArr == nil)
    {
        _posterArr = @[];
    }
    return _posterArr;
}

- (iCarousel *)carousel
{
    if(_carousel == nil)
    {
        _carousel = [[iCarousel alloc] init];
    }
    return _carousel;
}
@end
