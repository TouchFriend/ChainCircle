//
//  NJInviteRecordHeaderView.h
//  ChainCircle
//
//  Created by TouchWorld on 2018/5/31.
//  Copyright © 2018年 Redirect. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NJInviteRecordHeaderView : UITableViewHeaderFooterView
/********* <#注释#> *********/
@property(nonatomic,copy)void (^myInviteBlock)(void);

@end
