//
//  NJInviteRecordHeaderView.h
//  ChainCircle
//
//  Created by TouchWorld on 2018/5/31.
//  Copyright © 2018年 Redirect. All rights reserved.
//

#import <UIKit/UIKit.h>
@class NJSettingItem;
@interface NJInviteRecordHeaderView : UITableViewHeaderFooterView
/********* <#注释#> *********/
@property(nonatomic,copy)void (^myInviteBlock)(void);

/********* <#注释#> *********/
@property(nonatomic,assign)NSInteger invitedNum;

/********* <#注释#> *********/
@property(nonatomic,strong)NSArray<NJSettingItem *> * settingArr;
@end
