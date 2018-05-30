//
//  NJPayTool.h
//  SmartCity
//
//  Created by TouchWorld on 2018/5/8.
//  Copyright © 2018年 Redirect. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NJPayTool : NSObject
+ (instancetype)shareInstance;


/**
 支付宝

 @param orderStr 订单信息
 */
- (void)alipayWithOrderStr:(NSString *)orderStr;


/**
 微信支付

 @param dataDic 订单信息
 */
- (void)weixinPayWithOrderInfo:(NSDictionary *)dataDic;
@end
