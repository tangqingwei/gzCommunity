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
#import "SegmentView.h"

@interface RootViewController ()<UIPageViewControllerDelegate,UIPageViewControllerDataSource, SegmentViewDelegate>

@property (nonatomic, strong) UIPageViewController *pageViewController;
@property (nonatomic, strong) NSArray<UIViewController *> *vcDataSource;
@property (nonatomic, assign) NSInteger selectedIndex;
@property (nonatomic, strong) SegmentView *segementView;

@end

@implementation RootViewController

- (SegmentView *)segementView{
    if (_segementView == nil) {
        _segementView = [[SegmentView alloc] init];
        _segementView.delegate = self;
        _segementView.titles = self.segementTitles;
        NAVIGATION_HEIGHT;
        _segementView.frame = CGRectMake(0, 0, WIDTH * 0.6, 40);
    }
    return _segementView;
}

- (UIPageViewController *)pageViewController{
    if (_pageViewController == nil) {
        _pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:@{UIPageViewControllerOptionInterPageSpacingKey:@10}];
        _pageViewController.delegate = self;
        _pageViewController.dataSource = self;
        [self addChildViewController:_pageViewController];
    }
    return _pageViewController;
}

- (NSArray<UIViewController *> *)vcDataSource{
    if (_vcDataSource == nil) {
        _vcDataSource = @[[HomeViewController new],[CommunityViewController new]];
    }
    return _vcDataSource;
}

- (NSArray *)segementTitles{
    return @[@"推荐",@"分类"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = UIColor.whiteColor;
    
    self.navigationItem.titleView = self.segementView;
    [self.segementView selectedIndex:0];
    
    self.selectedIndex = 0;
    UIViewController *vc = self.vcDataSource[self.selectedIndex];
    [self.pageViewController setViewControllers:@[vc] direction:UIPageViewControllerNavigationDirectionReverse animated:YES completion:nil];
    
    SAFE_HEIGHT;
    NAVIGATION_HEIGHT;
    CGFloat x = 0.0;
    CGFloat y = 0;
    CGFloat width = WIDTH;
    CGFloat height = safe_height - y;
    self.pageViewController.view.frame = CGRectMake(x, y, width, height);
    [self.view addSubview:self.pageViewController.view];
    
}

#pragma mark - UIPageViewControllerDataSource
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController{
    NSInteger index = [self.vcDataSource indexOfObject:viewController];
    if ((index == self.vcDataSource.count - 1) || (index == NSNotFound)) {
        return nil;
    }
    index ++;
    return self.vcDataSource[index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController{
    NSInteger index = [self.vcDataSource indexOfObject:viewController];
    if ((index == 0) || (index == NSNotFound)) {
        return nil;
    }
    index --;
    return self.vcDataSource[index];
}

#pragma mark - UIPageViewControllerDelegate
- (void)pageViewController:(UIPageViewController *)pageViewController willTransitionToViewControllers:(NSArray<UIViewController *> *)pendingViewControllers{
    //获取下一个控制器的索引
    //pendingViewControllers 包含的是即将线显示的控制器，是一个数组，如果是单页面显示的话，其中只有一个元素
    UIViewController *nextVc = pendingViewControllers.firstObject;
    NSInteger index = [self.vcDataSource indexOfObject:nextVc];
    self.selectedIndex = index;
}

//动画结束后
- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(nonnull NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed{
    //completed用来判断是否真的切换到下一个
    if (completed) {
        //刷新 segmentView
        [self.segementView selectedIndex:self.selectedIndex];
    }
}

#pragma mark - SSegmentViewDelegate
- (void)segmentView:(SegmentView *)segmentView didSelectedIndex:(NSInteger)index{
    UIViewController *vc = self.vcDataSource[index];
    if (index > self.selectedIndex){
        [self.pageViewController setViewControllers:@[vc] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    }else if (index < self.selectedIndex){
        [self.pageViewController setViewControllers:@[vc] direction:UIPageViewControllerNavigationDirectionReverse animated:YES completion:nil];
    }
    self.selectedIndex = index;
}


@end
