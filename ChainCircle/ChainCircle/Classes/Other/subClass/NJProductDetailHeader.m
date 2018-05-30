//
//  NJProductDetailHeader.m
//  ConsumptionPlus
//
//  Created by TouchWorld on 2017/12/9.
//  Copyright © 2017年 qichen. All rights reserved.
//

#import "NJProductDetailHeader.h"
@interface NJProductDetailHeader ()
@property (weak, nonatomic) UILabel *label;
@end
@implementation NJProductDetailHeader

- (void)prepare
{
    [super prepare];
    
    // 设置控件的高度
    self.mj_h = 50;
    
    // 添加label
    UILabel *label = [[UILabel alloc] init];
    label.textColor = NJGrayColor(150);
    label.font = [UIFont boldSystemFontOfSize:15];
    label.textAlignment = NSTextAlignmentCenter;
    [self addSubview:label];
    self.label = label;

}
#pragma mark 在这里设置子控件的位置和尺寸
- (void)placeSubviews
{
    [super placeSubviews];
    
    self.label.frame = self.bounds;
}
#pragma mark 监听scrollView的contentOffset改变
- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change
{
    [super scrollViewContentOffsetDidChange:change];
    
}

#pragma mark 监听scrollView的contentSize改变
- (void)scrollViewContentSizeDidChange:(NSDictionary *)change
{
    [super scrollViewContentSizeDidChange:change];
    
}

#pragma mark 监听scrollView的拖拽状态改变
- (void)scrollViewPanStateDidChange:(NSDictionary *)change
{
    [super scrollViewPanStateDidChange:change];
    
}
#pragma mark 监听控件的刷新状态
- (void)setState:(MJRefreshState)state
{
    MJRefreshCheckState;
    
    switch (state) {
        case MJRefreshStateIdle:
            self.label.text = @"下拉回到“商品详情”";
            break;
        case MJRefreshStatePulling:
            self.label.text = @"释放回到“商品详情”";
            break;
        case MJRefreshStateRefreshing:
            self.label.text = @"正在回到“商品详情”";
            break;
        default:
            break;
    }
}
#pragma mark 监听拖拽比例（控件被拖出来的比例）
- (void)setPullingPercent:(CGFloat)pullingPercent
{
    [super setPullingPercent:pullingPercent];
    
}
@end
