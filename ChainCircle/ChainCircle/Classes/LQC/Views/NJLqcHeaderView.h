//
//  NJLqcHeaderView.h
//  ChainCircle
//
//  Created by TouchWorld on 2018/5/31.
//  Copyright © 2018年 Redirect. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NJLqcHeaderView : UICollectionReusableView

/********* <#注释#> *********/
@property(nonatomic,copy)void (^receiveBlock)(void);

@property (weak, nonatomic) IBOutlet UILabel *canReceiveNumLabel;

/********* 标题数据 *********/
@property(nonatomic,strong)NSArray<NSString *> * titleArr;

/********* <#注释#> *********/
@property(nonatomic,copy)void (^posterBlock)(void);

/********* <#注释#> *********/
@property(nonatomic,copy)void (^adBlock)(NSInteger index);


@end
