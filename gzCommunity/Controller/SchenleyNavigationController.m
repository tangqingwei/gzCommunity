//
//  SchenleyNavigationController.m
//  Schenley
//
//  Created by songshushan on 2018/5/21.
//  Copyright © 2018年 sqhtech. All rights reserved.
//

#import "SchenleyNavigationController.h"
#import "UIImage+ColorImage.h"

@interface SchenleyNavigationController ()<UIGestureRecognizerDelegate>

@property (nonatomic, getter=isAnimated) BOOL animated;
@property (nonatomic, weak) id<SchenleyNavigationControllerDelegate> popDelegate;

@end

@implementation SchenleyNavigationController

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

- (instancetype)init{
    if (self = [super init]) {
        NSLog(@"init");
    }
    return self;
}

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController{
    if (self = [super initWithRootViewController:rootViewController]) {
        if (IS_IPHONE_X || IS_IPHONE_X_SMAX) {
            [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigation_bar_bg_x"] forBarMetrics:UIBarMetricsDefault];
        }else if(IS_IPHONE_6_PLUS){
            [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigation_bar_bg_p"] forBarMetrics:UIBarMetricsDefault];
        }else{
            [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigation_bar_bg"] forBarMetrics:UIBarMetricsDefault];
        }
        [self.navigationBar setShadowImage:[UIImage imageWithColor:UIColor.clearColor]];
        self.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:UIColor.whiteColor};
    }
    return self;
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    viewController.hidesBottomBarWhenPushed = YES;
    [super pushViewController:viewController animated:animated];
    if (viewController.navigationItem.leftBarButtonItem == nil && [self.viewControllers count] > 1) {
        viewController.navigationItem.leftBarButtonItem = [self createBackButton];
    }
    if (self.viewControllers.count == 1) {
        viewController.hidesBottomBarWhenPushed = NO;
    }
    self.animated = YES;
}

- (void)popSelf{
    UIViewController *vc = self.topViewController;
    if ([vc respondsToSelector:@selector(controllerWillPopHandler:)]) {
        self.popDelegate = (id<SchenleyNavigationControllerDelegate>)vc;
        [self.popDelegate controllerWillPopHandler:^(BOOL result) {
            if (result) {
                [self popViewControllerAnimated:self.isAnimated];
            }else{
                
            }
        }];
    }else{
        [self popViewControllerAnimated:self.isAnimated];
    }
}

- (UIBarButtonItem *)createBackButton{
    return [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"navigation_back_icon"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStyleDone target:self action:@selector(popSelf)];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.interactivePopGestureRecognizer.delegate = self;
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    return YES; //YES：允许右滑返回  NO：禁止右滑返回
}

@end
