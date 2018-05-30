//
//  NetAPIManager.m
//  ConsumptionPlus
//
//  Created by TouchWorld on 2017/10/26.
//  Copyright © 2017年 qichen. All rights reserved.
//

#import "NetAPIManager.h"
#import <AFNetworking.h>
#import <SVProgressHUD.h>
#import "NJUserItem.h"


@implementation NetAPIManager
static NetAPIManager * sharedManager = nil;
+ (instancetype)sharedManager
{
    if(sharedManager == nil)
    {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            sharedManager = [[NetAPIManager alloc]init];
        });
    }
    return sharedManager;
}

//添加用户ID
- (id)addUserID:(id)parameters
{
    if(parameters == nil)
    {
        parameters = [NSDictionary dictionary];
    }
    
    NSString * userID = [NJLoginTool getUserID];
    NSMutableDictionary * parametersDicM = [NSMutableDictionary dictionaryWithDictionary:parameters];
    if(userID != nil && userID.length > 0)
    {
        
        parametersDicM[@"memberid"] = userID;
    }
    
    return parametersDicM;
    
}

/**
 Get方法

 @param path url路径
 @param parameters 参数
 @param completed 回调函数
 */
- (void)Get:(NSString *)path parameters:(id)parameters andBlock:(ReturnBlock) completed{
    if (!path || [path isEqualToString:@""]) {
        return;
    }
    
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",  nil];
    NSString * URLString = [NJUrlPrefix stringByAppendingPathComponent:path];
    NJLog(@"%@",URLString);
    
    //添加userID
    parameters = [self addUserID:parameters];
    
    
    //打印地址和参数
    [self logUrlAndParameters:URLString parameterDic:parameters];
    
    //发送get请求
    [manager GET:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        completed(responseObject, nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSDictionary * dic = @{@"code":@"99",@"data":@"哎呀,网络好像不给力,请重试",@"Info":@""};
        NJLog(@"错误：%@",error.localizedDescription);
        completed(dic,error);
        [self postNetworkErrorNotification];
    }];

}

/**
 Post方法

 @param path 路径
 @param parameters 参数
 @param completed 回调函数
 */
- (void)Post:(NSString *)path parameters:(id)parameters completed:(ReturnBlock)completed
{
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",  nil];
    NSString * urlString = [NJUrlPrefix stringByAppendingPathComponent:path];
    NJLog(@"%@",urlString);
    
    //添加userID
    parameters = [self addUserID:parameters];
    
    
    //打印地址和参数
    [self logUrlAndParameters:urlString parameterDic:parameters];
    
    
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if(getIntInDict(responseObject, @"code") == 10)//账号在其他设备登陆
        {
            [self postNotification];
        }
        completed(responseObject, nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSDictionary * dic = @{@"code":@"99",@"data":@"哎呀,网络好像不给力,请重试",@"Info":@""};
        NJLog(@"错误：%@",error);
        completed(dic, error);
        [self postNetworkErrorNotification];
    }];
}

/**
 Post方法全路径
 
 @param urlString 地址
 @param parameters 参数
 @param completed 回调函数
 */
- (void)PostFullPath:(NSString *)urlString parameters:(id)parameters completed:(ReturnBlock)completed
{
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",  nil];
    NJLog(@"%@",urlString);
    
    //添加userID
//    parameters = [self addUserID:parameters];
    
    
    //打印地址和参数
    [self logUrlAndParameters:urlString parameterDic:parameters];
    
    
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if(getIntInDict(responseObject, @"code") == 10)//账号在其他设备登陆
        {
            [self postNotification];
        }
        completed(responseObject, nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSDictionary * dic = @{@"code":@"99",@"data":@"哎呀,网络好像不给力,请重试",@"Info":@""};
        NJLog(@"错误：%@",error);
        completed(dic, error);
        [self postNetworkErrorNotification];
    }];
}


//下载文件
+ (void)downloadFileWithUrl:(NSURL *)url savePath:(NSString *)savePath progress:(void (^)(NSProgress *downloadProgress)) downloadProgressBlock completionHandler:(void (^)(NSURLResponse *response, NSURL *filePath, NSError *error))completionHandler
{
    if(url == nil)
    {
        NSLog(@"下载url为空");
        return;
    }
    NSURLSessionConfiguration * config = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager * manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:config];
    NSURLRequest * request = [NSURLRequest requestWithURL:url];
    NSURLSessionDownloadTask * downloadTask = [manager downloadTaskWithRequest:request progress:downloadProgressBlock destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        
        if(savePath != nil)
        {
            return [NSURL fileURLWithPath:savePath];
        }
        //默认存储路径
        //document目录
        NSURL * documentDirUrl = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
        return  [documentDirUrl URLByAppendingPathComponent:[response suggestedFilename]];
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        if(error == nil)
        {
            NSLog(@"File downloaded to: %@", filePath);
        }
        else
        {
            NSLog(@"下载出错：%@",[error localizedDescription]);
        }
        completionHandler(response, filePath, error);
    }];
    [downloadTask resume];
}
//发布账号在其他地方登陆通知
- (void)postNotification
{
    [[NSNotificationCenter defaultCenter] postNotificationName:NJTokenChangeNotification object:nil];
}
//发布网络错误通知
- (void)postNetworkErrorNotification
{
    [[NSNotificationCenter defaultCenter] postNotificationName:NotificationNetworkError object:nil];
}

- (void)logUrlAndParameters:(NSString *)urlStr parameterDic:(NSDictionary *)parameterDic
{
    urlStr = [urlStr stringByAppendingString:@"?"];
    for (NSString * dicKey in parameterDic.allKeys) {
        NSString * dicValue =  parameterDic[dicKey];
        
        urlStr = [urlStr stringByAppendingString:[NSString stringWithFormat:@"%@=%@&", dicKey, dicValue]];
    }
    
    NSLog(@"地址和参数：%@", [urlStr substringToIndex:urlStr.length - 1]);
}

@end
