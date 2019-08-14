//
//  GZAttentionCell.h
//  gzCommunity
//
//  Created by qige on 2019/8/13.
//  Copyright © 2019 qige. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GZAttentionCell : UITableViewCell

@property (nonatomic, copy) void (^cancelBlock) (void);

@property (nonatomic, strong) NSDictionary *dataDic;

@end

NS_ASSUME_NONNULL_END
