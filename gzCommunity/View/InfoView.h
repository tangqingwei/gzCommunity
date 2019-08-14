//
//  InfoView.h
//  gzCommunity
//
//  Created by qige on 2019/8/12.
//  Copyright © 2019 qige. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


@protocol InfoViewDelegate <NSObject>

- (void)infoViewLogoutButtonEvent;
- (void)infoViewDeSelectedIndexPath:(NSIndexPath *)indexPath;

@end

@interface InfoView : UIView

@property (nonatomic, weak) id<InfoViewDelegate> delegate;
@property (nonatomic, weak) UILabel *unLabel;
@property (nonatomic, weak) UIButton *logoutButton;
@property (nonatomic, weak) UIImageView *iconView;

@property (nonatomic, strong) NSArray *dataArray;

@end

NS_ASSUME_NONNULL_END
