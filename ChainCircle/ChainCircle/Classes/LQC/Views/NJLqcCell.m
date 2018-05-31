//
//  NJLqcCell.m
//  ChainCircle
//
//  Created by TouchWorld on 2018/5/31.
//  Copyright © 2018年 Redirect. All rights reserved.
//

#import "NJLqcCell.h"
@interface NJLqcCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconImageV;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end
@implementation NJLqcCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setDataDic:(NSDictionary *)dataDic
{
    _dataDic = dataDic;
    
    self.iconImageV.image = [UIImage imageNamed:dataDic[@"icon"]];
    
    self.titleLabel.text = dataDic[@"title"];
}
@end
