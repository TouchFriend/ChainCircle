//
//  NJPosterView.m
//  ChainCircle
//
//  Created by TouchWorld on 2018/6/5.
//  Copyright © 2018年 Redirect. All rights reserved.
//

#import "NJPosterView.h"
#import "NJInviteCardView.h"
#import "NJPosterItem.h"
#import <UIImageView+WebCache.h>
#import "UIImage+NJImage.h"

@interface NJPosterView ()
/********* <#注释#> *********/
@property(nonatomic,weak)UIImageView * posterImageV;

/********* ui *********/
@property(nonatomic,weak)UIScrollView * scrollView;
@end
@implementation NJPosterView


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
    
    UIScrollView * scrollView = [[UIScrollView alloc] init];
    [self addSubview:scrollView];
    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
    scrollView.backgroundColor = [UIColor whiteColor];
    self.scrollView = scrollView;
    
    UIView * contentView = [[UIView alloc] init];
    [scrollView addSubview:contentView];
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(scrollView);
        make.width.mas_equalTo(scrollView);
        
    }];
    
    
    UIImageView * posterImageV = [[UIImageView alloc] init];
    [contentView addSubview:posterImageV];
    posterImageV.image = [UIImage imageNamed:@"side"];
    [posterImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(contentView);
        make.height.mas_equalTo(0);
    }];
    
    self.posterImageV = posterImageV;
    
    NJInviteCardView * inviteCardView = [NJInviteCardView NJ_loadViewFromXib];
    [scrollView addSubview:inviteCardView];
    [inviteCardView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(posterImageV.mas_bottom);
        make.left.right.bottom.mas_equalTo(contentView);
        make.height.mas_equalTo(442);
    }];
    
    
}
- (void)setItem:(NJPosterItem *)item
{
    _item = item;
    
    CGFloat width = item.width.floatValue;
    CGFloat height = item.height.floatValue;
    
    CGFloat realWidth = (NJScreenW - 48);
    CGFloat realHeight = height *((realWidth * 1.0) / width);
    [self.posterImageV updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(realHeight);
    }];
    
    NSString * urlStr = [@"http://lianquan.chongdx.com/uploads" stringByAppendingPathComponent:item.image_url];
    
    [self.posterImageV sd_setImageWithURL:[NSURL URLWithString:urlStr] placeholderImage:[UIImage imageNamed:@"side"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        
    }];
    
    [self layoutIfNeeded];
}

- (UIImage *)getShareImage
{
    
    return [UIImage longPic:self.scrollView];
}



@end
