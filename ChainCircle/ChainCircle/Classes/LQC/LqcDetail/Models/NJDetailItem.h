//
//  NJDetailItem.h
//  ChainCircle
//
//  Created by TouchWorld on 2018/6/5.
//  Copyright © 2018年 Redirect. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NJDetailItem : NSObject
/********* 内容 *********/
@property(nonatomic,copy)NSString * content;

/********* 数量 *********/
@property(nonatomic,copy)NSString * lqc_num;

/********* 日期 *********/
@property(nonatomic,copy)NSString * created_at;

/********* 类型 0:收入 1:支出 *********/
@property(nonatomic,strong)NSNumber * type;


@end
