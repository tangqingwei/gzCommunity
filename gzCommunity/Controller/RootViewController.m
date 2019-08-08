//
//  RootViewController.m
//  gzCommunity
//
//  Created by qige on 2019/7/31.
//  Copyright © 2019 qige. All rights reserved.
//

#import "RootViewController.h"
#import "HomeViewController.h"
#import "CommunityViewController.h"

@interface RootViewController ()

@property (nonatomic, strong) UIPageViewController *pageVc;

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = UIColor.redColor;
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 40)];
    titleView.backgroundColor = UIColor.greenColor;
    self.navigationItem.titleView = titleView;
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
