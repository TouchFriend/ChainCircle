//
//  FoundationTools.h
//  broadcast906
//
//  Created by 启辰 on 15/7/30.
//  Copyright (c) 2015年 启辰. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface FoundationTools : NSObject

#define IOS7_ONLY   (SJDeviceSystemMajorVersion() >= 7 && SJDeviceSystemMajorVersion() < 8)


long getLongInDict(NSDictionary* dict, NSString *key);

int getIntInDict(NSDictionary* dict, NSString *key);

NSNumber* getNumberInDict(NSDictionary* dict, NSString *key);

NSString* getStringInDict(NSDictionary* dict, NSString *key);

NSDictionary* getDictionaryInDict(NSDictionary* dict, NSString *key);

NSDate* getDateInDict(NSDictionary* dict, NSString *key);

NSArray* getArrayInDict(NSDictionary* dict, NSString *key);

float getFloatInDict(NSDictionary* dict,NSString *key);

double getDoubleInDict(NSDictionary* dict,NSString *key);

NSMutableArray* getMutableArrayInDict(NSDictionary* dict, NSString *key);

BOOL getBoolInDict(NSDictionary* dict,NSString *key);

NSString* dictionaryToJson(NSDictionary *dic);

@end
