//
//  GZTableViewCell.h
//  gzCommunity
//
//  Created by qige on 2019/8/3.
//  Copyright © 2019 qige. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "GZModelRect.h"
#import "GZModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface GZTableViewCell : UITableViewCell

@property (nonatomic, strong) GZModelRect *modelRect;
@property (nonatomic, strong) GZModel *model;

@end

NS_ASSUME_NONNULL_END
