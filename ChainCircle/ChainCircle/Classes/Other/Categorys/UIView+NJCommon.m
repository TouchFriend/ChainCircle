//
//  UIView+NJCommon.m
//  ConsumptionPlus
//
//  Created by TouchWorld on 2017/10/13.
//  Copyright © 2017年 qichen. All rights reserved.
//

#import "UIView+NJCommon.h"

@implementation UIView (NJCommon)
#pragma mark - 添加边框
- (void)addBorderWidth:(CGFloat)width color:(UIColor *)color cornerRadius:(CGFloat)cornerRadius
{
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = cornerRadius;
    self.layer.borderWidth = width;
    if(color != nil)
    {
        self.layer.borderColor = color.CGColor;
    }
}

#pragma mark - 虚线边框
- (void)addDottedBorderWithLineWidth:(CGFloat)lineWidth lineColor:(UIColor *)lineColor
{
    CAShapeLayer * border = [CAShapeLayer layer];
    
    border.strokeColor = lineColor.CGColor;
    
    border.fillColor = nil;
    
    border.path = [UIBezierPath bezierPathWithRect:self.bounds].CGPath;
    
    border.frame = self.bounds;
    
    border.lineWidth = lineWidth;
    
    border.lineCap = @"square";
    
    border.lineDashPattern = @[@4, @2];
    
    [self.layer addSublayer:border];
    
}

// 从 XIB 中加载视图
+ (instancetype)NJ_loadViewFromXib {
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil].lastObject;
}

- (void)addCornerRadius:(UIRectCorner)rectCornet size:(CGSize)size
{
    UIBezierPath * maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:rectCornet cornerRadii:size];
    CAShapeLayer * maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
    self.layer.masksToBounds = YES;
}

- (void)addAllCornerRadius:(CGFloat)radius
{
    [self addBorderWidth:0.0 color:nil cornerRadius:radius];
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
@end
