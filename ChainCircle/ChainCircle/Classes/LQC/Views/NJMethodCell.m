//
//  NJMethodCell.m
//  ChainCircle
//
//  Created by TouchWorld on 2018/5/31.
//  Copyright © 2018年 Redirect. All rights reserved.
//

#import "NJMethodCell.h"
@interface NJMethodCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;


@end
@implementation NJMethodCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setTitleStr:(NSString *)titleStr
{
    _titleStr = titleStr;
    self.titleLabel.text = titleStr;
}

- (void)setFrame:(CGRect)frame
{
    frame.size.height -=2;
    [super setFrame:frame];
}
@end
