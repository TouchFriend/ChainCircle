//
//  NJRecordItem.m
//  ChainCircle
//
//  Created by TouchWorld on 2018/6/11.
//  Copyright © 2018年 Redirect. All rights reserved.
//

#import "NJRecordItem.h"
#import "NSString+NJNormal.h"

@implementation NJRecordItem

- (void)setCreated_at:(NSString *)created_at
{
    _created_at = created_at;
    NSString * formatterStr = [created_at changeTimeStrFormatterFromFormatter:@"yyyy-MM-dd HH:mm:ss" toFormatter:@"yyyy-MM-dd"];
    _formatterStr = formatterStr;
}
@end
