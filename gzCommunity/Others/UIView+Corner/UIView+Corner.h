//
//  UIView+Corner.h
//  Schenley
//
//  Created by songshushan on 2018/10/23.
//  Copyright © 2018 sqhtech. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (Corner)

/** 圆角 */
- (void)roundingCorners:(UIRectCorner)corners cornerRadii:(CGSize)cornerRadii;

@end

NS_ASSUME_NONNULL_END
