//
//  WebViewController.m
//  gzCommunity
//
//  Created by qige on 2019/8/9.
//  Copyright © 2019 qige. All rights reserved.
//

#import "WebViewController.h"
#import "WeakScriptMessageDelegate.h"
#import <WebKit/WebKit.h>

@interface WebViewController ()<WKScriptMessageHandler>

@property (nonatomic, weak) WKWebView *wkWebView;
@property (nonatomic, strong) UIProgressView *progressView;

@end

@implementation WebViewController

- (UIProgressView *)progressView{
    if (_progressView == nil) {
        _progressView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
        _progressView.frame = CGRectMake(0, 0, WIDTH, 2);
        _progressView.trackTintColor = UIColor.clearColor;
        _progressView.progressTintColor = RGBA(21, 117, 249, 1.0);
        [_progressView setProgress:0.1 animated:YES];
    }
    return _progressView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    SAFE_HEIGHT;
    NAVIGATION_HEIGHT;
    CGFloat webViewX = 0;
    CGFloat webViewY = 0.0;
    CGFloat webViewW = WIDTH;
    CGFloat webViewH = safe_height - webViewY - navigation_height;
    NSURL *url = [NSURL URLWithString:self.urlStr];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    WKUserContentController *userContentController = [[WKUserContentController alloc] init];
    //防止 内存泄漏
    [userContentController addScriptMessageHandler:[[WeakScriptMessageDelegate alloc] initWithDelegate:self] name:@"apply"];
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
    config.userContentController = userContentController;
    WKWebView *wkWebView = [[WKWebView alloc] initWithFrame:CGRectMake(webViewX, webViewY, webViewW, webViewH) configuration:config];
    [wkWebView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    [self.view addSubview:wkWebView];
    [wkWebView loadRequest:request];
    _wkWebView = wkWebView;
    
    [wkWebView addSubview:self.progressView];
}


- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self.wkWebView removeObserver:self forKeyPath:@"estimatedProgress"];
    [[self.wkWebView configuration].userContentController removeScriptMessageHandlerForName:@"apply"];
}


#pragma mark 观察者监听
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"estimatedProgress"]) {
        double newProgress = [[change objectForKey:NSKeyValueChangeNewKey] doubleValue];
        if (newProgress == 1) {
            [self.progressView setProgress:newProgress animated:YES];
            __weak typeof(self) weakSelf = self;
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                weakSelf.progressView.hidden = YES;
                [weakSelf.progressView setProgress:0.0 animated:NO];
            });
        }else{
            self.progressView.hidden = NO;
            [self.progressView setProgress:newProgress animated:YES];
        }
    }else{
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}


@end
