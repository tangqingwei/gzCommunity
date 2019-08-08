//
//  UIView+Corner.m
//  Schenley
//
//  Created by songshushan on 2018/10/23.
//  Copyright © 2018 sqhtech. All rights reserved.
//

#import "UIView+Corner.h"

@implementation UIView (Corner)

- (void)roundingCorners:(UIRectCorner)corners cornerRadii:(CGSize)cornerRadii{
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:corners cornerRadii:cornerRadii];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
}

@end
