//
//  NJLoginVC.m
//  ChainCircle
//
//  Created by TouchWorld on 2018/5/30.
//  Copyright © 2018年 Redirect. All rights reserved.
//

#import "NJLoginVC.h"

@interface NJLoginVC ()
@property (weak, nonatomic) IBOutlet UITextField *phoneNumTextF;
@property (weak, nonatomic) IBOutlet UITextField *verificationCodeTextF;
@property (weak, nonatomic) IBOutlet UIButton *timeBtn;
- (IBAction)timeBtnClick;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
- (IBAction)loginBtnClick;

@end

@implementation NJLoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setupInit];
}

#pragma mark - 设置初始化
- (void)setupInit
{
    NSDictionary * placeholderDic = @{
                                      NSFontAttributeName : [UIFont systemFontOfSize:14.0],
                                      NSForegroundColorAttributeName : NJGrayColor(136),
                                      };
    NSAttributedString * phoneNumAttr = [[NSAttributedString alloc] initWithString:@"请输入你的手机号码" attributes:placeholderDic];
    self.phoneNumTextF.attributedPlaceholder = phoneNumAttr;
    
    NSAttributedString * veriCodeAttr = [[NSAttributedString alloc] initWithString:@"输入验证码" attributes:placeholderDic];
    
    self.verificationCodeTextF.attributedPlaceholder = veriCodeAttr;
    
    [self.timeBtn addAllCornerRadius:4.0];
    
    [self.loginBtn addAllCornerRadius:4.0];
}

- (IBAction)timeBtnClick {
}
- (IBAction)loginBtnClick {
}
@end
