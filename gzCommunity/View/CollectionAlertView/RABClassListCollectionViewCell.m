//
//  RABClassListCollectionViewCell.m
//  Schenley
//
//  Created by songshushan on 2018/11/20.
//  Copyright © 2018 sqhtech. All rights reserved.
//

#import "RABClassListCollectionViewCell.h"

@implementation RABClassListCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        UILabel *textLabel = [[UILabel alloc] init];
        textLabel.backgroundColor = RGBA(230, 240, 218, 1.0);
        textLabel.textAlignment = NSTextAlignmentCenter;
        textLabel.font = [UIFont systemFontOfSize:14.0];
        if (IS_IPHONE_5){
            textLabel.font = [UIFont systemFontOfSize:12.0];
        }
        textLabel.textColor = RGBA(144, 180, 84, 1.0);
        textLabel.layer.masksToBounds = YES;
        textLabel.layer.cornerRadius = 3.0;
        [self.contentView addSubview:textLabel];
        _textLabel = textLabel;
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.textLabel.frame = self.contentView.bounds;
}


@end
