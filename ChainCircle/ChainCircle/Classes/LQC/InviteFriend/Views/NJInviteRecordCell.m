//
//  NJInviteRecordCell.m
//  ChainCircle
//
//  Created by TouchWorld on 2018/5/31.
//  Copyright © 2018年 Redirect. All rights reserved.
//

#import "NJInviteRecordCell.h"
#import "NJRecordItem.h"
@interface NJInviteRecordCell ()
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *accountLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *numLabel;

@end
@implementation NJInviteRecordCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)setFrame:(CGRect)frame
{
    frame.origin.x = 15;
    frame.size.width -= 30;
    [super setFrame:frame];
}


- (void)setItem:(NJRecordItem *)item
{
    _item = item;
    
    self.dateLabel.text = item.created_at;
    self.accountLabel.text = item.account;
    self.contentLabel.text = item.content;
    self.numLabel.text = item.lqc_num;
}
@end
