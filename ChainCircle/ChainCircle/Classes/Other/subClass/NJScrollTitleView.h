//
//  ScrollTitleView.h
//  Eighteen_June_One_ScrollTitleTest
//
//  Created by TouchWorld on 2018/6/1.
//  Copyright © 2018年 Redirect. All rights reserved.
//

#import <UIKit/UIKit.h>
@class NJScrollTitleView;
@protocol NJScrollTitleViewDelegate <NSObject>
@optional

- (void)scrollTitleView:(NJScrollTitleView *)scrollTitleView didSelectItemAtIndex:(NSInteger)index;

- (void)scrollTitleView:(NJScrollTitleView *)scrollTitleView didScrollToIndex:(NSInteger)index;

@end

@interface NJScrollTitleView : UIView

+ (instancetype)scrollTitleViewWithFrame:(CGRect)frame delegate:(id<NJScrollTitleViewDelegate>)delegate;

/********* 标题数据 *********/
@property(nonatomic,strong)NSArray<NSString *> * titleArr;

/********* 代理 *********/
@property(nonatomic,weak)id<NJScrollTitleViewDelegate> delegate;

/********* 文字字体大小 默认16 *********/
@property(nonatomic,strong)UIFont * textFont;

/********* 文字颜色 默认黑色 *********/
@property(nonatomic,strong)UIColor * textColor;

/********* 对齐方式 默认居中 *********/
@property(nonatomic,assign)NSTextAlignment textAlignment;


//当前坐标
- (NSInteger)currentIndex;

@end
