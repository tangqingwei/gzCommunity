//
//  CommunityCell.m
//  gzCommunity
//
//  Created by qige on 2019/8/7.
//  Copyright © 2019 qige. All rights reserved.
//

#import "CommunityCell.h"

@implementation CommunityCell

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.font = [UIFont systemFontOfSize:16.0];
        [self.contentView addSubview:titleLabel];
        _titleLabel = titleLabel;
        
        UILabel *dateLabel = [[UILabel alloc] init];
        dateLabel.font = [UIFont systemFontOfSize:12.0];
        dateLabel.textColor = UIColor.grayColor;
        [self.contentView addSubview:dateLabel];
        _dateLabel = dateLabel;
        
        self.contentView.backgroundColor = UIColor.whiteColor;
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat width = self.contentView.bounds.size.width;
    CGFloat height = self.contentView.bounds.size.height;
    self.titleLabel.frame = CGRectMake(8.0, height * 0.1, width - 8.0, height * 0.4);
    self.dateLabel.frame = CGRectMake(8.0, CGRectGetMaxY(self.titleLabel.frame), width - 8.0, height * 0.3);
}

@end
