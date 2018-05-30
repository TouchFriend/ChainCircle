//
//  NJPwdTextField.m
//  ConsumptionPlus
//
//  Created by TouchWorld on 2017/10/30.
//  Copyright © 2017年 qichen. All rights reserved.
//

#import "NJPwdTextField.h"

@implementation NJPwdTextField



//更改占位符起始文字
- (CGRect)placeholderRectForBounds:(CGRect)bounds
{
    bounds.origin.x += 16;
    return bounds;
}
//编辑文本显示的位置
- (CGRect)editingRectForBounds:(CGRect)bounds
{
    bounds.origin.x += 16;
    return bounds;
}
//显示文本的位置
- (CGRect)textRectForBounds:(CGRect)bounds
{
    bounds.origin.x += 16;
    return bounds;
}

@end
