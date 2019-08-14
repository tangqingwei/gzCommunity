//
//  GZDetailHeaderView.m
//  gzCommunity
//
//  Created by qige on 2019/8/6.
//  Copyright © 2019 qige. All rights reserved.
//

#import "GZDetailHeaderView.h"

@interface GZDetailHeaderView()

@property (nonatomic, weak) UIButton *attenButton;

@end

@implementation GZDetailHeaderView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.numberOfLines = 2;
        titleLabel.backgroundColor = UIColor.whiteColor;
        [self addSubview:titleLabel];
        _titleLabel = titleLabel;
        
        UIImageView *iconView = [[UIImageView alloc] init];
        iconView.layer.cornerRadius = 4.0;
        iconView.layer.masksToBounds = YES;
        [self addSubview:iconView];
        _iconView = iconView;
        
        UILabel *nameLabel = [[UILabel alloc] init];
        nameLabel.font = [UIFont systemFontOfSize:14.0];
        [self addSubview:nameLabel];
        _userNickNameLabel = nameLabel;
        
        UILabel *dateLabel = [[UILabel alloc] init];
        dateLabel.font = [UIFont systemFontOfSize:12.0];
        dateLabel.textColor = UIColor.grayColor;
        [self addSubview:dateLabel];
        _dateLabel = dateLabel;
        
        UIButton *attenButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [attenButton setBackgroundColor:UIColor.redColor];
        [attenButton setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        [attenButton.titleLabel setFont:[UIFont systemFontOfSize:12.0]];
        [attenButton setTitle:@"关注" forState:UIControlStateNormal];
        [attenButton setTitle:@"已关注" forState:UIControlStateSelected];
        attenButton.layer.cornerRadius = 2.0;
        attenButton.layer.masksToBounds = YES;
        [attenButton addTarget:self action:@selector(attenButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:attenButton];
        _attenButton = attenButton;
        
        self.backgroundColor = UIColor.whiteColor;
    }
    return self;
}


- (void)setIsFollow:(BOOL)isFollow{
    self.attenButton.selected = isFollow;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat width = self.bounds.size.width;
//    CGFloat height = self.bounds.size.height;
    CGFloat titleX = 8.0;
    CGFloat titleY = 8.0;
    CGFloat titleW = width - 2 * titleX;
    CGFloat titleH = 42.0;
    self.titleLabel.frame = CGRectMake(titleX, titleY, titleW, titleH);
    CGFloat iconX = 8.0;
    CGFloat iconY = CGRectGetMaxY(self.titleLabel.frame) + 8.0;
    CGFloat iconW = 36.0;
    CGFloat iconH = iconW;
    self.iconView.frame = CGRectMake(iconX, iconY, iconW, iconH);
    CGFloat nameX = CGRectGetMaxX(self.iconView.frame) + 4.0;
    CGFloat nameY = CGRectGetMinY(self.iconView.frame);
    CGFloat nameW = 100;
    CGFloat nameH = 18.0;
    self.userNickNameLabel.frame = CGRectMake(nameX, nameY, nameW, nameH);
    CGFloat dateX = CGRectGetMinX(self.userNickNameLabel.frame);
    CGFloat dateY = CGRectGetMaxY(self.userNickNameLabel.frame);
    CGFloat dateW = 100;
    CGFloat dateH = 18.0;
    self.dateLabel.frame = CGRectMake(dateX, dateY, dateW, dateH);
    CGFloat abW = 42.0;
    CGFloat abH = 18.0;
    CGFloat abX = width - abW - 12.0;
    CGFloat abY = nameY + 4.0;
    self.attenButton.frame = CGRectMake(abX, abY, abW, abH);
}


- (void)attenButtonClick{
    if ([self.delegate respondsToSelector:@selector(detailHeaderViewAttenEvent)]) {
        [self.delegate detailHeaderViewAttenEvent];
    }
}

@end
