//
//  NJLqcHeaderView.m
//  ChainCircle
//
//  Created by TouchWorld on 2018/5/31.
//  Copyright © 2018年 Redirect. All rights reserved.
//

#import "NJLqcHeaderView.h"
@interface NJLqcHeaderView ()
@property (weak, nonatomic) IBOutlet UIButton *receiveBtn;
- (IBAction)receiveBtnClick;

@end
@implementation NJLqcHeaderView

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self.receiveBtn addAllCornerRadius:4.0];
}


- (IBAction)receiveBtnClick {
}
@end
