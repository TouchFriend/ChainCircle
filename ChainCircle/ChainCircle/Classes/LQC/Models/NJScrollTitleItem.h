//
//  NJScrollTitleItem.h
//  ChainCircle
//
//  Created by TouchWorld on 2018/6/1.
//  Copyright © 2018年 Redirect. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NJScrollTitleItem : NSObject
/********* id *********/
@property(nonatomic,strong)NSNumber * ID;

/********* 排序 *********/
@property(nonatomic,strong)NSNumber * sort;

/********* 文字 *********/
@property(nonatomic,copy)NSString * title;

/********* 内容 *********/
@property(nonatomic,copy)NSString * content;

/********* 简介 *********/
@property(nonatomic,copy)NSString * intro;

@end
