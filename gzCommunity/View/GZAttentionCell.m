//
//  GZAttentionCell.m
//  gzCommunity
//
//  Created by qige on 2019/8/13.
//  Copyright © 2019 qige. All rights reserved.
//

#import "GZAttentionCell.h"
#import "UIImageView+WebCache.h"
#import "NSString+Date.h"

@interface GZAttentionCell ()

@property (nonatomic, weak) UIImageView *iconView;
@property (nonatomic, weak) UILabel *nameLabel;
@property (nonatomic, weak) UILabel *dateLabel;
@property (nonatomic, weak) UILabel *signatureLabel;
@property (nonatomic, weak) UIButton *cancelButton;

@end


@implementation GZAttentionCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIImageView *iconView = [[UIImageView alloc] init];
        iconView.layer.cornerRadius = 4.0;
        iconView.layer.masksToBounds = YES;
        [self.contentView addSubview:iconView];
        _iconView = iconView;
        
        UILabel *nameLabel = [[UILabel alloc] init];
        nameLabel.font = [UIFont systemFontOfSize:16.0];
        [self.contentView addSubview:nameLabel];
        _nameLabel = nameLabel;
        
        UILabel *dateLabel = [[UILabel alloc] init];
        dateLabel.font = [UIFont systemFontOfSize:12.0];
        dateLabel.textColor = UIColor.grayColor;
        dateLabel.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:dateLabel];
        _dateLabel = dateLabel;
        
        UILabel *signatureLabel = [[UILabel alloc] init];
        signatureLabel.font = [UIFont systemFontOfSize:14.0];
        signatureLabel.textColor = UIColor.grayColor;
        [self.contentView addSubview:signatureLabel];
        _signatureLabel = signatureLabel;
        
        UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [cancelButton setBackgroundColor:UIColor.grayColor];
        [cancelButton setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        [cancelButton.titleLabel setFont:[UIFont systemFontOfSize:12.0]];
        [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        cancelButton.layer.cornerRadius = 2.0;
        cancelButton.layer.masksToBounds = YES;
        [cancelButton addTarget:self action:@selector(cancelButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:cancelButton];
        _cancelButton = cancelButton;
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat width = self.contentView.frame.size.width;
    CGFloat height = self.contentView.frame.size.height;
    
    CGFloat iX = 12.0;
    CGFloat iY =12.0;
    CGFloat iW = height - 2 * iY;
    CGFloat iH = iW;
    self.iconView.frame = CGRectMake(iX, iY, iW, iH);
    CGFloat nameX = CGRectGetMaxX(self.iconView.frame) + 8.0;
    CGFloat nameY = iY;
    CGFloat nameH = iH * 0.5;
    CGFloat nameW = width * 0.3;
    self.nameLabel.frame = CGRectMake(nameX, nameY, nameW, nameH);
    CGFloat sX = nameX;
    CGFloat sY = CGRectGetMaxY(self.nameLabel.frame);
    CGFloat sW = nameW;
    CGFloat sH = nameH;
    self.signatureLabel.frame = CGRectMake(sX, sY, sW, sH);
    CGFloat dW = 100.0;
    CGFloat dH = nameH;
    CGFloat dY = nameY;
    CGFloat dX = width - dW - 12.0;
    self.dateLabel.frame = CGRectMake(dX, dY, dW, dH);
    CGFloat cbW = 48.0;
    CGFloat cbH = height * 0.25;
    CGFloat cbX = width - cbW - 12.0;
    CGFloat cbY = CGRectGetMaxY(self.dateLabel.frame);
    self.cancelButton.frame = CGRectMake(cbX, cbY, cbW, cbH);
}

- (void)cancelButtonClick{
    if (self.cancelBlock) {
        self.cancelBlock();
    }
}


- (void)setDataDic:(NSDictionary *)dataDic{
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:dataDic[@"icon"]]];
    self.nameLabel.text = dataDic[@"name"];
    if ([dataDic[@"signature"] isEqualToString:@""]) {
        self.signatureLabel.text = @"暂无签名";
    }else{
        self.signatureLabel.text = dataDic[@"signature"];
    }
    self.dateLabel.text = [NSString dateStringWithSecondNumber:dataDic[@"lastLogin"]];
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
