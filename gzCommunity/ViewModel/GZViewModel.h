//
//  GZViewModel.h
//  gzCommunity
//
//  Created by qige on 2019/8/3.
//  Copyright © 2019 qige. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GZViewModel : NSObject


@property (nonatomic, copy) void (^returnValueBlock) (id value);

- (void)createDataWithResult:(void (^) (id value))result failure:(void (^) (NSError *error))failure;

@end

NS_ASSUME_NONNULL_END
