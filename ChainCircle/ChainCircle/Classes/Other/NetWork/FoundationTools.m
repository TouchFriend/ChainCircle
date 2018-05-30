//
//  FoundationTools.m
//  broadcast906
//
//  Created by 启辰 on 15/7/30.
//  Copyright (c) 2015年 启辰. All rights reserved.
//

#import "FoundationTools.h"
#import <CommonCrypto/CommonDigest.h>

@implementation FoundationTools

long getLongInDict(NSDictionary* dict, NSString *key)
{
    id tmp = getNumberInDict(dict, key);
    if (tmp)
    {
        return [tmp longValue];
    }
    
    tmp = getStringInDict(dict, key);
    if (tmp)
    {
        return [tmp longValue];
    }
    
    return 0;
}

int getIntInDict(NSDictionary* dict, NSString *key)
{
    id tmp = getNumberInDict(dict, key);
    if (tmp)
    {
        return [tmp integerValue];
    }
    
    tmp = getStringInDict(dict, key);
    if (tmp)
    {
        return [tmp integerValue];
    }
    
    return 0;
}

NSNumber* getNumberInDict(NSDictionary* dict, NSString *key)
{
    return getDataInDict(dict, key, [NSNumber class]);
}

NSString* getStringInDict(NSDictionary* dict, NSString *key)
{
    return getDataInDict(dict, key, [NSString class]);
}

NSDictionary* getDictionaryInDict(NSDictionary* dict, NSString *key)
{
    return getDataInDict(dict, key, [NSDictionary class]);
}

NSArray* getArrayInDict(NSDictionary* dict, NSString *key)
{
    return getDataInDict(dict, key, [NSArray class]);
}

NSMutableArray* getMutableArrayInDict(NSDictionary* dict, NSString *key)
{
    return getDataInDict(dict, key, [NSMutableArray class]);
}

NSDate* getDateInDict(NSDictionary* dict, NSString *key)
{
    return getDataInDict(dict, key, [NSDate class]);
}

BOOL getBoolInDict(NSDictionary* dict,NSString *key)
{
    id tmp = getNumberInDict(dict, key);
    if (tmp)
    {
        return [tmp boolValue];
    }
    
    tmp = getStringInDict(dict, key);
    if (tmp)
    {
        return [tmp boolValue];
    }
    
    return 0;
}

float getFloatInDict(NSDictionary* dict,NSString *key)
{
    id tmp = getNumberInDict(dict, key);
    if (tmp)
    {
        return [tmp floatValue];
    }
    
    tmp = getStringInDict(dict, key);
    if (tmp)
    {
        return [tmp floatValue];
    }
    
    return 0;
    
    //    return [getDataInDict(dict,key,[NSNumber class]) floatValue];
}

double getDoubleInDict(NSDictionary* dict,NSString *key)
{
    id tmp = getNumberInDict(dict, key);
    if (tmp)
    {
        return [tmp doubleValue];
    }
    
    tmp = getStringInDict(dict, key);
    if (tmp)
    {
        return [tmp doubleValue];
    }
    return 0;

}

id getDataInDict(NSDictionary* dict, NSString *key, Class class)
{
    if (![dict isKindOfClass:[NSDictionary class]])
    {
        return nil;
    }
    
    id temp = [dict objectForKey:key];
    
    if ([temp isKindOfClass:class])
    {
        return temp;
    }
    return nil;
}

NSString* dictionaryToJson(NSDictionary *dic) {
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

@end
