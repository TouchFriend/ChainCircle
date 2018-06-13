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
- (IBAction)postBtnClick;
@property (weak, nonatomic) IBOutlet UIView *titleView;
/********* <#注释#> *********/
@property(nonatomic,weak)UILabel * titleLabel;

/********* <#注释#> *********/
@property(nonatomic,assign)CGFloat textLength;

@end
@implementation NJLqcHeaderView

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self.receiveBtn addAllCornerRadius:4.0];
    
    [self setPersonalInfo];
    
    [self setupScrollTitleView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginSuccess) name:NotificationLoginSuccess object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginSuccess) name:NotificationUserLogout object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(fatherViewWillAppear) name:@"NotificationViewWillAppear" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(fatherViewWillAppear) name:UIApplicationWillEnterForegroundNotification object:nil];
    
    [self addTitleLabel];
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

- (void)addTitleLabel
{
    UILabel * titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, NJScreenW, 40)];
    self.titleLabel = titleLabel;
    titleLabel.font = [UIFont systemFontOfSize:12.0];
    titleLabel.textColor = NJGrayColor(106);
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = @"LQC用途：LQC可用于【C2C交易】出售变现，【自助推广】投放百万微信群广告";
    
    [self.titleView addSubview:titleLabel];
    
    CGSize userInfoSize = [titleLabel.text sizeWithAttributes:@{
                                                         NSFontAttributeName : [UIFont systemFontOfSize:15.0],
                                                         }];
    
    self.textLength = userInfoSize.width;
    
    CGRect titleLabelFrame = self.titleLabel.frame;
    titleLabelFrame.size.width = userInfoSize.width;
    self.titleLabel.frame = titleLabelFrame;
    
    [self startAnimation];
}

- (void)startAnimation
{
    if(self.textLength > NJScreenW)
    {
        
        CGRect titleLabelFrame = self.titleLabel.frame;
        titleLabelFrame.origin.x = NJScreenW;
        self.titleLabel.frame = titleLabelFrame;
        
        NSTimeInterval duration = self.titleLabel.text.length / 3.0;
        
        [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionCurveLinear | UIViewAnimationOptionRepeat animations:^{
            
            CGRect titleLabelFrame = self.titleLabel.frame;
            titleLabelFrame.origin.x = -self.textLength;
            self.titleLabel.frame = titleLabelFrame;
        } completion:^(BOOL finished) {
            NSLog(@"完成");
        }];
        
    }
}



- (void)setPersonalInfo
{
//    if(![NJLoginTool isLogin])
//    {
//        return;
//    }
    
    NJUserItem * userItem = [NJLoginTool getCurrentUser];
    

    self.myLqcNumLabel.text = userItem != nil ? userItem.lqc_num : @"0";
    
//    self.myRedBagLabel.text = [NSString stringWithFormat:@"我的红包：%@", userItem.red_num.stringValue];
    
//    self.canReceiveNumLabel.text = userItem.total_get.stringValue;
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
    if(self.adBlock != nil)
    {
        self.adBlock(index);
    }
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


- (IBAction)postBtnClick {
    if(self.posterBlock != nil)
    {
        self.posterBlock();
    }
}

- (void)fatherViewWillAppear
{
//    NJLog(@"%s", __func__);
    [self startAnimation];
}

#pragma mark - 其他
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
