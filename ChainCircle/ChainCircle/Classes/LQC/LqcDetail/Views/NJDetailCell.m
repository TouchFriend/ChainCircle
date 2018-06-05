//
//  NJDetailCell.m
//  ChainCircle
//
//  Created by TouchWorld on 2018/6/5.
//  Copyright © 2018年 Redirect. All rights reserved.
//

#import "NJDetailCell.h"

@implementation NJDetailCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



- (void)setFrame:(CGRect)frame
{
    frame.size.height -= 1;
    [super setFrame:frame];
}
@end
