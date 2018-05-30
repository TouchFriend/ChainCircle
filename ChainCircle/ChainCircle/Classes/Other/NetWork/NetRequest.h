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
    GetCommunityBanner,//获取社区首页banner
    GetInfoList,//资讯列表
    GetInfoTypeList,//获取资讯类型列表
    GetCommentList,//获取评论列表
    PraiseAction,//点赞
    GetDeliciousFoodOrTourismList,//获取旅游和或者美食列表
    GetDeliciousFoodOrTourismDetail,//获取旅游和或者美食详情
    GetNewspaperList,//获取报纸列表
    GetCommunityNotifications,//获取社区通知列表
    GetVillageList,//获取小区列表
    GetServiceTypeList,//获取服务类型列表
    GetServiceList,//获取服务列表
    GetVeriCode,//获取验证码
    UserRegister,//获取注册
    UserLogin,//用户登录
    UpdateInfo,//更新用户信息
    GetUserInfo,//获取用户信息
    GetGoodList, //获取商品列表
    GetGoodType, //获取商品类型
    GetGoodCommentList, //获取商品评价列表
    GetUserAddress, //获取用户地址
    AddUserAddress, //添加用户地址
    UpdateUserAddress, //修改用户地址
    DeleteUserAddress, //删除地址
    AddCollection, //添加收藏
    AddToShoppingCar, //添加商品到购物车
    GetShoppingCarList,//获取购物车列表
    EditShoppingCar, //编辑购物车
    DeleteShoppingCar, //删除购物车
    GetDefaultAddress, //获取默认地址
    GetEmailPrice, //获取免邮价格
    AddOrder, //添加订单
    GetOrderList, //获取订单列表
    EditOrder, //编辑订单
    GetMySubscription, //获取我的订阅
    AddNewspaperOrder, //添加报纸订单
    GetCollectInfo, // 获取收藏信息
    AddPraise, // 点赞
    GetCollectionList, //获取收藏列表
    CommentContent, //评论内容
    CommentService, //评价服务
    UserFeedBack, //用户反馈
    GetCircleList, // 获取圈子列表
    PostCircle, //发布动态
    GetLifeStoreTypeList, //获取生活馆类型列表
    GetLifeStoreList, //获取生活馆资讯列表
    GetSubScribeInfoList, //获取订阅中心资讯列表
    GetCalligraphyInfoList, //获取自拍书法资讯列表
    GetChildEnglishList, //少儿英语
    GetWeatherInfo, //天气
    UpdateUserPwd, //修改密码
    ResetUserPwd, //忘记密码-重置密码
    UpdateUserStep, //更新用户步数
    GetStepRank, //步数排行
    GetShoppingCarNum, //购物车数量
    GetMyCouponList, //我的优惠券
    RePayOrder, //重新支付订单 （我的订单-付款）
    CommentProduct, //商品评价
    GetHelpCenterList, //帮助中心列表
} NetRequest_enum;

@interface NetRequest : NSObject


/**
 版本升级

 @param oldver 旧的版本
 @param completed 回调
 */
+ (void)versionUpdateWithOldver:(NSString *)oldver completed:(completedBlock)completed;

#pragma mark - 社区

/**
 banner

 @param type 类型 0资讯 1旅游 2美食 3服务 4社区 5农场品 6数字生活 7生活馆 8老年大学
 @param completed 回调
 */
+ (void)getBannerWithType:(NSString *)type completed:(completedBlock)completed;



/**
 资讯列表

 @param page 分页
 @param type_id 筛选类型ID 用 ， 隔开
 @param completed 回调
 */
+ (void)getInfoListWithPage:(NSString *)page type_id:(NSString *)type_id completed:(completedBlock)completed;


/**
 获取资讯类型列表

 @param completed 回调
 */
+ (void)getInfoTypeListWithCompleted:(completedBlock)completed;


/**
 获取评论列表

 @param detail_id 资讯或者美食详细id
 @param page 分页
 @param type 0资讯 1旅游 2美食 3服务 4社区圈子 5对用户的评论点赞  6用户评论的评论点赞
 @param completed 回调
 */
+ (void)getCommentListWithDetail_id:(NSString *)detail_id page:(NSString *)page type:(NSString *)type completed:(completedBlock)completed;


/**
 点赞

 @param type 0资讯 1旅游 2美食 3服务 4社区圈子 5对用户的评论点赞  6用户评论的评论点赞
 @param detail_id 评论id
 @param completed 回调
 */
+ (void)praiseActionWithType:(NSString *)type detail_id:(NSString *)detail_id completed:(completedBlock)completed;


/**
 获取旅游和或者美食列表

 @param page 分页
 @param istop 1热点 0非热点
 @param type 0资讯 0旅游 1美食 3服务 4社区圈子 5对用户的评论点赞  6用户评论的评论点赞
 @param completed 回调
 */
+ (void)getDeleciousFoodOrTourismListWithPage:(NSString *)page istop:(NSString *)istop type:(NSString *)type completed:(completedBlock)completed;



/**
  获取旅游和或者美食详情

 @param detail_id id
 @param completed 回调
 */
+ (void)getDeliciousFoodOrTourismDetailWithDetail_id:(NSString *)detail_id completed:(completedBlock)completed;


/**
 报纸列表

 @param completed 回调
 */
+ (void)getNewspaperListWithCompleted:(completedBlock)completed;


/**
 获取通知

 @param completed 回调
 */
+ (void)getCommunityNotificationsWithCompleted:(completedBlock)completed;


/**
 获取小区列表

 @param completed 回调
 */
+ (void)getVillageListWithCompleted:(completedBlock)completed;


/**
 获取服务分类列表

 @param fathertype_id 父id 第一级传 -1
 @param completed 回调
 */
+ (void)getServiceTypeListWithFathertype_id:(NSString *)fathertype_id completed:(completedBlock)completed;


/**
 获取服务列表

 @param type_id 类型id
 @param village_id 小区id
 @param page 分页
 @param sorttype 0综合 1好评 2距离 3价格
 @param istop 1推荐 0不是推荐的 -1全部
 @param fathertype_id 父类型ID
 @param findtxt 查找内容
 @param completed 回调
 */
+ (void)getServiceListWithType_id:(NSString *)type_id village_id:(NSString *)village_id page:(NSString *)page sorttype:(NSString *)sorttype istop:(NSString *)istop fathertype_id:(NSString *)fathertype_id findtxt:(NSString *)findtxt completed:(completedBlock)completed;


/**
 评论内容

 @param detail_id id
 @param content 内容
 @param type 0资讯 1旅游 2美食 3服务 4社区圈子
 @param completed 回调
 */
+ (void)commentContentWithDetail_id:(NSString *)detail_id content:(NSString *)content type:(NSString *)type completed:(completedBlock)completed;


/**
 获取生活馆资讯类型列表

 @param completed 回调
 */
+ (void)getLifeStoreTypeListWithCompleted:(completedBlock)completed;



/**
 获取生活馆资讯列表

 @param page 分页
 @param type_id 类型id 筛选类型ID 用 ， 隔开
 @param completed 回调
 */
+ (void)getLifeStoreListWithPage:(NSString *)page type_id:(NSString *)type_id completed:(completedBlock)completed;


/**
 获取订阅中心资讯列表

 @param page 分页
 @param type_id 类型id 筛选类型ID 用 ， 隔开
 @param completed 回调
 */
+ (void)getSubScribeInfoListWithPage:(NSString *)page type_id:(NSString *)type_id completed:(completedBlock)completed;


/**
 获取自拍书法资讯列表

 @param page 分页
 @param type_id 类型id 筛选类型ID 用 ， 隔开
 @param completed 回调
 */
+ (void)getCalligraphyInfoListWithPage:(NSString *)page type_id:(NSString *)type_id completed:(completedBlock)completed;


/**
 少儿英语

 @param completed 回调
 */
+ (void)getChildEnglishListhWithCompleted:(completedBlock)completed;


/**
 获取天气

 @param completed 回调
 */
+ (void)getWeatherWithCompleted:(completedBlock)completed;

#pragma mark - 订单部分

/**
 添加商品到购物车

 @param goodsid 商品ID
 @param goodsnum 数量
 @param completed 回调
 */
+ (void)addToShoppingCarWithGoodsid:(NSString *)goodsid goodsnum:(NSString *)goodsnum completed:(completedBlock)completed;


/**
 获取购物车列表

 @param completed 回调
 */
+ (void)getShoppingCarListWithCompleted:(completedBlock)completed;


/**
 添加订单

 @param orderproduct 商品id和数量,[{"goodsid":1,"goodsnum":15}] json字符串
 @param addressid 地址
 @param remark 留言
 @param paytype 0支付宝 1微信
 @param express_price 邮费
 @param completed 回调
 */
+ (void)addOrderWithOrderproduct:(NSString *)orderproduct addressid:(NSString *)addressid remark:(NSString *)remark paytype:(NSString *)paytype express_price:(NSString *)express_price completed:(completedBlock)completed;


/**
 获取订单列表

 @param orderstate 0获取全部 10未付款 20已经付款 30已发货 40已经收货 50已经评价
 @param completed 回调
 */
+ (void)getOrderListWithOrderstate:(NSString *)orderstate completed:(completedBlock)completed;


/**
 编辑订单

 @param orderid 订单ID 购物车id,多个用 |隔开
 @param orderstate 操作 40收货操作 11取消订单操作
 @param completed 回调
 */
+ (void)editOrderWitOrderid:(NSString *)orderid orderstate:(NSString *)orderstate completed:(completedBlock)completed;


/**
 添加报纸订单

 @param paper_id 报纸id
 @param addressid 地址ID
 @param remark 留言
 @param paytype 支付方式 0支付宝 1微信
 @param completed 回调
 */
+ (void)addNewspaperOrderWithPaper_id:(NSString *)paper_id addressid:(NSString *)addressid remark:(NSString *)remark paytype:(NSString *)paytype completed:(completedBlock)completed;


/**
 重新支付

 @param orderno 订单号
 @param completed 回调
 */
+ (void)rePayOrderWithOrderno:(NSString *)orderno completed:(completedBlock)completed;

#pragma mark - 商品部分


/**
 获取商品类型

 @param completed 回调
 */
+ (void)getGoodTypeWithCompleted:(completedBlock)completed;

/**
 获取商品列表

 @param page 分页
 @param goodsname 搜索
 @param goodstypeid 类型id 首页@“” 
 @param sort 综合：goods.sort 价格 goods.goodsprice 销量 goods.salenum 好评：goods.sort
 @param sorttype 价格排序 desc asc
 @param ishome 是否首页 首页1 其他-1
 @param completed 回调
 */
+ (void)getGoodListWithPage:(NSString *)page goodsname:(NSString *)goodsname goodstypeid:(NSString *)goodstypeid sort:(NSString *)sort sorttype:(NSString *)sorttype ishome:(NSString *)ishome completed:(completedBlock)completed;

/**
 获取商品评价列表
 
 @param goods_id id
 @param content_type 0商品评价 1服务评价
 @param speak_type 0 好评1中频 2差评 -1全部 3有图
 @param completed 回调
 */
+ (void)getGoodCommentListWithGoods_id:(NSString *)goods_id content_type:(NSString *)content_type speak_type:(NSString *)speak_type completed:(completedBlock)completed;



/**
 编辑购物车

 @param ID 商品ID
 @param num 数量
 @param completed 回调
 */
+ (void)editShoppingCarWithID:(NSString *)ID num:(NSString *)num completed:(completedBlock)completed;


/**
 删除购物车

 @param ID 商品id,多个用 |隔开
 @param completed 回调
 */
+ (void)deleteShoppingCarWithProductID:(NSString *)ID completed:(completedBlock)completed;


/**
 获取免邮价格

 @param completed 回调
 */
+ (void)getEmailPriceWithCompleted:(completedBlock)completed;


/**
 服务评价

 @param content 内容
 @param starnum 星星
 @param pictures 多张图片用|隔开
 @param detail_id id
 @param completed 回调
 */
+ (void)commentServiceWithContent:(NSString *)content starnum:(NSString *)starnum pictures:(NSString *)pictures detail_id:(NSString *)detail_id completed:(completedBlock)completed;


/**
 商品评价

 @param speaklist json字符串 [{"content":"评价内容","starnum":"4","pictures":"","goods_id":"1"}]
 @param order_id 订单id
 @param completed 回调
 */
+ (void)commentProductWithSpeaklist:(NSString *)speaklist order_id:(NSString *)order_id completed:(completedBlock)completed;

#pragma mark - 我的


/**
 获取验证码

 @param type 类型 0 注册 1忘记密码
 @param mobile 手机号
 @param completed 回调
 */
+ (void)getVeriCodeWithType:(NSString *)type mobile:(NSString *)mobile completed:(completedBlock)completed;


/**
 用户注册

 @param account 账号
 @param code 验证码
 @param pwd 密码
 @param type 类型 0手机 1微信 2QQ 3微博
 @param name 用户名
 @param picture 头像
 @param completed 回调
 */
+ (void)userRegisterWithAccount:(NSString *)account code:(NSString *)code pwd:(NSString *)pwd type:(NSString *)type name:(NSString *)name picture:(NSString *)picture completed:(completedBlock)completed;


/**
 登录

 @param account 账号
 @param pwd 密码
 @param completed 回调
 */
+ (void)userLoginWithAccount:(NSString *)account pwd:(NSString *)pwd completed:(completedBlock)completed;


/**
 更新用户信息

 @param memberid 用户ID
 @param name 名字
 @param picture 头像 123.png
 @param sex 性别 1男 0女
 @param location 定位
 @param completed 回调
 */
+ (void)updateInfoWithMemberid:(NSString *)memberid name:(NSString *)name picture:(NSString *)picture sex:(NSString *)sex location:(NSString *)location completed:(completedBlock)completed;



/**
  获取用户信息

 @param completed 回调
 */
+ (void)getUserInfoWithCompleted:(completedBlock)completed;


/**
 获取用户地址

 @param completed 回调
 */
+ (void)getUserAddressWithCompleted:(completedBlock)completed;


/**
 添加用户地址

 @param name 收货人
 @param mobile 联系电话
 @param region 所在地区
 @param detail 详细地址
 @param isdefault 是否为默认地址
 @param completed 回调
 */
+ (void)addUserAddressWithName:(NSString *)name mobile:(NSString *)mobile region:(NSString *)region detail:(NSString *)detail isdefault:(NSString *)isdefault completed:(completedBlock)completed;


/**
 修改用户地址

 @param ID 地址ID
 @param name 收货人
 @param mobile 联系电话
 @param region 所在地区
 @param detail 详细地址
 @param isdefault 是否为默认地址
 @param completed 回调
 */
+ (void)updateUserAddressWithID:(NSString *)ID name:(NSString *)name mobile:(NSString *)mobile region:(NSString *)region detail:(NSString *)detail isdefault:(NSString *)isdefault completed:(completedBlock)completed;


/**
 删除用户地址

 @param ID 地址ID
 @param completed 回调
 */
+ (void)deleteUserAddressWithID:(NSString *)ID completed:(completedBlock)completed;


/**
 添加收藏

 @param collectid 商品ID
 @param type 类型 0资讯 1旅游 2美食 3服务 4农场品
 @param flag 0取消收藏 1收藏
 @param completed 回调
 */
+ (void)addCollectionWithCollectid:(NSString *)collectid type:(NSString *)type flag:(NSString *)flag completed:(completedBlock)completed;


/**
 获取默认地址

 @param completed 回调
 */
+ (void)getDefaultAddressWithCompleted:(completedBlock)completed;


/**
 获取我的订阅

 @param completed 回调
 */
+ (void)getMySubscriptionWithCompleted:(completedBlock)completed;


/**
 获取收藏信息

 @param collectid 收藏的物品id
 @param type 0资讯 1旅游 2美食 3服务 4农场品
 @param completed 回调
 */
+ (void)getCollectInfoWithCollectID:(NSString *)collectid type:(NSString *)type Completed:(completedBlock)completed;


/**
 点赞

 @param type 0 资讯 1旅游 2美食 3服务  4社区圈子 5评价内容 6内容评价  7步数
 @param detail_id id
 @param completed 回调
 */
+ (void)addPraiseWithType:(NSString *)type detail_id:(NSString *)detail_id completed:(completedBlock)completed;



/**
 获取收藏列表
 
 @param type 0资讯 1旅游 2美食 3服务 4商品
 @param completed 回调
 */
+ (void)getCollectionListWithType:(NSString *)type Completed:(completedBlock)completed;


/**
 意见反馈

 @param contact 账号
 @param content 内容
 @param completed 回调
 */
+ (void)feedBackWithContact:(NSString *)contact content:(NSString *)content completed:(completedBlock)completed;


/**
 修改密码

 @param oldpwd 旧密码
 @param newpwd 新密码
 @param completed 回调
 */
+ (void)updateUserPwdWithOldpwd:(NSString *)oldpwd newpwd:(NSString *)newpwd completed:(completedBlock)completed;


/**
 更新用户步数

 @param stepnum 步数
 @param completed 回调
 */
+ (void)updatUserStepWithStepnum:(NSString *)stepnum completed:(completedBlock)completed;


/**
 获取步数排行

 @param completed 回调
 */
+ (void)getStepRankWithCompleted:(completedBlock)completed;


/**
 购物车数量

 @param completed 回调
 */
+ (void)getShoppingCarNumWithCompleted:(completedBlock)completed;



/**
  我的优惠券

 @param completed 回调
 */
+ (void)getMyCouponListWithCompleted:(completedBlock)completed;



/**
 帮助中心列表

 @param completed 回调
 */
+ (void)getHelpCenterListWithCompleted:(completedBlock)completed;


/**
 忘记密码-重置密码

 @param account 账号
 @param code 验证码
 @param pwd 密码
 @param completed 回调
 */
+ (void)forgetPwdWithAccount:(NSString *)account code:(NSString *)code pwd:(NSString *)pwd completed:(completedBlock)completed;

#pragma mark - 社区论坛

/**
 获取圈子列表

 @param page 分页
 @param village_id 社区ID
 @param completed 回调
 */
+ (void)GetCircleListWithPage:(NSString *)page village_id:(NSString *)village_id completed:(completedBlock)completed;


/**
 发布动态

 @param content 内容
 @param pictures 图片 用|分割
 @param village_id 小区id
 @param completed 回调
 */
+ (void)postCircleWithContent:(NSString *)content pictures:(NSString *)pictures village_id:(NSString *)village_id completed:(completedBlock)completed;
@end
