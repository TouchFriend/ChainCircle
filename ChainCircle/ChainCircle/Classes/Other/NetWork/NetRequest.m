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

#pragma mark - 社区
#pragma mark banner
+ (void)getBannerWithType:(NSString *)type completed:(completedBlock)completed
{
    NSDictionary * parametersDic = @{
                                     @"type" : type,
                                     };
    
    
    [[NetAPIManager sharedManager] Post:@"/main/getbanner" parameters:parametersDic completed:^(id data, NSError *error) {
        if(completed != nil)
        {
            if(error == nil)
            {
                completed(data, GetCommunityBanner);
            }
            else
            {
                completed(data, RequestError);
            }
        }
    }];
}

#pragma mark 资讯列表
+ (void)getInfoListWithPage:(NSString *)page type_id:(NSString *)type_id completed:(completedBlock)completed
{
    NSDictionary * parametersDic = @{
                                     @"page" : page,
                                     @"pagesize" : @"20",
                                     @"type_id" : type_id,
                                     };
    
    
    [[NetAPIManager sharedManager] Post:@"/main/getlist" parameters:parametersDic completed:^(id data, NSError *error) {
        if(completed != nil)
        {
            if(error == nil)
            {
                completed(data, GetInfoList);
            }
            else
            {
                completed(data, RequestError);
            }
        }
    }];
}

#pragma mark 获取资讯类型列表
+ (void)getInfoTypeListWithCompleted:(completedBlock)completed
{
    NSDictionary * parametersDic = @{
                                  
                                     };
    
    
    [[NetAPIManager sharedManager] Post:@"/main/getinfotypelist" parameters:parametersDic completed:^(id data, NSError *error) {
        if(completed != nil)
        {
            if(error == nil)
            {
                completed(data, GetInfoTypeList);
            }
            else
            {
                completed(data, RequestError);
            }
        }
    }];
}

#pragma mark 获取评论列表
+ (void)getCommentListWithDetail_id:(NSString *)detail_id page:(NSString *)page type:(NSString *)type completed:(completedBlock)completed
{
    NSDictionary * parametersDic = @{
                                     @"detail_id" : detail_id,
                                     @"page" : page,
                                     @"pagesize" : @"20",
                                     @"type" : type,
                                     };
    
    
    [[NetAPIManager sharedManager] Post:@"/main/getspeaklist" parameters:parametersDic completed:^(id data, NSError *error) {
        if(completed != nil)
        {
            if(error == nil)
            {
                completed(data, GetCommentList);
            }
            else
            {
                completed(data, RequestError);
            }
        }
    }];
}

#pragma mark 点赞
+ (void)praiseActionWithType:(NSString *)type detail_id:(NSString *)detail_id completed:(completedBlock)completed
{
    NSDictionary * parametersDic = @{
                                     @"type" : type,
                                     @"detail_id" : detail_id,
                                     
                                     };
    
    
    [[NetAPIManager sharedManager] Post:@"/main/praise" parameters:parametersDic completed:^(id data, NSError *error) {
        if(completed != nil)
        {
            if(error == nil)
            {
                completed(data, PraiseAction);
            }
            else
            {
                completed(data, RequestError);
            }
        }
    }];
}

#pragma mark 获取旅游和或者美食列表
+ (void)getDeleciousFoodOrTourismListWithPage:(NSString *)page istop:(NSString *)istop type:(NSString *)type completed:(completedBlock)completed
{
    NSDictionary * parametersDic = @{
                                     @"page" : page,
                                     @"istop" : istop,
                                     @"type" : type,
                                     @"pagesize" : @"20",
                                     
                                     };
    NSMutableDictionary * parametersDicM = [NSMutableDictionary dictionaryWithDictionary:parametersDic];
    
    [self addLocationInfo:parametersDicM completed:completed];
    
    [[NetAPIManager sharedManager] Post:@"/main/gettravelfoods" parameters:parametersDicM completed:^(id data, NSError *error) {
        if(completed != nil)
        {
            if(error == nil)
            {
                completed(data, GetDeliciousFoodOrTourismList);
            }
            else
            {
                completed(data, RequestError);
            }
        }
    }];
}

#pragma mark 获取旅游和或者美食详情
+ (void)getDeliciousFoodOrTourismDetailWithDetail_id:(NSString *)detail_id completed:(completedBlock)completed
{
    NSDictionary * parametersDic = @{
                                     @"detail_id" : detail_id,
                                     
                                     };

    
    [[NetAPIManager sharedManager] Post:@"/main/detail" parameters:parametersDic completed:^(id data, NSError *error) {
        if(completed != nil)
        {
            if(error == nil)
            {
                completed(data, GetDeliciousFoodOrTourismDetail);
            }
            else
            {
                completed(data, RequestError);
            }
        }
    }];
}

#pragma mark 报纸列表
+ (void)getNewspaperListWithCompleted:(completedBlock)completed
{
    NSDictionary * parametersDic = @{
                                     
                                     };
    
    [[NetAPIManager sharedManager] Post:@"main/getnewspaper" parameters:parametersDic completed:^(id data, NSError *error) {
        if(completed != nil)
        {
            if(error == nil)
            {
                completed(data, GetNewspaperList);
            }
            else
            {
                completed(data, RequestError);
            }
        }
    }];
}

#pragma mark 获取通知
+ (void)getCommunityNotificationsWithCompleted:(completedBlock)completed
{
    NSDictionary * parametersDic = @{
                                     
                                     };
    
    [[NetAPIManager sharedManager] Post:@"main/getnotice" parameters:parametersDic completed:^(id data, NSError *error) {
        if(completed != nil)
        {
            if(error == nil)
            {
                completed(data, GetCommunityNotifications);
            }
            else
            {
                completed(data, RequestError);
            }
        }
    }];
}

#pragma mark 获取小区列表
+ (void)getVillageListWithCompleted:(completedBlock)completed
{
    NSDictionary * parametersDic = @{
                                     
                                     };
    
    [[NetAPIManager sharedManager] Post:@"main/getvillage" parameters:parametersDic completed:^(id data, NSError *error) {
        if(completed != nil)
        {
            if(error == nil)
            {
                completed(data, GetVillageList);
            }
            else
            {
                completed(data, RequestError);
            }
        }
    }];
}

#pragma mark 获取服务分类列表
+ (void)getServiceTypeListWithFathertype_id:(NSString *)fathertype_id completed:(completedBlock)completed
{
    NSDictionary * parametersDic = @{
                                     @"fathertype_id" : fathertype_id,
                                     };
    
    [[NetAPIManager sharedManager] Post:@"main/getservertype" parameters:parametersDic completed:^(id data, NSError *error) {
        if(completed != nil)
        {
            if(error == nil)
            {
                completed(data, GetServiceTypeList);
            }
            else
            {
                completed(data, RequestError);
            }
        }
    }];
}

#pragma mark 获取服务列表
+ (void)getServiceListWithType_id:(NSString *)type_id village_id:(NSString *)village_id page:(NSString *)page sorttype:(NSString *)sorttype istop:(NSString *)istop fathertype_id:(NSString *)fathertype_id findtxt:(NSString *)findtxt completed:(completedBlock)completed
{
    NSDictionary * parametersDic = @{
                                     @"type_id" : type_id,
                                     @"village_id" : village_id,
                                     @"page" : page,
                                     @"pagesize" : @"20",
                                     @"sorttype" : sorttype,
                                     @"istop" : istop,
                                     @"fathertype_id" : fathertype_id,
                                     @"findtxt" : findtxt,
                                     };
    
    [[NetAPIManager sharedManager] Post:@"main/getserverlist" parameters:parametersDic completed:^(id data, NSError *error) {
        if(completed != nil)
        {
            if(error == nil)
            {
                completed(data, GetServiceList);
            }
            else
            {
                completed(data, RequestError);
            }
        }
    }];
}

#pragma mark 评论内容
+ (void)commentContentWithDetail_id:(NSString *)detail_id content:(NSString *)content type:(NSString *)type completed:(completedBlock)completed
{
    NSDictionary * parametersDic = @{
                                     @"detail_id" : detail_id,
                                     @"content" : content,
                                     @"type" : type,
                                     
                                     };
    
    [[NetAPIManager sharedManager] Post:@"main/speak" parameters:parametersDic completed:^(id data, NSError *error) {
        if(completed != nil)
        {
            if(error == nil)
            {
                completed(data, CommentContent);
            }
            else
            {
                completed(data, RequestError);
            }
        }
    }];
}

#pragma mark 获取生活馆资讯类型列表
+ (void)getLifeStoreTypeListWithCompleted:(completedBlock)completed
{
    NSDictionary * parametersDic = @{
                                     
                                     };
    
    
    [[NetAPIManager sharedManager] Post:@"main/getlivinginfotypelist" parameters:parametersDic completed:^(id data, NSError *error) {
        if(completed != nil)
        {
            if(error == nil)
            {
                completed(data, GetLifeStoreTypeList);
            }
            else
            {
                completed(data, RequestError);
            }
        }
    }];
}

#pragma mark 获取生活馆资讯列表
+ (void)getLifeStoreListWithPage:(NSString *)page type_id:(NSString *)type_id completed:(completedBlock)completed
{
    NSDictionary * parametersDic = @{
                                     @"page" : page,
                                     @"pagesize" : @"20",
                                     @"type_id" : type_id,
                                     };
    
    
    [[NetAPIManager sharedManager] Post:@"main/getlivinglist" parameters:parametersDic completed:^(id data, NSError *error) {
        if(completed != nil)
        {
            if(error == nil)
            {
                completed(data, GetLifeStoreList);
            }
            else
            {
                completed(data, RequestError);
            }
        }
    }];
}

#pragma mark 获取订阅中心资讯列表
+ (void)getSubScribeInfoListWithPage:(NSString *)page type_id:(NSString *)type_id completed:(completedBlock)completed
{
    NSDictionary * parametersDic = @{
                                     @"page" : page,
                                     @"pagesize" : @"20",
                                     @"type_id" : type_id,
                                     };
    
    
    [[NetAPIManager sharedManager] Post:@"main/getpaperinfo" parameters:parametersDic completed:^(id data, NSError *error) {
        if(completed != nil)
        {
            if(error == nil)
            {
                completed(data, GetSubScribeInfoList);
            }
            else
            {
                completed(data, RequestError);
            }
        }
    }];
}

#pragma mark 获取自拍书法资讯列表
+ (void)getCalligraphyInfoListWithPage:(NSString *)page type_id:(NSString *)type_id completed:(completedBlock)completed
{
    NSDictionary * parametersDic = @{
                                     @"page" : page,
                                     @"pagesize" : @"20",
                                     @"type_id" : type_id,
                                     };
    
    
    [[NetAPIManager sharedManager] Post:@"main/getshufalist" parameters:parametersDic completed:^(id data, NSError *error) {
        if(completed != nil)
        {
            if(error == nil)
            {
                completed(data, GetCalligraphyInfoList);
            }
            else
            {
                completed(data, RequestError);
            }
        }
    }];
}

#pragma mark 少儿英语
+ (void)getChildEnglishListhWithCompleted:(completedBlock)completed
{
    NSDictionary * parametersDic = @{
                                     
                                     };
    
    
    [[NetAPIManager sharedManager] Post:@"main/teachvideo" parameters:parametersDic completed:^(id data, NSError *error) {
        if(completed != nil)
        {
            if(error == nil)
            {
                completed(data, GetChildEnglishList);
            }
            else
            {
                completed(data, RequestError);
            }
        }
    }];
}

#pragma mark 获取天气
+ (void)getWeatherWithCompleted:(completedBlock)completed
{
    NSDictionary * parametersDic = @{
                                     @"location" : @"fuzhou",
                                     };

    [[NetAPIManager sharedManager] Post:@"main/weather" parameters:parametersDic completed:^(id data, NSError *error) {
        if(completed != nil)
        {
            if(error == nil)
            {
                completed(data, GetWeatherInfo);
            }
            else
            {
                completed(data, RequestError);
            }
        }
    }];
}

#pragma mark - 订单部分
#pragma mark 添加商品到购物车
+ (void)addToShoppingCarWithGoodsid:(NSString *)goodsid goodsnum:(NSString *)goodsnum completed:(completedBlock)completed
{
    NSDictionary * parametersDic = @{
                                     @"goodsid" : goodsid,
                                     @"goodsnum" : goodsnum,
                                     };
    
    [[NetAPIManager sharedManager] Post:@"order/addcar" parameters:parametersDic completed:^(id data, NSError *error) {
        if(completed != nil)
        {
            if(error == nil)
            {
                completed(data, AddToShoppingCar);
            }
            else
            {
                completed(data, RequestError);
            }
        }
    }];
}

#pragma mark 获取购物车列表
+ (void)getShoppingCarListWithCompleted:(completedBlock)completed
{
    NSDictionary * parametersDic = @{
                  
                                     };
    
    [[NetAPIManager sharedManager] Post:@"order/getcar" parameters:parametersDic completed:^(id data, NSError *error) {
        if(completed != nil)
        {
            if(error == nil)
            {
                completed(data, GetShoppingCarList);
            }
            else
            {
                completed(data, RequestError);
            }
        }
    }];
}

#pragma mark 编辑购物车
+ (void)editShoppingCarWithID:(NSString *)ID num:(NSString *)num completed:(completedBlock)completed
{
    NSDictionary * parametersDic = @{
                                     @"id" : ID,
                                     @"num" : num,
                                     };
    
    [[NetAPIManager sharedManager] Post:@"order/editcar" parameters:parametersDic completed:^(id data, NSError *error) {
        if(completed != nil)
        {
            if(error == nil)
            {
                completed(data, EditShoppingCar);
            }
            else
            {
                completed(data, RequestError);
            }
        }
    }];
}

#pragma mark 删除购物车
+ (void)deleteShoppingCarWithProductID:(NSString *)ID completed:(completedBlock)completed
{
    NSDictionary * parametersDic = @{
                                     @"id" : ID,
                   
                                     };
    
    [[NetAPIManager sharedManager] Post:@"order/delcar" parameters:parametersDic completed:^(id data, NSError *error) {
        if(completed != nil)
        {
            if(error == nil)
            {
                completed(data, DeleteShoppingCar);
            }
            else
            {
                completed(data, RequestError);
            }
        }
    }];
}

#pragma mark 添加订单
+ (void)addOrderWithOrderproduct:(NSString *)orderproduct addressid:(NSString *)addressid remark:(NSString *)remark paytype:(NSString *)paytype express_price:(NSString *)express_price completed:(completedBlock)completed
{
    NSDictionary * parametersDic = @{
                                     @"orderproduct" : orderproduct,
                                     @"addressid" : addressid,
                                     @"remark" : remark,
                                     @"paytype" : paytype,
                                     @"express_price" : express_price,
                                     };
    
    [[NetAPIManager sharedManager] Post:@"order/addorder" parameters:parametersDic completed:^(id data, NSError *error) {
        if(completed != nil)
        {
            if(error == nil)
            {
                completed(data, AddOrder);
            }
            else
            {
                completed(data, RequestError);
            }
        }
    }];
}

#pragma mark 获取订单列表
+ (void)getOrderListWithOrderstate:(NSString *)orderstate completed:(completedBlock)completed
{
    NSDictionary * parametersDic = @{
                                     @"orderstate" : orderstate,
                                     
                                     };
    
    [[NetAPIManager sharedManager] Post:@"order/getorder" parameters:parametersDic completed:^(id data, NSError *error) {
        if(completed != nil)
        {
            if(error == nil)
            {
                completed(data, GetOrderList);
            }
            else
            {
                completed(data, RequestError);
            }
        }
    }];
}

#pragma mark 编辑订单
+ (void)editOrderWitOrderid:(NSString *)orderid orderstate:(NSString *)orderstate completed:(completedBlock)completed
{
    NSDictionary * parametersDic = @{
                                     @"orderid" : orderid,
                                     @"orderstate" : orderstate,
                                     };
    
    [[NetAPIManager sharedManager] Post:@"order/editorder" parameters:parametersDic completed:^(id data, NSError *error) {
        if(completed != nil)
        {
            if(error == nil)
            {
                completed(data, EditOrder);
            }
            else
            {
                completed(data, RequestError);
            }
        }
    }];
}

#pragma mark 添加报纸订单
+ (void)addNewspaperOrderWithPaper_id:(NSString *)paper_id addressid:(NSString *)addressid remark:(NSString *)remark paytype:(NSString *)paytype completed:(completedBlock)completed
{
    NSDictionary * parametersDic = @{
                                     @"paper_id" : paper_id,
                                     @"addressid" : addressid,
                                     @"remark" : remark,
                                     @"paytype" : paytype,
                                     };
    
    [[NetAPIManager sharedManager] Post:@"order/addpaperorder" parameters:parametersDic completed:^(id data, NSError *error) {
        if(completed != nil)
        {
            if(error == nil)
            {
                completed(data, AddNewspaperOrder);
            }
            else
            {
                completed(data, RequestError);
            }
        }
    }];
}

#pragma mark 重新支付
+ (void)rePayOrderWithOrderno:(NSString *)orderno completed:(completedBlock)completed
{
    NSDictionary * parametersDic = @{
                                     @"orderno" : orderno,

                                     };
    
    [[NetAPIManager sharedManager] Post:@"order/payorder" parameters:parametersDic completed:^(id data, NSError *error) {
        if(completed != nil)
        {
            if(error == nil)
            {
                completed(data, RePayOrder);
            }
            else
            {
                completed(data, RequestError);
            }
        }
    }];
}

#pragma mark - 商品部分

#pragma mark 获取商品类型
+ (void)getGoodTypeWithCompleted:(completedBlock)completed
{
    NSDictionary * parametersDic = @{
                                    
                                     };
    
    [[NetAPIManager sharedManager] Post:@"/goods/getgoodstype" parameters:parametersDic completed:^(id data, NSError *error) {
        if(completed != nil)
        {
            if(error == nil)
            {
                completed(data, GetGoodType);
            }
            else
            {
                completed(data, RequestError);
            }
        }
    }];
}

#pragma mark 获取商品列表
+ (void)getGoodListWithPage:(NSString *)page goodsname:(NSString *)goodsname goodstypeid:(NSString *)goodstypeid sort:(NSString *)sort sorttype:(NSString *)sorttype ishome:(NSString *)ishome completed:(completedBlock)completed
{
    NSDictionary * parametersDic = @{
                                     @"page" : page,
                                     @"pagesize" : @"20",
                                     @"goodsname" : goodsname,
                                     @"goodstypeid" : goodstypeid,
                                     @"sort" : sort,
                                     @"sorttype" : sorttype,
                                     @"ishome" : ishome,
                                     };
    
    [[NetAPIManager sharedManager] Post:@"/goods/goodslist" parameters:parametersDic completed:^(id data, NSError *error) {
        if(completed != nil)
        {
            if(error == nil)
            {
                completed(data, GetGoodList);
            }
            else
            {
                completed(data, RequestError);
            }
        }
    }];
}

#pragma mark 获取商品评价列表
+ (void)getGoodCommentListWithGoods_id:(NSString *)goods_id content_type:(NSString *)content_type speak_type:(NSString *)speak_type completed:(completedBlock)completed
{
    NSDictionary * parametersDic = @{
                                     @"goods_id" : goods_id,
                                     @"content_type" : content_type,
                                     @"speak_type" : speak_type,
                                     };
    
    [[NetAPIManager sharedManager] Post:@"goods/goodsspeak" parameters:parametersDic completed:^(id data, NSError *error) {
        if(completed != nil)
        {
            if(error == nil)
            {
                completed(data, GetGoodCommentList);
            }
            else
            {
                completed(data, RequestError);
            }
        }
    }];
}

#pragma mark 获取免邮价格
+ (void)getEmailPriceWithCompleted:(completedBlock)completed
{
    NSDictionary * parametersDic = @{
                                     
                                     };
    
    [[NetAPIManager sharedManager] Post:@"goods/getexpressconfig" parameters:parametersDic completed:^(id data, NSError *error) {
        if(completed != nil)
        {
            if(error == nil)
            {
                completed(data, GetEmailPrice);
            }
            else
            {
                completed(data, RequestError);
            }
        }
    }];
}

#pragma mark 服务评价
+ (void)commentServiceWithContent:(NSString *)content starnum:(NSString *)starnum pictures:(NSString *)pictures detail_id:(NSString *)detail_id completed:(completedBlock)completed
{
    NSDictionary * parametersDic = @{
                                     @"content" : content,
                                     @"starnum" : starnum,
                                     @"pictures" : pictures,
                                     @"detail_id" : detail_id,
                                     };
    
    [[NetAPIManager sharedManager] Post:@"goods/speakserver" parameters:parametersDic completed:^(id data, NSError *error) {
        if(completed != nil)
        {
            if(error == nil)
            {
                completed(data, CommentService);
            }
            else
            {
                completed(data, RequestError);
            }
        }
    }];
}

#pragma mark 商品评价
+ (void)commentProductWithSpeaklist:(NSString *)speaklist order_id:(NSString *)order_id completed:(completedBlock)completed
{
    NSDictionary * parametersDic = @{
                                     @"speaklist" : speaklist,
                                     @"order_id" : order_id,
                                     };
    
    [[NetAPIManager sharedManager] Post:@"goods/speakgoods" parameters:parametersDic completed:^(id data, NSError *error) {
        if(completed != nil)
        {
            if(error == nil)
            {
                completed(data, CommentProduct);
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
+ (void)getVeriCodeWithType:(NSString *)type mobile:(NSString *)mobile completed:(completedBlock)completed
{
    NSDictionary * parametersDic = @{
                                     @"type" : type,
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

#pragma mark 用户注册
+ (void)userRegisterWithAccount:(NSString *)account code:(NSString *)code pwd:(NSString *)pwd type:(NSString *)type name:(NSString *)name picture:(NSString *)picture completed:(completedBlock)completed
{
    NSDictionary * parametersDic = @{
                                     @"account" : account,
                                     @"code" : code,
                                     @"pwd" : pwd,
                                     @"type" : type,
                                     @"name" : name,
                                     @"picture" : picture,
                                     };
    
    [[NetAPIManager sharedManager] Post:@"/user/regist" parameters:parametersDic completed:^(id data, NSError *error) {
        if(completed != nil)
        {
            if(error == nil)
            {
                completed(data, UserRegister);
            }
            else
            {
                completed(data, RequestError);
            }
        }
    }];
}

#pragma mark 登录
+ (void)userLoginWithAccount:(NSString *)account pwd:(NSString *)pwd completed:(completedBlock)completed
{
    NSDictionary * parametersDic = @{
                                     @"account" : account,
                                     @"pwd" : pwd,
                                     
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

#pragma mark 更新用户信息
+ (void)updateInfoWithMemberid:(NSString *)memberid name:(NSString *)name picture:(NSString *)picture sex:(NSString *)sex location:(NSString *)location completed:(completedBlock)completed
{
    NSDictionary * parametersDic = @{
                                     @"memberid" : memberid,
                                     @"name" : name,
                                     @"picture" : picture,
                                     @"sex" : sex,
                                     @"location" : location,
                                     
                                     };
    
    [[NetAPIManager sharedManager] Post:@"user/updateinfo" parameters:parametersDic completed:^(id data, NSError *error) {
        if(completed != nil)
        {
            if(error == nil)
            {
                completed(data, UpdateInfo);
            }
            else
            {
                completed(data, RequestError);
            }
        }
    }];
}

#pragma mark 获取用户信息
+ (void)getUserInfoWithCompleted:(completedBlock)completed
{
    NSDictionary * parametersDic = @{
                                     
                                     };
    
    [[NetAPIManager sharedManager] Post:@"user/userinfo" parameters:parametersDic completed:^(id data, NSError *error) {
        if(completed != nil)
        {
            if(error == nil)
            {
                completed(data, GetUserInfo);
            }
            else
            {
                completed(data, RequestError);
            }
        }
    }];
}

#pragma mark 获取用户地址
+ (void)getUserAddressWithCompleted:(completedBlock)completed
{
    NSDictionary * parametersDic = @{
                                     
                                     };
    
    [[NetAPIManager sharedManager] Post:@"user/getaddress" parameters:parametersDic completed:^(id data, NSError *error) {
        if(completed != nil)
        {
            if(error == nil)
            {
                completed(data, GetUserAddress);
            }
            else
            {
                completed(data, RequestError);
            }
        }
    }];
}

#pragma mark 添加用户地址
+ (void)addUserAddressWithName:(NSString *)name mobile:(NSString *)mobile region:(NSString *)region detail:(NSString *)detail isdefault:(NSString *)isdefault completed:(completedBlock)completed
{
    NSDictionary * parametersDic = @{
                                     @"name" : name,
                                     @"mobile" : mobile,
                                     @"region" : region,
                                     @"detail" : detail,
                                     @"isdefault" : isdefault,
                                     };
    
    [[NetAPIManager sharedManager] Post:@"user/addaddress" parameters:parametersDic completed:^(id data, NSError *error) {
        if(completed != nil)
        {
            if(error == nil)
            {
                completed(data, AddUserAddress);
            }
            else
            {
                completed(data, RequestError);
            }
        }
    }];
}

#pragma mark 修改用户地址
+ (void)updateUserAddressWithID:(NSString *)ID name:(NSString *)name mobile:(NSString *)mobile region:(NSString *)region detail:(NSString *)detail isdefault:(NSString *)isdefault completed:(completedBlock)completed
{
    NSDictionary * parametersDic = @{
                                     @"id" : ID,
                                     @"name" : name,
                                     @"mobile" : mobile,
                                     @"region" : region,
                                     @"detail" : detail,
                                     @"isdefault" : isdefault,
                                     };
    
    [[NetAPIManager sharedManager] Post:@"user/updateaddress" parameters:parametersDic completed:^(id data, NSError *error) {
        if(completed != nil)
        {
            if(error == nil)
            {
                completed(data, UpdateUserAddress);
            }
            else
            {
                completed(data, RequestError);
            }
        }
    }];

}

#pragma mark 删除用户地址
+ (void)deleteUserAddressWithID:(NSString *)ID completed:(completedBlock)completed
{
    NSDictionary * parametersDic = @{
                                     @"id" : ID,
                                     };
    
    [[NetAPIManager sharedManager] Post:@"user/deladdress" parameters:parametersDic completed:^(id data, NSError *error) {
        if(completed != nil)
        {
            if(error == nil)
            {
                completed(data, DeleteUserAddress);
            }
            else
            {
                completed(data, RequestError);
            }
        }
    }];

}

#pragma mark 添加收藏
+ (void)addCollectionWithCollectid:(NSString *)collectid type:(NSString *)type flag:(NSString *)flag completed:(completedBlock)completed
{
    NSDictionary * parametersDic = @{
                                     @"collectid" : collectid,
                                     @"type" : type,
                                     @"flag" : flag,
                                     };
    
    [[NetAPIManager sharedManager] Post:@"user/collect" parameters:parametersDic completed:^(id data, NSError *error) {
        if(completed != nil)
        {
            if(error == nil)
            {
                completed(data, AddCollection);
            }
            else
            {
                completed(data, RequestError);
            }
        }
    }];
}

#pragma mark 点赞
+ (void)addPraiseWithType:(NSString *)type detail_id:(NSString *)detail_id completed:(completedBlock)completed
{
    NSDictionary * parametersDic = @{
                                     @"type" : type,
                                     @"detail_id" : detail_id,
                                     };
    
    [[NetAPIManager sharedManager] Post:@"main/praise" parameters:parametersDic completed:^(id data, NSError *error) {
        if(completed != nil)
        {
            if(error == nil)
            {
                completed(data, AddPraise);
            }
            else
            {
                completed(data, RequestError);
            }
        }
    }];
}

#pragma mark 获取默认地址
+ (void)getDefaultAddressWithCompleted:(completedBlock)completed
{
    NSDictionary * parametersDic = @{
                                     };
    
    [[NetAPIManager sharedManager] Post:@"user/getdefaultaddress" parameters:parametersDic completed:^(id data, NSError *error) {
        if(completed != nil)
        {
            if(error == nil)
            {
                completed(data, GetDefaultAddress);
            }
            else
            {
                completed(data, RequestError);
            }
        }
    }];
}

#pragma mark 获取我的订阅
+ (void)getMySubscriptionWithCompleted:(completedBlock)completed
{
    NSDictionary * parametersDic = @{
                                     };
    
    [[NetAPIManager sharedManager] Post:@"user/getsubscribe" parameters:parametersDic completed:^(id data, NSError *error) {
        if(completed != nil)
        {
            if(error == nil)
            {
                completed(data, GetMySubscription);
            }
            else
            {
                completed(data, RequestError);
            }
        }
    }];
}

#pragma mark 获取收藏信息
+ (void)getCollectInfoWithCollectID:(NSString *)collectid type:(NSString *)type Completed:(completedBlock)completed
{
    NSDictionary * parametersDic = @{
                                     @"collectid" : collectid,
                                     @"type" : type,
                                     };
    
    [[NetAPIManager sharedManager] Post:@"user/iscollect" parameters:parametersDic completed:^(id data, NSError *error) {
        if(completed != nil)
        {
            if(error == nil)
            {
                completed(data, GetCollectInfo);
            }
            else
            {
                completed(data, RequestError);
            }
        }
    }];
}

#pragma mark 获取收藏列表
+ (void)getCollectionListWithType:(NSString *)type Completed:(completedBlock)completed
{
    NSDictionary * parametersDic = @{
                                     @"type" : type,
       
                                     };
    
    [[NetAPIManager sharedManager] Post:@"user/getcollect" parameters:parametersDic completed:^(id data, NSError *error) {
        if(completed != nil)
        {
            if(error == nil)
            {
                completed(data, GetCollectionList);
            }
            else
            {
                completed(data, RequestError);
            }
        }
    }];
}

#pragma mark 意见反馈
+ (void)feedBackWithContact:(NSString *)contact content:(NSString *)content completed:(completedBlock)completed
{
    NSDictionary * parametersDic = @{
                                     @"contact" : contact,
                                     @"content" : content,
                                     };
    
    [[NetAPIManager sharedManager] Post:@"user/complaint" parameters:parametersDic completed:^(id data, NSError *error) {
        if(completed != nil)
        {
            if(error == nil)
            {
                completed(data, UserFeedBack);
            }
            else
            {
                completed(data, RequestError);
            }
        }
    }];
}

#pragma mark 修改密码
+ (void)updateUserPwdWithOldpwd:(NSString *)oldpwd newpwd:(NSString *)newpwd completed:(completedBlock)completed
{
    NSDictionary * parametersDic = @{
                                     @"oldpwd" : oldpwd,
                                     @"newpwd" : newpwd,
                                     };
    
    [[NetAPIManager sharedManager] Post:@"user/resetpwd" parameters:parametersDic completed:^(id data, NSError *error) {
        if(completed != nil)
        {
            if(error == nil)
            {
                completed(data, UpdateUserPwd);
            }
            else
            {
                completed(data, RequestError);
            }
        }
    }];
}

#pragma mark 忘记密码-重置密码
+ (void)forgetPwdWithAccount:(NSString *)account code:(NSString *)code pwd:(NSString *)pwd completed:(completedBlock)completed
{
    NSDictionary * parametersDic = @{
                                     @"account" : account,
                                     @"code" : code,
                                     @"pwd" : pwd
                                     };
    
    [[NetAPIManager sharedManager] Post:@"user/updatepwd" parameters:parametersDic completed:^(id data, NSError *error) {
        if(completed != nil)
        {
            if(error == nil)
            {
                completed(data, ResetUserPwd);
            }
            else
            {
                completed(data, RequestError);
            }
        }
    }];
}

#pragma mark 更新用户步数
+ (void)updatUserStepWithStepnum:(NSString *)stepnum completed:(completedBlock)completed
{
    NSDictionary * parametersDic = @{
                                     @"stepnum" : stepnum,
                                     };
    
    [[NetAPIManager sharedManager] Post:@"user/updatestep" parameters:parametersDic completed:^(id data, NSError *error) {
        if(completed != nil)
        {
            if(error == nil)
            {
                completed(data, UpdateUserStep);
            }
            else
            {
                completed(data, RequestError);
            }
        }
    }];
}

#pragma mark 获取步数排行
+ (void)getStepRankWithCompleted:(completedBlock)completed
{
    NSDictionary * parametersDic = @{
                                    
                                     };
    
    [[NetAPIManager sharedManager] Post:@"user/getsteplist" parameters:parametersDic completed:^(id data, NSError *error) {
        if(completed != nil)
        {
            if(error == nil)
            {
                completed(data, GetStepRank);
            }
            else
            {
                completed(data, RequestError);
            }
        }
    }];
}

#pragma mark 购物车数量
+ (void)getShoppingCarNumWithCompleted:(completedBlock)completed
{
    NSDictionary * parametersDic = @{
                                     
                                     };
    
    [[NetAPIManager sharedManager] Post:@"order/getcarnum" parameters:parametersDic completed:^(id data, NSError *error) {
        if(completed != nil)
        {
            if(error == nil)
            {
                completed(data, GetShoppingCarNum);
            }
            else
            {
                completed(data, RequestError);
            }
        }
    }];
}

#pragma mark 我的优惠券
+ (void)getMyCouponListWithCompleted:(completedBlock)completed
{
    NSDictionary * parametersDic = @{
                                     
                                     };
    
    [[NetAPIManager sharedManager] Post:@"user/getcoupon" parameters:parametersDic completed:^(id data, NSError *error) {
        if(completed != nil)
        {
            if(error == nil)
            {
                completed(data, GetMyCouponList);
            }
            else
            {
                completed(data, RequestError);
            }
        }
    }];
}

#pragma mark 帮助中心列表
+ (void)getHelpCenterListWithCompleted:(completedBlock)completed
{
    NSDictionary * parametersDic = @{
                                     
                                     };
    
    [[NetAPIManager sharedManager] Post:@"user/gethelp" parameters:parametersDic completed:^(id data, NSError *error) {
        if(completed != nil)
        {
            if(error == nil)
            {
                completed(data, GetHelpCenterList);
            }
            else
            {
                completed(data, RequestError);
            }
        }
    }];
}

#pragma mark - 社区论坛

#pragma mark 获取圈子列表
+ (void)GetCircleListWithPage:(NSString *)page village_id:(NSString *)village_id completed:(completedBlock)completed
{
    NSDictionary * parametersDic = @{
                                     @"page" : page,
                                     @"pagesize" : @"20",
                                     @"village_id" : village_id,
                                     };
    
    [[NetAPIManager sharedManager] Post:@"circle/getlist" parameters:parametersDic completed:^(id data, NSError *error) {
        if(completed != nil)
        {
            if(error == nil)
            {
                completed(data, GetCircleList);
            }
            else
            {
                completed(data, RequestError);
            }
        }
    }];
}

#pragma mark 发布动态
+ (void)postCircleWithContent:(NSString *)content pictures:(NSString *)pictures village_id:(NSString *)village_id completed:(completedBlock)completed
{
    NSDictionary * parametersDic = @{
                                     @"content" : content,
                                     @"pictures" : pictures,
                                     @"village_id" : village_id,
                                     };
    
    [[NetAPIManager sharedManager] Post:@"circle/add" parameters:parametersDic completed:^(id data, NSError *error) {
        if(completed != nil)
        {
            if(error == nil)
            {
                completed(data, PostCircle);
            }
            else
            {
                completed(data, RequestError);
            }
        }
    }];
}

@end
