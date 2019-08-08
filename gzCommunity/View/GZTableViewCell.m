//
//  GZTableViewCell.m
//  gzCommunity
//
//  Created by qige on 2019/8/3.
//  Copyright © 2019 qige. All rights reserved.
//

#import "GZTableViewCell.h"
#import "UIImageView+WebCache.h"


@interface GZTableViewCell ()

@property (nonatomic, weak) UIImageView *iconView;
@property (nonatomic, weak) UILabel *nameLabel;
@property (nonatomic, weak) UILabel *dateLabel;
@property (nonatomic, weak) UILabel *classLabel;
@property (nonatomic, weak) UILabel *titleLabel;
@property (nonatomic, weak) UILabel *contentLabel;
@property (nonatomic, weak) UIImageView *ciViewF;
@property (nonatomic, weak) UIImageView *ciViewS;
@property (nonatomic, weak) UIImageView *ciViewT;

@end

@implementation GZTableViewCell

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
        
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.numberOfLines = 2;
        [self.contentView addSubview:titleLabel];
        _titleLabel = titleLabel;
        
        UILabel *contentLabel = [[UILabel alloc] init];
        contentLabel.font = [UIFont systemFontOfSize:14.0];
        contentLabel.textColor = RGBA(146, 151, 152, 1.0);
        contentLabel.numberOfLines = 2;
        [self.contentView addSubview:contentLabel];
        _contentLabel = contentLabel;
        
        UIImageView *ciViewF = [[UIImageView alloc] init];
        [self.contentView addSubview:ciViewF];
        _ciViewF = ciViewF;
        
        UIImageView *ciViewS = [[UIImageView alloc] init];
        [self.contentView addSubview:ciViewS];
        _ciViewS = ciViewS;
        
        UIImageView *ciViewT = [[UIImageView alloc] init];
        [self.contentView addSubview:ciViewT];
        _ciViewT = ciViewT;
    }
    return self;
}


- (void)setModel:(GZModel *)model{
//    self.iconView
    self.nameLabel.text = model.userNickName;
    self.titleLabel.text = model.title;
    self.contentLabel.text = model.summary;
    self.classLabel.text = model.boardName;
    [self.iconView sd_setImageWithURL:model.userAvatar];
    self.dateLabel.text = model.lastReplyDateStr;
    if (model.imageList.count > 1) {
        [self.ciViewF sd_setImageWithURL:[NSURL URLWithString:model.imageList[1]]];
        NSLog(@"%@",model.imageList[0]);
    }
    if (model.imageList.count > 2) {
        [self.ciViewS sd_setImageWithURL:[NSURL URLWithString:model.imageList[2]]];
    }
    if (model.imageList.count > 3) {
        [self.ciViewT sd_setImageWithURL:[NSURL URLWithString:model.imageList[3]]];
    }
}

- (void)setModelRect:(GZModelRect *)modelRect{
    self.iconView.frame = modelRect.iconFrame;
    self.titleLabel.frame = modelRect.titleFrame;
    self.dateLabel.frame = modelRect.dateFrame;
    self.classLabel.frame = modelRect.classFrame;
    self.contentLabel.frame = modelRect.contentFrame;
    self.nameLabel.frame = modelRect.nameFrame;
    self.ciViewF.frame = modelRect.ciViewFFrame;
    self.ciViewS.frame = modelRect.ciViewSFrame;
    self.ciViewT.frame = modelRect.ciViewTFrame;
    
    self.ciViewF.backgroundColor = UIColor.redColor;
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
