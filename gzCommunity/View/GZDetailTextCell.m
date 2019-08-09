//
//  GZDetailTextCell.m
//  gzCommunity
//
//  Created by qige on 2019/8/5.
//  Copyright © 2019 qige. All rights reserved.
//

#import "GZDetailTextCell.h"

@interface GZDetailTextCell()

@end

@implementation GZDetailTextCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UILabel *contentLabel = [[UILabel alloc] init];
        contentLabel.font = [UIFont systemFontOfSize:14.0];
        contentLabel.numberOfLines = 0;
        [self.contentView addSubview:contentLabel];
        _contentLabel = contentLabel;
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}


- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat x = 8.0;
    CGFloat y = 0.0;
    CGFloat w = self.contentView.bounds.size.width - x * 2;
    CGFloat h = self.contentView.bounds.size.height - y * 2;
    self.contentLabel.frame = CGRectMake(x, y, w, h);
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
