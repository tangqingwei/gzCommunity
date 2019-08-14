//
//  CommentViewController.m
//  gzCommunity
//
//  Created by qige on 2019/8/13.
//  Copyright © 2019 qige. All rights reserved.
//

#import "CommentViewController.h"
#import "UITextView+PlaceHolder.h"

@interface CommentViewController ()

@property (nonatomic, strong) UITextView *commentTextView;

@end

@implementation CommentViewController

- (UITextView *)commentTextView{
    if (_commentTextView == nil) {
        NAVIGATION_HEIGHT;
        CGFloat x = 12.0f;
        CGFloat y = 24.0;
        CGFloat width = WIDTH - 2 * x;
        CGFloat height = 142.0;
        _commentTextView = [[UITextView alloc] initWithFrame:CGRectMake(x, y, width, height) textContainer:nil];
        _commentTextView.textColor = RGBA(174, 175, 176, 1.0);
        _commentTextView.layer.borderWidth = 1;
        _commentTextView.layer.borderColor = UIColor.lightGrayColor.CGColor;
        _commentTextView.placeHolder = @"请输入评论内容";
    }
    return _commentTextView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = UIColor.whiteColor;
    self.navigationItem.title = @"评论";
    
    [self.view addSubview:self.commentTextView];
    
    UIButton *commentButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [commentButton.titleLabel setFont:[UIFont systemFontOfSize:14.0]];
    [commentButton setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    [commentButton setTitle:@"评论" forState:UIControlStateNormal];
    [commentButton setBackgroundColor:UIColor.redColor];
    commentButton.layer.cornerRadius = 4.0;
    commentButton.layer.masksToBounds = YES;
    [commentButton addTarget:self action:@selector(commentButtonEvent) forControlEvents:UIControlEventTouchUpInside];
    SAFE_HEIGHT;
    NAVIGATION_HEIGHT;
    CGFloat cbW = 72.0f;
    CGFloat cbH = 32.0f;
    CGFloat cbX = (WIDTH - cbW) * 0.5;
    CGFloat cbY = CGRectGetMaxY(self.commentTextView.frame) + 24.0;
    commentButton.frame = CGRectMake(cbX, cbY, cbW, cbH);
    [self.view addSubview:commentButton];
    //http://www.guanzhuangwang.com/mobcent/app/web/index.php?r=forum/topicadmin
    //关注
    //http://www.guanzhuangwang.com/mobcent/app/web/index.php?r=user/useradmin
    //我的关注
    //http://www.guanzhuangwang.com/mobcent/app/web/index.php?r=user/userlist
}

- (void)commentButtonEvent{
    
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
