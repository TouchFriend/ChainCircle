//
//  NetRequest.h
//  ConsumptionPlus
//
//  Created by TouchWorld on 2017/10/26.
//  Copyright © 2017年 qichen. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^completedBlock)(id data, int flag);

//返回数据result的类型
typedef NS_ENUM(NSUInteger, ResultType) {
    ResultTypeSuccess = 0,//成功
    ResultTypeLoginError = 300,//需要重新登录
    ResultTypeParameterError = 400,//参数错误
    ResultTypeError = 500,//自定义错误
    ResultTypeRegiestError = 501,//账号已存在
    ResultTypeParentCodeError = 301,//未设置父母密码
    ResultTypeConnectFail = 127382,//网络连接失败，客户端自己写的
};

typedef enum : NSUInteger {
    RequestError,//请求出错
    LoginResult,//登录
    ChangePwd,//更改密码
    VersionUpdate,//版本升级
    GetVeriCode,//获取验证码
    UserLogin,//用户登录
    PwdLogin,//密码登录
    GetScrollTitle,//滚动标题
    GetInviteInfo,//获取邀请信息
    BindeFriendCode,//绑定朋友邀请码
    GetFirstLoginAward,//获取初次登录奖励
    GetMyAward,//获取可领取奖励
    GetMyAwardNum,//获取可领取奖励LQC数量
    SignIn,//签到
    GetPoster, //获取海报
    GetIncomeList, //收支明细
    GetSetting, //获取配置

} NetRequest_enum;

@interface NetRequest : NSObject


/**
 版本升级

 @param oldver 旧的版本
 @param completed 回调
 */
+ (void)versionUpdateWithOldver:(NSString *)oldver completed:(completedBlock)completed;


#pragma mark - 我的


/**
 验证码

 @param mobile 手机号
 @param completed 回调
 */
+ (void)getVeriCodeWithMobile:(NSString *)mobile completed:(completedBlock)completed;


/**
 登录

 @param account 手机号
 @param code 验证码
 @param completed 回调
 */
+ (void)userLoginWithAccount:(NSString *)account code:(NSString *)code completed:(completedBlock)completed;

#pragma mark - Lqc

/**
 滚动标题

 @param completed 回调
 */
+ (void)getScrollTitleDataWithCompleted:(completedBlock)completed;


/**
 获取邀请信息

 @param completed 回调
 */
+ (void)getInviteInfoWithCompleted:(completedBlock)completed;


/**
 绑定朋友邀请码

 @param invite_code 邀请码
 @param completed 回调
 */
+ (void)bindFriendCodeWithInvite_code:(NSString *)invite_code completed:(completedBlock)completed;


/**
 获取初次登录奖励

 @param completed 回调
 */
+ (void)getFirstLoginAwardWithCompleted:(completedBlock)completed;



/**
 获取可领取奖励

 @param completed 回调
 */
+ (void)getMyAwardWithCompleted:(completedBlock)completed;

/**
 获取可领取奖励LQC数量

 @param completed 回调
 */
+ (void)getMyAwardNumWithCompleted:(completedBlock)completed;


/**
 密码登录

 @param account 账号
 @param pwd 密码
 @param completed 回调
 */
+ (void)userPwdLoginWithAccount:(NSString *)account pwd:(NSString *)pwd completed:(completedBlock)completed;


/**
 签到

 @param completed 回调
 */
+ (void)signInWithCompleted:(completedBlock)completed;


/**
 获取海报

 @param completed 回调
 */
+ (void)getPosterWithCompleted:(completedBlock)completed;


/**
 获取海报

 @param type 0收入 1支出
 @param completed 回调
 */
+ (void)getIncomeListWithType:(NSString *)type completed:(completedBlock)completed;


/**
 获取配置

 @param completed 回调
 */
+ (void)getSettingWithCompleted:(completedBlock)completed;
@end
