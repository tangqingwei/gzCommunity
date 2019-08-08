//
//  SegmentView.h
//  Schenley
//
//  Created by songshushan on 2018/10/23.
//  Copyright © 2018 sqhtech. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class SegmentView;

@protocol SegmentViewDelegate <NSObject>

- (void)segmentView:(SegmentView *)segmentView didSelectedIndex:(NSInteger)index;

@end


@interface SegmentView : UIView

@property (nonatomic, weak) id<SegmentViewDelegate> delegate;
@property (nonatomic, strong) NSArray *titles;

- (void)selectedIndex:(NSInteger)index;

@end

NS_ASSUME_NONNULL_END
