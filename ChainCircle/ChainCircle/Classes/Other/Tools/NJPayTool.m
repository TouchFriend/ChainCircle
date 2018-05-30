//
//  NJPayTool.m
//  SmartCity
//
//  Created by TouchWorld on 2018/5/8.
//  Copyright © 2018年 Redirect. All rights reserved.
//

#import "NJPayTool.h"
//#import <AlipaySDK/AlipaySDK.h>
//#import <WXApi.h>

#define AlipayFromScheme @"SmartCity"
@implementation NJPayTool
static NJPayTool * payTool;
+ (instancetype)shareInstance
{
    if(payTool == nil)
    {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            payTool = [[NJPayTool alloc] init];
        });
    }
    return payTool;
}

//#pragma mark - 支付宝支付
//- (void)alipayWithOrderStr:(NSString *)orderStr
//{
//    NJLog(@"Alipay:%@",orderStr);
//    [[AlipaySDK defaultService] payOrder:orderStr fromScheme:AlipayFromScheme callback:^(NSDictionary *resultDic) {
//        NSLog(@"%@", resultDic);
//
//        switch ([resultDic[@"resultStatus"] integerValue])
//        {
//            case 9000:
//            {
//                //                        [self showHudTipStr:@"订单支付成功"];
//                NSDictionary * dic = @{
//                                       DictionaryKeyPayType : @"1",
//                                       DictionarykeyPayResult : @"0",
//
//                                       };
//
//                [[NSNotificationCenter defaultCenter] postNotificationName:Notification_PayStyle object:dic];
//            }
//            break;
//            case 8000:
//            //                        [self showHudTipStr:@"正在处理中"];
//            break;
//            case 4000:
//            {
//                //                        [self showHudTipStr:@"订单支付失败"];
//                NSDictionary * dic = @{
//                                       DictionaryKeyPayType : @"1",
//                                       DictionarykeyPayResult : @"-1",
//
//                                       };
//
//                [[NSNotificationCenter defaultCenter] postNotificationName:Notification_PayStyle object:dic];
//            }
//            break;
//            case 6001:
//            {
//                //                        [self showHudTipStr:@"订单支付取消"];
//                NSDictionary * dic = @{
//                                       DictionaryKeyPayType : @"1",
//                                       DictionarykeyPayResult : @"-1",
//
//                                       };
//
//                [[NSNotificationCenter defaultCenter] postNotificationName:Notification_PayStyle object:dic];
//            }
//            break;
//            case 6002:
//            {
//                //                        [self showHudTipStr:@"网络连接出错"];
//                NSDictionary * dic = @{
//                                       DictionaryKeyPayType : @"1",
//                                       DictionarykeyPayResult : @"-1",
//
//                                       };
//
//                [[NSNotificationCenter defaultCenter] postNotificationName:Notification_PayStyle object:dic];
//            }
//            break;
//            default:
//            {
//                [SVProgressHUD showErrorWithStatus:@"支付失败"];
//                [SVProgressHUD dismissWithDelay:1.5];
//            }
//            break;
//        }
//    }];
//}
//
//#pragma mark - 微信支付
//- (void)weixinPayWithOrderInfo:(NSDictionary *)dataDic
//{
//    NJLog(@"weixinPayOrderInfo:%@", dataDic);
//
//    if(![WXApi isWXAppInstalled])
//    {
//        [SVProgressHUD showErrorWithStatus:@"未安装微信"];
//        [SVProgressHUD dismissWithDelay:1.5];
//        return;
//    }
//    PayReq * req = [[PayReq alloc] init];
//
//    req.partnerId = dataDic[@"partnerid"];
//    req.prepayId = dataDic[@"prepayid"];
//    req.nonceStr = dataDic[@"noncestr"];
//    req.timeStamp = [dataDic[@"timestamp"] intValue];
//    req.package = dataDic[@"package"];
//    req.sign = dataDic[@"sign"];
//    /*! @brief 发送请求到微信，等待微信返回onResp
//     *
//     * 函数调用后，会切换到微信的界面。第三方应用程序等待微信返回onResp。微信在异步处理完成后一定会调用onResp。支持以下类型
//     * SendAuthReq、SendMessageToWXReq、PayReq等。
//     * @param req 具体的发送请求，在调用函数后，请自己释放。
//     * @return 成功返回YES，失败返回NO。
//     */
//    [WXApi sendReq:req];
//}

@end
