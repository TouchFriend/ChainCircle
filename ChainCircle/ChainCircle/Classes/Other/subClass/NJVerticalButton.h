//
//  NJVerticalButton.h
//  ConsumptionPlus
//
//  Created by TouchWorld on 2017/10/26.
//  Copyright © 2017年 qichen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NJVerticalButton : UIButton
/********* 图片 *********/
@property(nonatomic,copy)NSString * imageName;
/********* 标题 *********/
@property(nonatomic,copy)NSString * title;
/********* 图片宽度 默认45 *********/
@property(nonatomic,assign)CGFloat imageWidth;
@end
