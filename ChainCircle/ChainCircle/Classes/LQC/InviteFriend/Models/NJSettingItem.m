//
//  NJSettingItem.m
//  ChainCircle
//
//  Created by TouchWorld on 2018/6/11.
//  Copyright © 2018年 Redirect. All rights reserved.
//

#import "NJSettingItem.h"

@implementation NJSettingItem
+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{
             @"ID" : @"id",
             @"desc" : @"description"
             };
}
@end
