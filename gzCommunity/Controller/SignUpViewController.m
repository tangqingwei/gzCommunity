//
//  SignUpViewController.m
//  gzCommunity
//
//  Created by qige on 2019/8/12.
//  Copyright © 2019 qige. All rights reserved.
//

#import "SignUpViewController.h"
#import "SignUpView.h"

@interface SignUpViewController ()<SignUpViewDelegate>

@end

@implementation SignUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"注册";
    self.view.backgroundColor = UIColor.whiteColor;
    
    SignUpView *signUpView = [[SignUpView alloc] initWithFrame:self.view.bounds];
    signUpView.delegate = self;
    [self.view addSubview:signUpView];
}

#pragma mark - SignUpViewDelegate
- (void)signUpLoginEventWithUsername:(NSString *)username password:(NSString *)password{
    if (username.length == 0) {
        [SVProgressHUD schenleyShowInfoWithText:@"用户名不能为空"];
        return;
    }
    if (password.length == 0) {
        [SVProgressHUD schenleyShowInfoWithText:@"密码不能为空"];
        return;
    }
    NSMutableDictionary *parameters = [NSMutableDictionary parameters];
    parameters[@"username"] = username;
    parameters[@"password"] = password;
    parameters[@"isValidation"] = @1;
    parameters[@"email"] = @"";
    [[AFNetworkingSchenley sharedInstance] requestWithPOST:REQUEST_URL(@"/mobcent/app/web/index.php?r=user/register") parameters:parameters success:^(NSData *responseObject) {
        NSDictionary *rootDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        NSLog(@"%@",rootDic);
        if ([rootDic[@"head"][@"errCode"] intValue] == 0) {
            [self.navigationController popViewControllerAnimated:YES];
            for (UIViewController *vc in self.navigationController.childViewControllers) {
                if ([vc isKindOfClass:NSClassFromString(@"RootViewController")]) {
                    [self.navigationController popToViewController:vc animated:YES];
                }
            }
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            NSDictionary *dic = [NSDictionary dictionaryWithObjects:@[rootDic[@"avatar"],rootDic[@"secret"],rootDic[@"token"],rootDic[@"userName"]] forKeys:@[@"avatar",@"secret",@"token",@"userName"]];
            [userDefaults setObject:dic forKey:USER_INFO];
        }else{
            [SVProgressHUD schenleyShowInfoWithText:rootDic[@"head"][@"errInfo"]];
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

@end
