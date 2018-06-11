//
//  NJRecordItem.h
//  ChainCircle
//
//  Created by TouchWorld on 2018/6/11.
//  Copyright © 2018年 Redirect. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NJRecordItem : NSObject
/********* 时间 *********/
@property(nonatomic,copy)NSString * created_at;

/********* 受邀请人 *********/
@property(nonatomic,copy)NSString * account;

/********* 内容 *********/
@property(nonatomic,copy)NSString * content;

/********* LQC *********/
@property(nonatomic,copy)NSString * lqc_num;

@end
