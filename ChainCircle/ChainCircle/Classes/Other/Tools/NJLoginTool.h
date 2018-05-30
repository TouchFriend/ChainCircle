//
//  NJLogin.h
//  ConsumptionPlus
//
//  Created by TouchWorld on 2017/11/2.
//  Copyright © 2017年 qichen. All rights reserved.
//

#import <Foundation/Foundation.h>
@class NJUserItem;

@interface NJLoginTool : NSObject

/**
 用户是否登录

 @return 是，否
 */
+ (BOOL)isLogin;

/**
 登录所需操作

 @param item 用户数据
 */
+ (void)doLoginWithItem:(NJUserItem *)item;

//退出登录所需操作
+ (void)doLoginOut;

//获取当前用户
+ (NJUserItem *)getCurrentUser;

//设置当前用户
+ (void)setCurrentUser:(NJUserItem *)item;

//获取当前用户ID
+ (NSString *)getUserID;

//获取当前用户token
+ (NSString *)getUserToken;

@end
