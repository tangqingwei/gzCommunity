//
//  InfoViewController.m
//  gzCommunity
//
//  Created by qige on 2019/8/12.
//  Copyright © 2019 qige. All rights reserved.
//

#import "InfoViewController.h"
#import "InfoView.h"
#import "UIImageView+WebCache.h"
#import "RABAlbumAlertView.h"
#import "PMViewController.h"

@interface InfoViewController ()<InfoViewDelegate,RABAlbumAlertViewDelegate>

@property (nonatomic, strong) InfoView *infoView;
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) RABAlbumAlertView *alertView;

@end

@implementation InfoViewController

- (RABAlbumAlertView *)alertView{
    if (_alertView == nil) {
        _alertView = [[RABAlbumAlertView alloc] init];
        _alertView.delegate = self;
    }
    return _alertView;
}


- (NSArray *)classArray{
    return @[@"管庄新闻",@"学校教育",@"管庄房价",@"房屋车位",@"办事指南",@"活动报名",@"活动相册",@"二手闲置",@"周边商家",@"论坛公告"];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = UIColor.whiteColor;
    self.navigationItem.title = @"信息";
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *dic = [userDefaults objectForKey:USER_INFO];
    
    NAVIGATION_HEIGHT;
    SAFE_HEIGHT;
    CGFloat infoX = 0.0;
    CGFloat infoY = 0.0;
    CGFloat infoW = WIDTH;
    CGFloat infoH = safe_height - navigation_height;
    InfoView *infoView = [[InfoView alloc] initWithFrame:CGRectMake(infoX, infoY, infoW, infoH)];
    infoView.unLabel.text = dic[@"userName"];
    [infoView.iconView sd_setImageWithURL:[NSURL URLWithString:dic[@"avatar"]]];
    infoView.delegate = self;
    [self.view addSubview:infoView];
    _infoView = infoView;
    
    //头像
    //用户名
    //我的关注
    UIButton *logoutButton = [UIButton buttonWithType:UIButtonTypeCustom];
    logoutButton.backgroundColor = UIColor.redColor;
    [logoutButton setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    [logoutButton setTitle:@"退出" forState:UIControlStateNormal];
    [logoutButton addTarget:self action:@selector(logoutButtonClkick) forControlEvents:UIControlEventTouchUpInside];
    logoutButton.layer.cornerRadius = 4.0f;
    logoutButton.layer.masksToBounds = YES;
    logoutButton.frame = CGRectMake(0, 0, 42, 36);
    UIBarButtonItem *rightItem1 = [[UIBarButtonItem alloc] initWithCustomView:logoutButton];
    
    UIButton *pmButton = [UIButton buttonWithType:UIButtonTypeCustom];
    pmButton.backgroundColor = UIColor.redColor;
    [pmButton setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    [pmButton setTitle:@"发帖" forState:UIControlStateNormal];
    [pmButton addTarget:self action:@selector(pmButtonClkick) forControlEvents:UIControlEventTouchUpInside];
    pmButton.layer.cornerRadius = 4.0f;
    pmButton.layer.masksToBounds = YES;
    pmButton.frame = CGRectMake(0, 0, 42, 36);
    UIBarButtonItem *rightItem2 = [[UIBarButtonItem alloc] initWithCustomView:pmButton];
    
    self.navigationItem.rightBarButtonItems = @[rightItem1, rightItem2];
    
    [self createData];
}

- (void)createData{
    //http://www.guanzhuangwang.com/mobcent/app/web/index.php?r=user/userlist
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
        NSDictionary *rootDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        NSLog(@"%@",rootDic);
//        [SVProgressHUD schenleyShowInfoWithText:rootDic[@"head"][@"errInfo"]];
        self.dataArray = rootDic[@"list"];
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

- (void)setDataArray:(NSArray *)dataArray{
    _dataArray = dataArray;
    self.infoView.dataArray = dataArray;
}

- (void)logoutButtonClkick{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults removeObjectForKey:USER_INFO];
    [self.navigationController popViewControllerAnimated:YES];
    NSLog(@"注销");
}

- (void)pmButtonClkick{
    //TODO
    [self.alertView showWithArray:self.classArray];
}

#pragma mark - InfoViewDelegate
- (void)infoViewLogoutButtonEvent{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults removeObjectForKey:USER_INFO];
    [self.navigationController popViewControllerAnimated:YES];
    NSLog(@"注销");
}

- (void)infoViewDeSelectedIndexPath:(NSIndexPath *)indexPath{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *infoDic = [userDefaults objectForKey:USER_INFO];
    NSDictionary *dic = self.dataArray[indexPath.row];
    NSMutableDictionary *parameters = [NSMutableDictionary parameters];
    parameters[@"uid"]=dic[@"uid"];
    parameters[@"type"]=@"unfollow";
    parameters[@"accessToken"] = infoDic[@"token"];
    parameters[@"accessSecret"] = infoDic[@"secret"];
    [[AFNetworkingSchenley sharedInstance] requestWithPOST:REQUEST_URL(@"/mobcent/app/web/index.php?r=user/useradmin") parameters:parameters success:^(NSData *responseObject) {
        NSDictionary *rootDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        NSLog(@"%@",rootDic);
        [SVProgressHUD schenleyShowInfoWithText:rootDic[@"head"][@"errInfo"]];
        [self createData];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

#pragma mark -- RABAlbumAlertViewDelegate
- (void)albumAlertViewDidSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    PMViewController *vc = [[PMViewController alloc] init];
    vc.tag = self.classArray[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}


@end
