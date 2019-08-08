//
//  SchenleyNavigationController.h
//  Schenley
//
//  Created by songshushan on 2018/5/21.
//  Copyright © 2018年 sqhtech. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SchenleyNavigationControllerDelegate <NSObject>

@optional
- (void)controllerWillPopHandler:(void (^) (BOOL result))result;

@end

@interface SchenleyNavigationController : UINavigationController

@end
