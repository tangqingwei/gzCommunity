//
//  UIButton+Reload.m
//  gzCommunity
//
//  Created by qige on 2019/8/8.
//  Copyright © 2019 qige. All rights reserved.
//

#import "UIButton+Reload.h"

@implementation UIButton (Reload)

+ (instancetype)reloadButton{
    //136 207 247
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitleColor:RGBA(136.0, 207.0, 247.0, 1.0) forState:UIControlStateNormal];
    [button.titleLabel setFont:[UIFont systemFontOfSize:14.0]];
    [button setTitle:@"重新加载" forState:UIControlStateNormal];
    button.frame = CGRectMake(0, 0, 96.0, 24.0);
    return button;
}

@end
