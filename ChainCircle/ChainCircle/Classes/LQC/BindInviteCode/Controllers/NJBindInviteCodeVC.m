//
//  NJBindInviteCodeVC.m
//  ChainCircle
//
//  Created by TouchWorld on 2018/5/31.
//  Copyright © 2018年 Redirect. All rights reserved.
//

#import "NJBindInviteCodeVC.h"
#import "NJUserItem.h"
#import "UIImage+NJImage.h"
#import <MJExtension.h>
#import "NJSettingItem.h"

@interface NJBindInviteCodeVC ()
/********* <#注释#> *********/
@property(nonatomic,weak)UITextField * inviteTextF;

/********* <#注释#> *********/
@property(nonatomic,strong)NSArray<NJSettingItem *> * settingArr;

/********* <#注释#> *********/
@property(nonatomic,weak)UILabel * titleLabel;
@end

@implementation NJBindInviteCodeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupInit];
}

#pragma mark - 设置初始化
- (void)setupInit
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupNaviBar];
    
    [self setupContent];
    
    [self getSettingRequest];
}

#pragma mark - 导航条
- (void)setupNaviBar
{
    self.title = @"绑定邀请码";
}

#pragma mark - content
- (void)setupContent
{
    NJUserItem * userItem = [NJLoginTool getCurrentUser];
    
    
    UIView * seperatorView = [[UIView alloc] init];
    [self.view addSubview:seperatorView];
    [seperatorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(self.view);
        make.height.mas_equalTo(1);
    }];
    seperatorView.backgroundColor = NJGrayColor(223);
    
    UILabel * titleLabel = [[UILabel alloc] init];
    [self.view addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(seperatorView.mas_bottom).mas_offset(15);
        make.left.mas_equalTo(self.view).mas_equalTo(15);
        make.right.mas_equalTo(self.view).mas_equalTo(-15);
        make.height.mas_equalTo(20);
    }];
    
    self.titleLabel = titleLabel;
    titleLabel.text = @"新用户绑定朋友邀请码获得LQC";
    titleLabel.textColor = NJGrayColor(106);
    titleLabel.font = [UIFont systemFontOfSize:14.0];
    
    UITextField * inviteTextF = [[UITextField alloc] init];
    [self.view addSubview:inviteTextF];
    [inviteTextF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(titleLabel.mas_bottom).mas_offset(10);
        make.left.mas_equalTo(self.view).mas_offset(15);
        make.right.mas_equalTo(self.view).mas_equalTo(-15.0);
        make.height.mas_equalTo(42);
    }];
    self.inviteTextF = inviteTextF;
    inviteTextF.backgroundColor = NJGrayColor(223);
    inviteTextF.borderStyle = UITextBorderStyleRoundedRect;
    inviteTextF.keyboardType = UIKeyboardTypeNumberPad;
    
    NSDictionary * placeholderDic = @{
                                      NSFontAttributeName : [UIFont systemFontOfSize:14.0],
                                      NSForegroundColorAttributeName : NJGrayColor(136),
                                      };
    NSAttributedString * inviteAttr = [[NSAttributedString alloc] initWithString:@"请输入你的邀请码" attributes:placeholderDic];
    inviteTextF.attributedPlaceholder = inviteAttr;
    
    
    
    
    UIButton * bindBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:bindBtn];
    [bindBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(inviteTextF.mas_bottom).mas_offset(15.0);
        make.left.mas_equalTo(self.view).mas_offset(15);
        make.right.mas_equalTo(self.view).mas_equalTo(-15.0);
        make.height.mas_equalTo(42);
    }];
    
//    bindBtn.backgroundColor = NJOrangeColor;
    [bindBtn setTitle:@"绑定" forState:UIControlStateNormal];
    [bindBtn setTitle:@"已绑定" forState:UIControlStateDisabled];
    [bindBtn setBackgroundImage:[UIImage imageWithColor:NJOrangeColor] forState:UIControlStateNormal];
    [bindBtn setBackgroundImage:[UIImage imageWithColor:NJGrayColor(136)] forState:UIControlStateDisabled];
    [bindBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [bindBtn addTarget:self action:@selector(bindBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [bindBtn addAllCornerRadius:4.0];
    
    
    if(userItem.father_code != nil && userItem.father_code.length > 0)
    {
        inviteTextF.text = userItem.father_code;
        inviteTextF.enabled = NO;
        bindBtn.enabled = NO;
    }
}


- (void)bindBtnClick
{
    if(self.inviteTextF.text.length == 0)
    {
        [SVProgressHUD showErrorWithStatus:@"请输入邀请码"];
        [SVProgressHUD dismissWithDelay:1.2];
        return;
    }
    
    [self bindCodeRequest];
}

#pragma mark - 网络请求
- (void)loadDatas
{

}

- (void)bindCodeRequest
{
    [SVProgressHUD show];
    [NetRequest bindFriendCodeWithInvite_code:self.inviteTextF.text completed:^(id data, int flag) {
        [SVProgressHUD dismiss];
        if(flag == BindeFriendCode)
        {
            if(getIntInDict(data, DictionaryKeyCode) == ResultTypeSuccess)
            {
                [SVProgressHUD showSuccessWithStatus:getStringInDict(data, DictionaryKeyData)];
                [SVProgressHUD dismissWithDelay:1.2 completion:^{
                    [self.navigationController popViewControllerAnimated:YES];
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


//获取配置
- (void)getSettingRequest
{
    [NetRequest getSettingWithCompleted:^(id data, int flag) {
        if(flag == GetSetting)
        {
            if(getIntInDict(data, DictionaryKeyCode) == ResultTypeSuccess)
            {
                NSArray * dataArr = getArrayInDict(data, DictionaryKeyData);
                self.settingArr = [NJSettingItem mj_objectArrayWithKeyValuesArray:dataArr];
                
                if(self.settingArr.count == 0)
                {
                    return ;
                }
                
                NSInteger bandFriendNum = 0;
                for (NJSettingItem * item in self.settingArr) {
                    if([item.name isEqualToString:@"band_lqc_user"])
                    {
                        bandFriendNum = item.value.integerValue;
                    }
                
                }
                
                self.titleLabel.text = [NSString stringWithFormat:@"新用户绑定朋友邀请码获得%ldLQC", bandFriendNum];
                
            }
            else
            {
                
                [SVProgressHUD showErrorWithStatus:getStringInDict(data, DictionaryKeyData)];
                [SVProgressHUD dismissWithDelay:1.5];
            }
        }
    }];
}
#pragma mark - 懒加载
- (NSArray<NJSettingItem *> *)settingArr
{
    if(_settingArr == nil)
    {
        _settingArr = [NSArray array];
    }
    return _settingArr;
}
@end
