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
#import "NJCollectionViewFlowLayout.h"

@interface NJInviteCodeListVC () <UICollectionViewDataSource, UICollectionViewDelegate>
/********* <#注释#> *********/
@property(nonatomic,weak)UIButton * shareBtn;

/********* <#注释#> *********/
@property(nonatomic,strong)NSArray<NJPosterItem *> * posterArr;

/********* <#注释#> *********/
@property(nonatomic,weak)UICollectionView * collectionView;

/********* <#注释#> *********/
@property(nonatomic,strong)UIImage * shareImage;

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
    
    NJWeakSelf;
    self.customItemBlock = ^(NSInteger index) {
        [weakSelf customItemBtnClick:index];
    };
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
    NJCollectionViewFlowLayout * flowLayout = [[NJCollectionViewFlowLayout alloc] init];
    
    CGFloat margin = NJScreenW == 320 ? 30 : 48;
    
    flowLayout.itemSize = CGSizeMake(NJScreenW - 2 * margin, NJScreenH - 112 - NAVIGATION_BAR_Max_Y);
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flowLayout.minimumLineSpacing = 0;
    flowLayout.minimumInteritemSpacing = 0;
    
    //设置左右内边距
    NSInteger insetW = (NJScreenW - flowLayout.itemSize.width ) / 2.0;
    flowLayout.sectionInset = UIEdgeInsetsMake(0, insetW, 0, insetW);
    
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
//                NSMutableArray * arrM = [NSMutableArray array];
//                for (NSInteger i = 0; i < 6; i++) {
//                    [arrM addObject:self.posterArr.firstObject];
//                }
//                self.posterArr = [NSArray arrayWithArray:arrM];
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

#pragma mark - UICollectionViewDelegate方法


#pragma mark - 事件
- (void)shareBtnClick
{
    if(self.posterArr.count == 0)
    {
        [SVProgressHUD showInfoWithStatus:@"没有可分享的海报"];
        [SVProgressHUD dismissWithDelay:1.2];
        return;
    }
    if([self.collectionView isDecelerating])
    {
        return;
    }
    
    
    NSArray<UICollectionViewCell *> * cellArr = [self.collectionView visibleCells];
    NSInteger currentIndex = [self currentIndex];
    __block UIImage * shareImage = nil;
    [cellArr enumerateObjectsUsingBlock:^(UICollectionViewCell * _Nonnull cell, NSUInteger idx, BOOL * _Nonnull stop) {
        NSIndexPath * indexPath = [self.collectionView indexPathForCell:cell];
        if(indexPath.row == currentIndex)
        {
            NJInviteCardCell * cardCell = (NJInviteCardCell *)cell;
            shareImage = [cardCell getShareImage];
            BOOL isStop = YES;
            stop = &isStop;
        }
    }];
    
//    UIImage * shareImage = [cell getShareImage];
    if(shareImage == nil)
    {
        return;
    }
    
    self.shareImage = shareImage;
    
    [self socialShareLocalSaveWithContent:@"加入LQC" images:@[shareImage] url:nil title:@"加入LQC"];
}

- (NSInteger)currentIndex
{
    NSInteger margin = NJScreenW == 320 ? 30 : 48;
    CGFloat itemWidth = NJScreenW - 2 * margin;
    NSInteger currentIndex = self.collectionView.contentOffset.x / itemWidth;
    return currentIndex;
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


- (void)customItemBtnClick:(NSInteger)index
{
    NJLog(@"%ld", index);
    switch (index) {
        case 0://保存到本地
        {
            if(self.shareImage == nil)
            {
                return;
            }
            
            [SVProgressHUD show];
            UIImageWriteToSavedPhotosAlbum(self.shareImage, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
        }
            break;
        case 1://更多
        {
            if(self.shareImage == nil)
            {
                return;
            }
            NSString * info = @"加入LQC";
            
            NSArray * items = @[info, self.shareImage];
            
            UIActivityViewController * activityVC = [[UIActivityViewController alloc] initWithActivityItems:items applicationActivities:nil];
            [self presentViewController:activityVC animated:YES completion:nil];
        }
            break;
            
        default:
            break;
    }
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error
  contextInfo:(void *)contextInfo
{
    
    if(error == nil)
    {
        [SVProgressHUD showSuccessWithStatus:@"保存成功"];
        [SVProgressHUD dismissWithDelay:1.2];
        NSLog(@"保存成功");
    }
    else
    {
        [SVProgressHUD showErrorWithStatus:@"保存失败"];
        [SVProgressHUD dismissWithDelay:1.2];
        NSLog(@"%@",error.localizedDescription);
    }
    
    
}

@end
