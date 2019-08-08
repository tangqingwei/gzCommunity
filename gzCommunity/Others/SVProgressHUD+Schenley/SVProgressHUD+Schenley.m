//
//  SVProgressHUD+Schenley.m
//  Schenley
//
//  Created by songshushan on 2018/5/22.
//  Copyright © 2018年 sqhtech. All rights reserved.
//

#import "SVProgressHUD+Schenley.h"

@implementation SVProgressHUD (Schenley)

+(void)schenleyShowInfoWithText:(NSString *)text{
    [self setInfoImage:[UIImage imageNamed:@"axxxa"]];
    [self setCornerRadius:3.0f];
    [self setMinimumDismissTimeInterval:2.5f];
    [self setMaximumDismissTimeInterval:3.0f];
    [self setDefaultStyle:SVProgressHUDStyleDark];
    [self setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    [self showInfoWithStatus:text];
}


@end
