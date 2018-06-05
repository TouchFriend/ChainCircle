//
//  NJDetailCell.m
//  ChainCircle
//
//  Created by TouchWorld on 2018/6/5.
//  Copyright © 2018年 Redirect. All rights reserved.
//

#import "NJDetailCell.h"
#import "NJDetailItem.h"
@interface NJDetailCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *numLabel;

@end
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

- (void)setItem:(NJDetailItem *)item
{
    _item = item;
    
    self.titleLabel.text = item.content;
    
    self.dateLabel.text = item.created_at;
    
    NSString * preStr = item.type.integerValue == 0 ? @"+" : @"-";
    self.numLabel.text = [preStr stringByAppendingString:item.lqc_num];
}
@end
