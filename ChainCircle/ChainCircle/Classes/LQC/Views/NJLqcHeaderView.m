//
//  NJLqcHeaderView.m
//  ChainCircle
//
//  Created by TouchWorld on 2018/5/31.
//  Copyright © 2018年 Redirect. All rights reserved.
//

#import "NJLqcHeaderView.h"
#import "NJUserItem.h"
#import "NJScrollTitleView.h"

@interface NJLqcHeaderView () <NJScrollTitleViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *myLqcNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *myRedBagLabel;


@property (weak, nonatomic) IBOutlet UIButton *receiveBtn;
- (IBAction)receiveBtnClick;
@property (weak, nonatomic) IBOutlet UIView *topView;

/********* <#注释#> *********/
@property(nonatomic,weak)NJScrollTitleView * scrollTitleView;

@end
@implementation NJLqcHeaderView

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self.receiveBtn addAllCornerRadius:4.0];
    
    [self setPersonalInfo];
    
    [self setupScrollTitleView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginSuccess) name:NotificationLoginSuccess object:nil];
    
    
}

- (void)setupScrollTitleView
{
    NJScrollTitleView * scrollTitleView = [NJScrollTitleView scrollTitleViewWithFrame:CGRectMake(14, 0, NJScreenW - 28, 33) delegate:self];
    self.scrollTitleView = scrollTitleView;
    scrollTitleView.textColor = [UIColor whiteColor];
    scrollTitleView.textFont = [UIFont systemFontOfSize:12.0];
    scrollTitleView.textAlignment = NSTextAlignmentCenter;
    
    [self.topView addSubview:scrollTitleView];
}

- (void)setPersonalInfo
{
    if(![NJLoginTool isLogin])
    {
        return;
    }
    
    NJUserItem * userItem = [NJLoginTool getCurrentUser];
    
    self.myLqcNumLabel.text = userItem.lqc_num;
    
    self.myRedBagLabel.text = [NSString stringWithFormat:@"我的红包：%@", userItem.red_num.stringValue];
    
    self.canReceiveNumLabel.text = userItem.total_get.stringValue;
}

- (void)setTitleArr:(NSArray<NSString *> *)titleArr
{
    _titleArr = titleArr;
    
    self.scrollTitleView.titleArr = titleArr;
}

#pragma mark - NJScrollTitleViewDelegate方法
- (void)scrollTitleView:(NJScrollTitleView *)scrollTitleView didSelectItemAtIndex:(NSInteger)index
{
//    NSLog(@"%s--%ld", __func__, index);
}

- (void)scrollTitleView:(NJScrollTitleView *)scrollTitleView didScrollToIndex:(NSInteger)index
{
//    NSLog(@"%s--%ld", __func__, index);
}

#pragma mark - 事件 && 通知
- (IBAction)receiveBtnClick {
    if(self.receiveBlock != nil)
    {
        self.receiveBlock();
    }
}

- (void)loginSuccess
{
    [self setPersonalInfo];
}
- (void)dealloc
{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
