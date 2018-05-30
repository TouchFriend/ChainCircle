//
//  UIImage+NJImage.h
//  June_nine_BuDeJie
//
//  Created by TouchWorld on 2017/6/10.
//  Copyright © 2017年 cxz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (NJImage)
//返回不被渲染的图片，更改图片的渲染模式
+ (UIImage *)imageOriginNamed:(NSString *)imageName;

- (UIImage *)NJOricalImage;

//处理成圆角图片
+ (UIImage *)NJOricalImageWithName:(NSString *)imageName;

//根据颜色生成图片
+ (UIImage *)imageWithColor:(UIColor *)color;
@end
