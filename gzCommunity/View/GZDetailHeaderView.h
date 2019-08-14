//
//  GZDetailHeaderView.h
//  gzCommunity
//
//  Created by qige on 2019/8/6.
//  Copyright © 2019 qige. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol GZDetailHeaderViewDelegate <NSObject>

- (void)detailHeaderViewAttenEvent;

@end


@interface GZDetailHeaderView : UIView

@property (nonatomic, weak) id<GZDetailHeaderViewDelegate> delegate;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *iconView;
@property (nonatomic, strong) UILabel *userNickNameLabel;
@property (nonatomic, strong) UILabel *dateLabel;

@property (nonatomic, assign) BOOL isFollow;

@end

NS_ASSUME_NONNULL_END
