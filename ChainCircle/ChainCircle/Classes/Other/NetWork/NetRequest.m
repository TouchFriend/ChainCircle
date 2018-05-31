//
//  NetRequest.m
//  ConsumptionPlus
//
//  Created by TouchWorld on 2017/10/26.
//  Copyright © 2017年 qichen. All rights reserved.
//

#import "NetRequest.h"
#import "NetAPIManager.h"
#import "NJUserItem.h"
#import "FileCacheTool.h"

@implementation NetRequest
#pragma mark - 添加用户ID和token
+ (BOOL)addUserIdAndToken:(NSMutableDictionary *)parametersDicM completed:(completedBlock)completed
{
    NJUserItem * userItem = [NJLoginTool getCurrentUser];
    //账号
    NSString * account = userItem.account;
    if(account != nil && account.length > 0)
    {
        parametersDicM[@"account"] = account;
    }
    else
    {
        completed(@"未知错误", RequestError);
        return NO;
    }
    //密码
    NSString * pwd = userItem.password;
    if(pwd != nil && pwd.length != 0)
    {
        parametersDicM[@"pwd"] = pwd;
    }
    else
    {
        completed(@"未知错误", RequestError);
        return NO;
    }
    
    //用户ID
    NSString * userID = userItem.ID;
    if(userID != nil && userID.length != 0)
    {
        parametersDicM[@"user_id"] = userID;
    }
    else
    {
        completed(@"未知错误", RequestError);
        return NO;
    }
    
    return YES;
}

#pragma mark - 添加定位信息
+ (BOOL)addLocationInfo:(NSMutableDictionary *)parametersDicM completed:(completedBlock)completed
{
    NSNumber * latituteNumber = (NSNumber *)[FileCacheTool unCacheObjectWithKey:NJUserDefaultLocationLatitute];
    NSNumber * longituteNumber = (NSNumber *)[FileCacheTool unCacheObjectWithKey:NJUserDefaultLocationLongitute];
//    NSString * city = (NSString *)[FileCacheTool unCacheObjectWithKey:NJUserDefaultLocationCity];
    
    if(latituteNumber != nil)
    {
        parametersDicM[@"lat"] = latituteNumber.stringValue;
        parametersDicM[@"lng"] = longituteNumber.stringValue;
//        parametersDicM[@"city"] = NJUserDefaultLocationCity;
    }
    else
    {
        parametersDicM[@"lat"] = @"26.0767220000";
        parametersDicM[@"lng"] = @"119.2910170000";
//        parametersDicM[@"city"] = @"福州";
    }
    
    return YES;
}

#pragma mark 版本升级
+ (void)versionUpdateWithOldver:(NSString *)oldver completed:(completedBlock)completed
{
    //0android 1IOS
    NSDictionary * parametersDic = @{
                                     @"oldver" : oldver,
                                     @"apptype" : @"1",
                                     };
    
    
    
    [[NetAPIManager sharedManager] Post:@"/user/updatever" parameters:parametersDic completed:^(id data, NSError *error) {
        if(completed != nil)
        {
            if(error == nil)
            {
                completed(data, VersionUpdate);
            }
            else
            {
                completed(data, RequestError);
            }
        }
    }];
}




#pragma mark - 我的
#pragma mark 验证码
+ (void)getVeriCodeWithMobile:(NSString *)mobile completed:(completedBlock)completed
{
    NSDictionary * parametersDic = @{
                                     @"mobile" : mobile,
                                     
                                     };
    
    [[NetAPIManager sharedManager] Post:@"user/getcode" parameters:parametersDic completed:^(id data, NSError *error) {
        if(completed != nil)
        {
            if(error == nil)
            {
                completed(data, GetVeriCode);
            }
            else
            {
                completed(data, RequestError);
            }
        }
    }];
}

#pragma mark 登录
+ (void)userLoginWithAccount:(NSString *)account code:(NSString *)code completed:(completedBlock)completed
{
    NSDictionary * parametersDic = @{
                                     @"account" : account,
                                     @"code" : code,
                                     
                                     };
    
    [[NetAPIManager sharedManager] Post:@"/user/login" parameters:parametersDic completed:^(id data, NSError *error) {
        if(completed != nil)
        {
            if(error == nil)
            {
                completed(data, UserLogin);
            }
            else
            {
                completed(data, RequestError);
            }
        }
    }];
}

#pragma mark - Lqc
#pragma mark 滚动标题
+ (void)getScrollTitleDataWithCompleted:(completedBlock)completed
{
    NSDictionary * parametersDic = @{
                  
                                     
                                     };
    
    [[NetAPIManager sharedManager] Post:@"/user/getad" parameters:parametersDic completed:^(id data, NSError *error) {
        if(completed != nil)
        {
            if(error == nil)
            {
                completed(data, GetScrollTitle);
            }
            else
            {
                completed(data, RequestError);
            }
        }
    }];
}

#pragma mark  获取邀请信息
+ (void)getInviteInfoWithCompleted:(completedBlock)completed
{
    NSDictionary * parametersDic = @{
                                     
                                     
                                     };
    
    [[NetAPIManager sharedManager] Post:@"/user/getInviteData" parameters:parametersDic completed:^(id data, NSError *error) {
        if(completed != nil)
        {
            if(error == nil)
            {
                completed(data, GetInviteInfo);
            }
            else
            {
                completed(data, RequestError);
            }
        }
    }];
}

#pragma mark  绑定朋友邀请码
+ (void)bindFriendCodeWithInvite_code:(NSString *)invite_code completed:(completedBlock)completed
{
    NSDictionary * parametersDic = @{
                                     @"invite_code" : invite_code,
                                     
                                     };
    
    [[NetAPIManager sharedManager] Post:@"/user/BindUser" parameters:parametersDic completed:^(id data, NSError *error) {
        if(completed != nil)
        {
            if(error == nil)
            {
                completed(data, BindeFriendCode);
            }
            else
            {
                completed(data, RequestError);
            }
        }
    }];
}

#pragma mark  获取初次登录奖励
+ (void)getFirstLoginAwardWithCompleted:(completedBlock)completed
{
    NSDictionary * parametersDic = @{
                                     
                                     
                                     };
    
    [[NetAPIManager sharedManager] Post:@"/user/GetFirstLoginPrice" parameters:parametersDic completed:^(id data, NSError *error) {
        if(completed != nil)
        {
            if(error == nil)
            {
                completed(data, GetFirstLoginAward);
            }
            else
            {
                completed(data, RequestError);
            }
        }
    }];
}

#pragma mark  获取可领取奖励
+ (void)getMyAwardWithCompleted:(completedBlock)completed
{
    NSDictionary * parametersDic = @{
                                     
                                     
                                     };
    
    [[NetAPIManager sharedManager] Post:@"/user/GetMyPrice" parameters:parametersDic completed:^(id data, NSError *error) {
        if(completed != nil)
        {
            if(error == nil)
            {
                completed(data, GetMyAward);
            }
            else
            {
                completed(data, RequestError);
            }
        }
    }];
}

#pragma mark  获取可领取奖励LQC数量
+ (void)getMyAwardNumWithCompleted:(completedBlock)completed
{
    NSDictionary * parametersDic = @{
                                     
                                     
                                     };
    
    [[NetAPIManager sharedManager] Post:@"/user/GetMyPriceNum" parameters:parametersDic completed:^(id data, NSError *error) {
        if(completed != nil)
        {
            if(error == nil)
            {
                completed(data, GetMyAwardNum);
            }
            else
            {
                completed(data, RequestError);
            }
        }
    }];
}

@end
