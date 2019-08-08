//
//  SegmentView.m
//  Schenley
//
//  Created by songshushan on 2018/10/23.
//  Copyright © 2018 sqhtech. All rights reserved.
//

#import "SegmentView.h"
#import "UIView+Corner.h"
#import "UIImage+ColorImage.h"

@interface SegmentView()

@property (nonatomic, weak) UIButton *firstButton;
@property (nonatomic, weak) UIButton *secondButton;

@end

@implementation SegmentView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        UIButton *firstButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [firstButton setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
        [firstButton setTitleColor:UIColor.whiteColor forState:UIControlStateSelected];
        [firstButton setBackgroundImage:[UIImage imageWithColor:SCHENLEY_BASECOLOR] forState:UIControlStateSelected];
        [firstButton setBackgroundImage:[UIImage imageWithColor:UIColor.whiteColor] forState:UIControlStateNormal];
        [firstButton addTarget:self action:@selector(firstButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:firstButton];
        _firstButton = firstButton;
        
        UIButton *secondButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [secondButton setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
        [secondButton setTitleColor:UIColor.whiteColor forState:UIControlStateSelected];
        [secondButton setBackgroundImage:[UIImage imageWithColor:SCHENLEY_BASECOLOR] forState:UIControlStateSelected];
        [secondButton setBackgroundImage:[UIImage imageWithColor:UIColor.whiteColor] forState:UIControlStateNormal];
        [secondButton addTarget:self action:@selector(secondButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:secondButton];
        _secondButton = secondButton;
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.height;
    //38 112
    CGFloat btnW = 112.0;
    CGFloat btnH = 38.0;
    CGFloat btnY = (height - btnH) * 0.5;
    self.firstButton.frame = CGRectMake(width * 0.5 - btnW, btnY, btnW, btnH);
    [self.firstButton roundingCorners:UIRectCornerTopLeft | UIRectCornerBottomLeft cornerRadii:CGSizeMake(8.0, 8.0)];
    self.secondButton.frame = CGRectMake(width * 0.5, btnY, btnW, btnH);
    [self.secondButton roundingCorners:UIRectCornerTopRight | UIRectCornerBottomRight cornerRadii:CGSizeMake(8.0, 8.0)];
}

- (void)setTitles:(NSArray *)titles{
    NSAssert(titles.count == 2, @"数组只能包含两个元素");
    [self.firstButton setTitle:titles[0] forState:UIControlStateNormal];
    [self.secondButton setTitle:titles[1] forState:UIControlStateNormal];
}

- (void)firstButtonClick{
    if ([self.delegate respondsToSelector:@selector(segmentView:didSelectedIndex:)]) {
        self.firstButton.selected = YES;
        self.secondButton.selected = NO;
        [self.delegate segmentView:self didSelectedIndex:0];
    }
}

- (void)secondButtonClick{
    if ([self.delegate respondsToSelector:@selector(segmentView:didSelectedIndex:)]) {
        self.firstButton.selected = NO;
        self.secondButton.selected = YES;
        [self.delegate segmentView:self didSelectedIndex:1];
    }
}

- (void)selectedIndex:(NSInteger)index{
    if (index == 0) {
        self.firstButton.selected = YES;
        self.secondButton.selected = NO;
    }else if (index == 1){
        self.firstButton.selected = NO;
        self.secondButton.selected = YES;
    }
}

@end
