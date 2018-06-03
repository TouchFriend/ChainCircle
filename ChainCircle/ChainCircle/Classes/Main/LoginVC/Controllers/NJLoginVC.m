//
//  NJLoginVC.m
//  ChainCircle
//
//  Created by TouchWorld on 2018/5/30.
//  Copyright © 2018年 Redirect. All rights reserved.
//

#import "NJLoginVC.h"
#import <MJExtension.h>
#import "NJUserItem.h"
#import "UIImage+NJImage.h"
#import <JPUSHService.h>
#import "NSString+NJNormal.h"

@interface NJLoginVC ()
@property (weak, nonatomic) IBOutlet UITextField *phoneNumTextF;
@property (weak, nonatomic) IBOutlet UITextField *verificationCodeTextF;
@property (weak, nonatomic) IBOutlet UIButton *getVeriCodeBtn;
- (IBAction)getVeriCodeBtnClick;
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
    [self setupNaviBar];
    
    NSDictionary * placeholderDic = @{
                                      NSFontAttributeName : [UIFont systemFontOfSize:14.0],
                                      NSForegroundColorAttributeName : NJGrayColor(136),
                                      };
    NSAttributedString * phoneNumAttr = [[NSAttributedString alloc] initWithString:@"请输入你的手机号码" attributes:placeholderDic];
    self.phoneNumTextF.attributedPlaceholder = phoneNumAttr;
    
    NSAttributedString * veriCodeAttr = [[NSAttributedString alloc] initWithString:@"输入验证码" attributes:placeholderDic];
    
    self.verificationCodeTextF.attributedPlaceholder = veriCodeAttr;
    
    [self.getVeriCodeBtn addAllCornerRadius:4.0];
    
    [self.loginBtn addAllCornerRadius:4.0];
    
    [self.getVeriCodeBtn setBackgroundImage:[UIImage imageWithColor:NJOrangeColor] forState:UIControlStateNormal];
    
    [self.getVeriCodeBtn setBackgroundImage:[UIImage imageWithColor:NJGrayColor(215)] forState:UIControlStateSelected];
    
    [self setupTimer];
}

#pragma mark - 导航条
- (void)setupNaviBar
{
    self.title = @"登录";
}

#pragma mark - 设置定时器
- (void)setupTimer
{
    UIApplication * app = [UIApplication sharedApplication];
    __block    UIBackgroundTaskIdentifier bgTask;
    bgTask = [app beginBackgroundTaskWithExpirationHandler:^{
        dispatch_async(dispatch_get_main_queue(), ^{
            if (bgTask != UIBackgroundTaskInvalid)
            {
                bgTask = UIBackgroundTaskInvalid;
            }
        });
    }];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            if (bgTask != UIBackgroundTaskInvalid)
            {
                bgTask = UIBackgroundTaskInvalid;
            }
        });
    });
}
//启动定时器
- (void)startTime
{
    __block int timeout = 60; //倒计时时间
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        
        if(timeout <= 0)
        { //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //定时结束后的UI处理
                self.getVeriCodeBtn.selected = NO;
                
                [self.getVeriCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
                self.getVeriCodeBtn.userInteractionEnabled = YES;
            });
        }
        else
        {
            NSLog(@"时间 = %d",timeout);
            NSString *strTime = [NSString stringWithFormat:@"发送验证码(%dS)",timeout];
            NSLog(@"strTime = %@",strTime);
            dispatch_async(dispatch_get_main_queue(), ^{
                //定时过程中的UI处理
                self.getVeriCodeBtn.selected = YES;
                self.getVeriCodeBtn.userInteractionEnabled = NO;
                
                NSString * titleStr = [[NSString alloc] initWithFormat:@"重新发送(%dS)", timeout];
                [self.getVeriCodeBtn setTitle:titleStr forState:UIControlStateNormal];
            });
            
            timeout--;
        }
    });
    dispatch_resume(_timer);
    
}




#pragma mark - 网络请求
//获取验证码
- (void)getVeriCode
{
    [SVProgressHUD show];
    
    [NetRequest getVeriCodeWithMobile:self.phoneNumTextF.text completed:^(id data, int flag) {
        [SVProgressHUD dismiss];
        if(flag == GetVeriCode)
        {
            if(getIntInDict(data, DictionaryKeyCode) == ResultTypeSuccess)
            {
                [self startTime];
            }
            else
            {
                
                [SVProgressHUD showErrorWithStatus:getStringInDict(data, DictionaryKeyData)];
                [SVProgressHUD dismissWithDelay:1.5];
            }
        }
    }];
}


- (void)userLoginRequest
{
    [SVProgressHUD show];
    [NetRequest userLoginWithAccount:self.phoneNumTextF.text code:self.verificationCodeTextF.text completed:^(id data, int flag) {
        [SVProgressHUD dismiss];
        if(flag == UserLogin)
        {
            if(getIntInDict(data, DictionaryKeyCode) == ResultTypeSuccess)
            {
                NSDictionary * dataDic = getDictionaryInDict(data, DictionaryKeyData);
                NJUserItem * userItem = [NJUserItem mj_objectWithKeyValues:dataDic];
                [NJLoginTool doLoginWithItem:userItem];
                
                [[NSNotificationCenter defaultCenter] postNotificationName:NotificationLoginSuccess object:nil];
                
                [self.view endEditing:YES];
                
                //绑定别名
                [self setAlias];
                [SVProgressHUD showSuccessWithStatus:@"登录成功"];
                
                [SVProgressHUD dismissWithDelay:1.0 completion:^{
                    if(self.isModal)
                    {
                        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
                    }
                    else
                    {
                        [self.navigationController popViewControllerAnimated:YES];
                    }
                    
                }];
            }
            else
            {
                
                [SVProgressHUD showErrorWithStatus:getStringInDict(data, DictionaryKeyData)];
                [SVProgressHUD dismissWithDelay:1.5];
            }
        }
    }];
}
#pragma mark - 事件
- (IBAction)getVeriCodeBtnClick {
    if(self.phoneNumTextF.text.length == 0)
    {
        [SVProgressHUD showErrorWithStatus:@"手机号不能为空"];
        [SVProgressHUD dismissWithDelay:1.5];
        return;
    }
    
    if(self.phoneNumTextF.text.length != 11)
    {
        [SVProgressHUD showErrorWithStatus:@"请检查所填号码是否有误"];
        [SVProgressHUD dismissWithDelay:1.5];
        return;
    }
    
    [self getVeriCode];
    
}

- (IBAction)loginBtnClick {
    if(self.phoneNumTextF.text.length == 0)
    {
        [SVProgressHUD showErrorWithStatus:@"请输入手机号"];
        [SVProgressHUD dismissWithDelay:1.5];
        return;
    }
    
    if(self.verificationCodeTextF.text.length == 0)
    {
        [SVProgressHUD showErrorWithStatus:@"请输入验证码"];
        [SVProgressHUD dismissWithDelay:1.5];
        return;
    }
    
    [self userLoginRequest];
}


    
#pragma mark - 其他
#pragma mark - 设置别名
- (void)setAlias
{
    //设置别名
    NJUserItem * userItem = [NJLoginTool getCurrentUser];
    if(userItem != nil && userItem.account.length > 0)
    {
        NSInteger seqIndex = 123;
        //添加别名
        [JPUSHService setAlias:userItem.account completion:^(NSInteger iResCode, NSString *iAlias, NSInteger seq) {
            if(seq == seqIndex)
            {
                if([iAlias isEqualToString:@"0"])
                {
                    NSLog(@"设置别名成功");
                }
            }
        } seq:seqIndex];
    }
}
    
@end
