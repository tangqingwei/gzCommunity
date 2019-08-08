//
//  GZDetailLinkCell.m
//  gzCommunity
//
//  Created by qige on 2019/8/6.
//  Copyright © 2019 qige. All rights reserved.
//

#import "GZDetailLinkCell.h"

@implementation GZDetailLinkCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UILabel *linkLabel = [[UILabel alloc] init];
        linkLabel.font = [UIFont systemFontOfSize:14.0];
        linkLabel.textColor = RGBA(44, 124, 246, 1.0);
        linkLabel.numberOfLines = 0;
        [self.contentView addSubview:linkLabel];
        _linkLabel = linkLabel;
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat x = 8.0;
    CGFloat y = 0.0;
    CGFloat w = self.contentView.bounds.size.width - 2 * x;
    CGFloat h = self.contentView.bounds.size.height;
    
    self.linkLabel.frame = CGRectMake(x, y, w, h);
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
