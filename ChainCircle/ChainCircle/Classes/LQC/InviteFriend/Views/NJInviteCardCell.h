//
//  NJInviteCardCell.h
//  ChainCircle
//
//  Created by TouchWorld on 2018/6/5.
//  Copyright © 2018年 Redirect. All rights reserved.
//

#import <UIKit/UIKit.h>
@class NJPosterItem;
@interface NJInviteCardCell : UICollectionViewCell
/********* <#注释#> *********/
@property(nonatomic,strong)NJPosterItem * item;

/********* <#注释#> *********/
@property(nonatomic,assign)NSInteger invitedNum;


- (UIImage *)getShareImage;
@end
