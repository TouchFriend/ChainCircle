//
//  NJMethodCell.h
//  ChainCircle
//
//  Created by TouchWorld on 2018/5/31.
//  Copyright © 2018年 Redirect. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NJMethodCell : UITableViewCell
/********* <#注释#> *********/
@property(nonatomic,strong)NSDictionary * dataDic;

/********* <#注释#> *********/
@property(nonatomic,copy)void (^signInBlock)(void);

@end
