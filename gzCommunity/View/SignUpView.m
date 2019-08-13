//
//  SignUpView.m
//  gzCommunity
//
//  Created by qige on 2019/8/12.
//  Copyright © 2019 qige. All rights reserved.
//

#import "SignUpView.h"

@interface SignUpView()

@property (nonatomic, weak) UILabel *unLabel;
@property (nonatomic, weak) UITextField *unTextField;

@property (nonatomic, weak) UILabel *passwordLabel;
@property (nonatomic, weak) UITextField *passwordTextField;

@property (nonatomic, weak) UIButton *signUpButton;

@end

@implementation SignUpView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        UILabel *unLabel = [[UILabel alloc] init];
        unLabel.font = [UIFont systemFontOfSize:14.0];
        unLabel.textAlignment = NSTextAlignmentRight;
        unLabel.text = @"用户名";
        [self addSubview:unLabel];
        _unLabel = unLabel;
        
        UITextField *unTextField = [[UITextField alloc] init];
        unTextField.font = [UIFont systemFontOfSize:14.0];
        unTextField.layer.borderColor = UIColor.redColor.CGColor;
        unTextField.layer.borderWidth = 1.0;
        unTextField.layer.cornerRadius = 2.0;
        unTextField.placeholder = @"请输入用户名";
        [self addSubview:unTextField];
        _unTextField = unTextField;
        
        UILabel *passwordLabel = [[UILabel alloc] init];
        passwordLabel.font = [UIFont systemFontOfSize:14.0];
        passwordLabel.textAlignment = NSTextAlignmentRight;
        passwordLabel.text = @"密码";
        [self addSubview:passwordLabel];
        _passwordLabel = passwordLabel;
        
        UITextField *passwordTextField = [[UITextField alloc] init];
        passwordTextField.font = [UIFont systemFontOfSize:14.0];
        passwordTextField.layer.borderColor = UIColor.redColor.CGColor;
        passwordTextField.layer.borderWidth = 1.0;
        passwordTextField.layer.cornerRadius = 2.0;
        passwordTextField.placeholder = @"请输入密码";
        [self addSubview:passwordTextField];
        _passwordTextField = passwordTextField;
        
        UIButton *signUpButton = [UIButton buttonWithType:UIButtonTypeCustom];
        signUpButton.backgroundColor = UIColor.redColor;
        [signUpButton setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        [signUpButton setTitle:@"注册" forState:UIControlStateNormal];
        [signUpButton addTarget:self action:@selector(signUpButtonClkick) forControlEvents:UIControlEventTouchUpInside];
        signUpButton.layer.cornerRadius = 4.0f;
        signUpButton.layer.masksToBounds = YES;
        [self addSubview:signUpButton];
        _signUpButton = signUpButton;
        
    }
    return self;
}


- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat width = self.bounds.size.width;
    CGFloat unlX = width * 0.1;
    CGFloat unlY = 108.0;
    CGFloat unlW = width * 0.2;
    CGFloat unlH = 32.0;
    self.unLabel.frame = CGRectMake(unlX, unlY, unlW, unlH);
    CGFloat untX = CGRectGetMaxX(self.unLabel.frame) + 4.0;
    CGFloat untY = unlY;
    CGFloat untW = width * 0.4;
    CGFloat untH = unlH;
    self.unTextField.frame = CGRectMake(untX, untY, untW, untH);
    CGFloat pwlX = width * 0.1;
    CGFloat pwlY = CGRectGetMaxY(self.unLabel.frame) + 12.0;
    CGFloat pwlW = width * 0.2;
    CGFloat pwlH = unlH;
    self.passwordLabel.frame = CGRectMake(pwlX, pwlY, pwlW, pwlH);
    CGFloat pwtX = CGRectGetMaxX(self.unLabel.frame) + 4.0;
    CGFloat pwtY = pwlY;
    CGFloat pwtW = width * 0.4;
    CGFloat pwtH = pwlH;
    self.passwordTextField.frame = CGRectMake(pwtX, pwtY, pwtW, pwtH);
    
    CGFloat lbX = 24.0;
    CGFloat lbY = CGRectGetMaxY(self.passwordTextField.frame) + 100.0;
    CGFloat lbW = width - lbX * 2;
    CGFloat lbH = 46.0;
    self.signUpButton.frame = CGRectMake(lbX, lbY, lbW, lbH);
}

- (void)signUpButtonClkick{
    if ([self.delegate respondsToSelector:@selector(signUpLoginEventWithUsername:password:)]) {
        NSString *username = self.unTextField.text;
        NSString *password = self.passwordTextField.text;
        [self.delegate signUpLoginEventWithUsername:username password:password];
    }
}

@end
