//
//  NJPosterView.h
//  ChainCircle
//
//  Created by TouchWorld on 2018/6/5.
//  Copyright © 2018年 Redirect. All rights reserved.
//

#import <UIKit/UIKit.h>
@class NJPosterItem;
@interface NJPosterView : UIView
/********* <#注释#> *********/
@property(nonatomic,strong)NJPosterItem * item;

- (UIImage *)getShareImage;
@end
