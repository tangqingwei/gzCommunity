//
//  PMViewController.m
//  gzCommunity
//
//  Created by qige on 2019/8/17.
//  Copyright © 2019 qige. All rights reserved.
//

#import "PMViewController.h"
#import "UITextView+PlaceHolder.h"

@interface PMViewController ()

@property (nonatomic, strong) UILabel *tagLabel;
@property (nonatomic, strong) UITextView *titleTextView;
@property (nonatomic, strong) UITextView *contentTextView;
@property (nonatomic, strong) UILabel *noticeLabel;

@end

@implementation PMViewController

- (UILabel *)noticeLabel{
    if (_noticeLabel == nil) {
        _noticeLabel = [[UILabel alloc] init];
        _noticeLabel.frame = CGRectMake(12.0, self.contentTextView.maxY + 8.0, WIDTH - 24.0, 13.0);
        _noticeLabel.font = [UIFont systemFontOfSize:12.0];
        _noticeLabel.textColor =UIColor.redColor;
        _noticeLabel.text = @"注意：APP端暂不支持添加图片。";
    }
    return _noticeLabel;
}

- (UILabel *)tagLabel{
    if (_tagLabel == nil) {
        _tagLabel = [[UILabel alloc] init];
        _tagLabel.frame = CGRectMake(12.0, 12.0, 72.0, 24.0);
        _tagLabel.layer.masksToBounds = YES;
        _tagLabel.layer.cornerRadius = 12.0;
        _tagLabel.textAlignment = NSTextAlignmentCenter;
        _tagLabel.font = [UIFont systemFontOfSize:14.0];
        _tagLabel.textColor = UIColor.whiteColor;
        _tagLabel.backgroundColor = UIColor.redColor;
    }
    return _tagLabel;
}

- (UITextView *)titleTextView{
    if (_titleTextView == nil) {
        NAVIGATION_HEIGHT;
        CGFloat x = 12.0f;
        CGFloat y = self.tagLabel.maxY + 12.0;
        CGFloat width = WIDTH - 2 * x;
        CGFloat height = 48.0;
        _titleTextView = [[UITextView alloc] initWithFrame:CGRectMake(x, y, width, height) textContainer:nil];
        _titleTextView.textColor = RGBA(174, 175, 176, 1.0);
        _titleTextView.layer.borderWidth = 1;
        _titleTextView.layer.borderColor = UIColor.lightGrayColor.CGColor;
        _titleTextView.placeHolder = @"请输入标题";
    }
    return _titleTextView;
}

- (UITextView *)contentTextView{
    if (_contentTextView == nil) {
        NAVIGATION_HEIGHT;
        CGFloat x = 12.0f;
        CGFloat y = self.titleTextView.maxY + 12.0;
        CGFloat width = WIDTH - 2 * x;
        CGFloat height = 142.0;
        _contentTextView = [[UITextView alloc] initWithFrame:CGRectMake(x, y, width, height) textContainer:nil];
        _contentTextView.textColor = RGBA(174, 175, 176, 1.0);
        _contentTextView.layer.borderWidth = 1;
        _contentTextView.layer.borderColor = UIColor.lightGrayColor.CGColor;
        _contentTextView.placeHolder = @"请输入内容";
        _contentTextView.font = [UIFont systemFontOfSize:14.0];
    }
    return _contentTextView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"发帖";
    self.view.backgroundColor = UIColor.whiteColor;
    
    self.tagLabel.text = self.tag;
    [self.view addSubview:self.tagLabel];
    
    [self.view addSubview:self.titleTextView];
    [self.view addSubview:self.contentTextView];
    [self.view addSubview:self.noticeLabel];
    
    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelButton.backgroundColor = UIColor.redColor;
    [cancelButton setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    [cancelButton addTarget:self action:@selector(cancelButtonClkick) forControlEvents:UIControlEventTouchUpInside];
    cancelButton.layer.cornerRadius = 4.0f;
    cancelButton.layer.masksToBounds = YES;
    cancelButton.frame = CGRectMake(0, 0, 42, 36);
    UIBarButtonItem *rightItem1 = [[UIBarButtonItem alloc] initWithCustomView:cancelButton];
    self.navigationItem.leftBarButtonItem = rightItem1;
    
    UIButton *publishButton = [UIButton buttonWithType:UIButtonTypeCustom];
    publishButton.backgroundColor = UIColor.redColor;
    [publishButton setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    [publishButton setTitle:@"发帖" forState:UIControlStateNormal];
    [publishButton addTarget:self action:@selector(publishButtonClkick) forControlEvents:UIControlEventTouchUpInside];
    publishButton.layer.cornerRadius = 4.0f;
    publishButton.layer.masksToBounds = YES;
    publishButton.frame = CGRectMake(0, 0, 42, 36);
    UIBarButtonItem *rightItem2 = [[UIBarButtonItem alloc] initWithCustomView:publishButton];
    self.navigationItem.rightBarButtonItem = rightItem2;
}


- (void)cancelButtonClkick{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)publishButtonClkick{
    //TODO 发布
    if (self.titleTextView.text.length == 0) {
        [SVProgressHUD schenleyShowInfoWithText:@"标题不能为空"];
        return;
    }
    if (self.contentTextView.text.length == 0) {
        [SVProgressHUD schenleyShowInfoWithText:@"内容不能为空"];
        return;
    }
    //TODO
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *dic = [userDefaults objectForKey:USER_INFO];
    NSMutableDictionary *parameters = [NSMutableDictionary parameters];
    parameters[@"userId"] = @34;
    parameters[@"page"] = @1;
    parameters[@"pageSize"] = @20;
    parameters[@"type"] = @"follow";
    parameters[@"orderBy"] = @"dateline";
    parameters[@"accessToken"] = dic[@"token"];
    parameters[@"accessSecret"] = dic[@"secret"];
    [[AFNetworkingSchenley sharedInstance] requestWithPOST:REQUEST_URL(@"/mobcent/app/web/index.php?r=user/userlist") parameters:parameters success:^(NSData *responseObject) {
//        NSDictionary *rootDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        [SVProgressHUD schenleyShowInfoWithText:@"发布成功，请等待审核！"];
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
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
