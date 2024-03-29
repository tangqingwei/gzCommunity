//
//  LoginViewController.m
//  gzCommunity
//
//  Created by qige on 2019/8/12.
//  Copyright © 2019 qige. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginView.h"
#import "SignUpViewController.h"

@interface LoginViewController ()<LoginViewDelegate>

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = UIColor.whiteColor;
    self.navigationItem.title = @"登录";
    
    LoginView *loginView = [[LoginView alloc] initWithFrame:self.view.bounds];
    loginView.delegate = self;
    [self.view addSubview:loginView];
    
}

#pragma mark -- LoginViewDelegate
- (void)loginViewLoginEventWithUsername:(NSString *)username password:(NSString *)password{
    if (username.length == 0) {
        [SVProgressHUD schenleyShowInfoWithText:@"用户名不能为空"];
        return;
    }
    if (password.length == 0) {
        [SVProgressHUD schenleyShowInfoWithText:@"密码不能为空"];
        return;
    }
    //TODO
    //注册 username password
    //http://www.guanzhuangwang.com/mobcent/app/web/index.php?r=user/register
    //登录 username password type(login)
    //http://www.guanzhuangwang.com/mobcent/app/web/index.php?r=user/login
    NSMutableDictionary *parameters = [NSMutableDictionary parameters];
    parameters[@"username"] = username;
    parameters[@"password"] = password;
    parameters[@"type"] = @"login";
    parameters[@"isValidation"] = @1;
    [[AFNetworkingSchenley sharedInstance] requestWithPOST:REQUEST_URL(@"/mobcent/app/web/index.php?r=user/login") parameters:parameters success:^(NSData *responseObject) {
        NSDictionary *rootDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        NSLog(@"%@",rootDic);
        if ([rootDic[@"head"][@"errCode"] intValue] == 0) {
            [self.navigationController popViewControllerAnimated:YES];
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


- (void)loginViewSignUpEvent{
    SignUpViewController *vc = [[SignUpViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
