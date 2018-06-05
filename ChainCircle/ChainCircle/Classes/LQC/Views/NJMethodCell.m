//
//  NJMethodCell.m
//  ChainCircle
//
//  Created by TouchWorld on 2018/5/31.
//  Copyright © 2018年 Redirect. All rights reserved.
//

#import "NJMethodCell.h"
#import "UIImage+NJImage.h"

@interface NJMethodCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *signInBtn;

- (IBAction)signInBtnClick;
@property (weak, nonatomic) IBOutlet UIImageView *nextImageV;

@end
@implementation NJMethodCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [self.signInBtn addAllCornerRadius:4.0];
    [self.signInBtn setBackgroundImage:[UIImage imageWithColor:NJOrangeColor] forState:UIControlStateNormal];
    [self.signInBtn setBackgroundImage:[UIImage imageWithColor:NJGrayColor(200)] forState:UIControlStateSelected];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setDataDic:(NSDictionary *)dataDic
{
    _dataDic = dataDic;
    
    self.titleLabel.text = dataDic[@"title"];
    NSNumber * isBtnNum = dataDic[@"isBtn"];
    
    self.nextImageV.hidden = isBtnNum.boolValue;
    self.signInBtn.hidden = !isBtnNum.boolValue;
    
    if(isBtnNum.boolValue)
    {
        NSNumber * isSignNum = dataDic[@"isSign"];
        self.signInBtn.selected = isSignNum.integerValue == 1;
    }
    
    
}

- (void)setFrame:(CGRect)frame
{
    frame.size.height -=2;
    [super setFrame:frame];
}
- (IBAction)signInBtnClick {
    if(self.signInBtn.selected)
    {
        return;
    }
    
    if(self.signInBlock != nil)
    {
        self.signInBlock();
    }
}
@end
