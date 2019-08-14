//
//  GZCommentCell.m
//  gzCommunity
//
//  Created by qige on 2019/8/13.
//  Copyright © 2019 qige. All rights reserved.
//

#import "GZCommentCell.h"

@interface GZCommentCell()

@property (nonatomic, weak) UIImageView *iconView;
@property (nonatomic, weak) UILabel *nameLabel;
@property (nonatomic, weak) UILabel *dateLabel;
@property (nonatomic, weak) UILabel *classLabel;
@property (nonatomic, weak) UILabel *contentLabel;

@end


@implementation GZCommentCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIImageView *iconView = [[UIImageView alloc] init];
        iconView.layer.cornerRadius = 4.0;
        iconView.layer.masksToBounds = YES;
        [self.contentView addSubview:iconView];
        _iconView = iconView;
        
        UILabel *nameLabel = [[UILabel alloc] init];
        nameLabel.font = [UIFont systemFontOfSize:14.0];
        [self.contentView addSubview:nameLabel];
        _nameLabel = nameLabel;
        
        UILabel *dateLabel = [[UILabel alloc] init];
        dateLabel.font = [UIFont systemFontOfSize:12.0];
        dateLabel.textColor = UIColor.grayColor;
        [self.contentView addSubview:dateLabel];
        _dateLabel = dateLabel;
        
        UILabel *classLabel = [[UILabel alloc] init];
        classLabel.font = [UIFont systemFontOfSize:12.0];
        classLabel.textColor = RGBA(2336, 102, 59, 1.0);
        classLabel.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:classLabel];
        _classLabel = classLabel;
        
        UILabel *contentLabel = [[UILabel alloc] init];
        contentLabel.font = [UIFont systemFontOfSize:14.0];
        contentLabel.textColor = RGBA(146, 151, 152, 1.0);
        contentLabel.numberOfLines = 2;
        [self.contentView addSubview:contentLabel];
        _contentLabel = contentLabel;
    }
    return self;
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
