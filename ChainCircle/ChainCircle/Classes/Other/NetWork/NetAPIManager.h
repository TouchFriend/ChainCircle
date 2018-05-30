//
//  NetAPIManager.h
//  ConsumptionPlus
//
//  Created by TouchWorld on 2017/10/26.
//  Copyright © 2017年 qichen. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^ReturnBlock)(id data, NSError * error);

@interface NetAPIManager : NSObject

//单粒方法
+ (instancetype)sharedManager;
//Get方法
- (void)Get:(NSString *)path parameters:(id)parameters andBlock:(ReturnBlock) completed;
//Post方法
- (void)Post:(NSString *)path parameters:(id)parameters completed:(ReturnBlock)completed;

//Post方法全路径
- (void)PostFullPath:(NSString *)urlString parameters:(id)parameters completed:(ReturnBlock)completed;
/**
 下载文件
 
 @param url 网址
 @param savePath 保存路径 默认document
 @param downloadProgressBlock 进度回调
 @param completionHandler 完成回调
 */
+ (void)downloadFileWithUrl:(NSURL *)url savePath:(NSString *)savePath progress:(void (^)(NSProgress *downloadProgress)) downloadProgressBlock completionHandler:(void (^)(NSURLResponse *response, NSURL *filePath, NSError *error))completionHandler;
@end
