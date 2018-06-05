//
//  NJPosterItem.h
//  ChainCircle
//
//  Created by TouchWorld on 2018/6/5.
//  Copyright © 2018年 Redirect. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NJPosterItem : NSObject
/********* id *********/
@property(nonatomic,strong)NSNumber * ID;

/********* 地址 *********/
@property(nonatomic,copy)NSString * image_url;

/********* 宽 *********/
@property(nonatomic,copy)NSString * width;

/********* 高 *********/
@property(nonatomic,copy)NSString * height;

/********* 排序 *********/
@property(nonatomic,strong)NSNumber * sort;

@end
