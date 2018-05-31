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

/********* 账号 (手机号) *********/
@property(nonatomic,copy)NSString * account;

/********* 姓名 *********/
@property(nonatomic,copy)NSString * name;

/********* 密码 *********/
@property(nonatomic,copy)NSString * password;

/********* lqc币 *********/
@property(nonatomic,copy)NSString * lqc_num;

/********* 用户邀请码 *********/
@property(nonatomic,copy)NSString * invite_code;

/********* 用户红包数量 *********/
@property(nonatomic,strong)NSNumber * red_num;

/********* 是否首次登录 大于0 表示已经领取了初次登录奖励 0 表示未领取 *********/
@property(nonatomic,strong)NSNumber * is_first_login_get;

/********* <#注释#> *********/
@property(nonatomic,strong)NSNumber * today_get;

/********* 可领取数量 *********/
@property(nonatomic,strong)NSNumber * total_get;

/********* <#注释#> *********/
@property(nonatomic,copy)NSString * father_code;

/********* <#注释#> *********/
@property(nonatomic,copy)NSString * child_code;



/********* 头像 *********/
@property(nonatomic,copy)NSString * picture;
//
///********* 电话 *********/
//@property(nonatomic,copy)NSString * mobile;
//

//
///********* 邮箱 *********/
//@property(nonatomic,copy)NSString * email;

/********* 创建账号时间 *********/
@property(nonatomic,copy)NSString * created_at;

/********* 上次登录时间 *********/
@property(nonatomic,copy)NSString * updated_at;

/********* token *********/
@property(nonatomic,copy)NSString * remember_token;

/********* token时间 *********/
@property(nonatomic,copy)NSString * token_time;



///********* 授权类型 *********/
//@property(nonatomic,copy)NSString * authtype;
//
///********* 性别 *********/
//@property(nonatomic,strong)NSNumber * sex;
//
///********* 定位 *********/
//@property(nonatomic,copy)NSString * location;




@end
