//
//  NJViewController.h
//  SmartCity
//
//  Created by TouchWorld on 2018/3/30.
//  Copyright © 2018年 Redirect. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NJViewController : UIViewController



//modal登录界面
- (void)showLoginVCWithCompletion:(void (^ __nullable)(void))completion;


/**
 社交分享

 @param content 内容
 @param images 图片数组
 @param url 网址
 @param title 标题
 */
- (void)socialShareWithContent:(NSString *)content images:(NSArray *)images url:(NSString *)url title:(NSString *)title;


/**
 社交分享-保存到本地,更多

 @param content 内容
 @param images 图片数组
 @param url 网址
 @param title 标题
 */
- (void)socialShareLocalSaveWithContent:(NSString *)content images:(NSArray *)images url:(NSString *)url title:(NSString *)title;


/**
 社交分享-更多

 @param content 内容
 @param images 图片数组
 @param url 网址
 @param title 标题
 */
- (void)socialShareAndMoreWithContent:(NSString *)content images:(NSArray *)images url:(NSString *)url title:(NSString *)title;

/********* <#注释#> *********/
@property(nonatomic,copy)void (^customItemBlock)(NSInteger index);

@end
