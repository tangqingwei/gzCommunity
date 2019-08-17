//
//  RABAlbumAlertView.h
//  Schenley
//
//  Created by songshushan on 2018/11/19.
//  Copyright © 2018 sqhtech. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol RABAlbumAlertViewDelegate <NSObject>

- (void)albumAlertViewDidSelectItemAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface RABAlbumAlertView : UIView

@property (nonatomic, weak) id<RABAlbumAlertViewDelegate> delegate;

- (void)showWithArray:(NSArray *)array;
- (void)hide;

@end

NS_ASSUME_NONNULL_END
