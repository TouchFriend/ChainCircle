//
//  NJSettingItem.h
//  ChainCircle
//
//  Created by TouchWorld on 2018/6/11.
//  Copyright © 2018年 Redirect. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NJSettingItem : NSObject
/********* id *********/
@property(nonatomic,copy)NSNumber * ID;

/********* 名字 *********/
@property(nonatomic,copy)NSString * name;

/********* 数值 *********/
@property(nonatomic,copy)NSString * value;

/********* 描述 *********/
@property(nonatomic,copy)NSString * desc;


@end
