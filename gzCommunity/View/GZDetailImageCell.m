//
//  GZDetailImageCell.m
//  gzCommunity
//
//  Created by qige on 2019/8/5.
//  Copyright © 2019 qige. All rights reserved.
//

#import "GZDetailImageCell.h"

@interface GZDetailImageCell()


@end


@implementation GZDetailImageCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIImageView *contentImageView = [[UIImageView alloc] init];
        contentImageView.backgroundColor = UIColor.redColor;
        [self.contentView addSubview:contentImageView];
        _contentImageView = contentImageView;
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)setImageSize:(CGSize)imageSize{
    self.contentImageView.frame = CGRectMake(8.0, 8.0, imageSize.width, imageSize.height);
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
