//
//  NJInviteCardCell.m
//  ChainCircle
//
//  Created by TouchWorld on 2018/6/5.
//  Copyright © 2018年 Redirect. All rights reserved.
//

#import "NJInviteCardCell.h"
#import "NJPosterView.h"
#import "NJPosterItem.h"
#import "NJPosterVC.h"

@interface NJInviteCardCell ()
/********* <#注释#> *********/
@property(nonatomic,weak)NJPosterView * posterView;
@end
@implementation NJInviteCardCell
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
    NJPosterView * posterView = [[NJPosterView alloc] init];
    [self.contentView addSubview:posterView];
    
    [posterView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self).mas_offset(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    
    
    self.posterView = posterView;
    posterView.backgroundColor = NJOrangeColor;
    
    UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(posterViewClick)];
    [posterView addGestureRecognizer:tapGesture];
}

- (void)setItem:(NJPosterItem *)item
{
    _item = item;
    self.posterView.item = item;
}

- (void)setInvitedNum:(NSInteger)invitedNum
{
    _invitedNum = invitedNum;
    self.posterView.invitedNum = invitedNum;
}

- (void)posterViewClick
{
    NJPosterVC * posterVC = [[NJPosterVC alloc] init];
    posterVC.item = self.item;
    posterVC.invitedNum = self.invitedNum;
    [[self viewController].navigationController pushViewController:posterVC animated:YES];
}

- (UIViewController *)viewController
{
    //获取当前 view 的 响应对象
    UIResponder *next = [self nextResponder];
    do {
        
        if ([next isKindOfClass:[UIViewController class]]) {
            
            return (UIViewController *)next;
        }
        next = [next nextResponder];
    } while (next != nil);
    return nil;
}

- (UIImage *)getShareImage
{
    return [self.posterView getShareImage];
}
@end
