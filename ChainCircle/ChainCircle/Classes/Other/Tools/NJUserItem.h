//
//  NJUserItem.h
//  ConsumptionPlus
//
//  Created by TouchWorld on 2017/11/4.
//  Copyright © 2017年 qichen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NJUserItem : NSObject <NSCoding>

/********* 用户ID *********/
@property(nonatomic,copy)NSString * ID;

/********* 账号 *********/
@property(nonatomic,copy)NSString * account;

/********* 密码 *********/
@property(nonatomic,copy)NSString * password;

/********* 头像 *********/
@property(nonatomic,copy)NSString * picture;

/********* 电话 *********/
@property(nonatomic,copy)NSString * mobile;

/********* 姓名 *********/
@property(nonatomic,copy)NSString * name;

/********* 邮箱 *********/
@property(nonatomic,copy)NSString * email;

/********* 创建账号时间 *********/
@property(nonatomic,copy)NSString * created_at;

/********* 上次登录时间 *********/
@property(nonatomic,copy)NSString * updated_at;

/********* token *********/
@property(nonatomic,copy)NSString * remember_token;

/********* token时间 *********/
@property(nonatomic,copy)NSString * token_time;



/********* 授权类型 *********/
@property(nonatomic,copy)NSString * authtype;

/********* 性别 *********/
@property(nonatomic,strong)NSNumber * sex;

/********* 定位 *********/
@property(nonatomic,copy)NSString * location;




@end
