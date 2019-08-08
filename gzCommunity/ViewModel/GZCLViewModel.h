//
//  GZCLViewModel.h
//  gzCommunity
//
//  Created by qige on 2019/8/7.
//  Copyright © 2019 qige. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GZCLViewModel : NSObject

@property (nonatomic, strong) NSNumber *boardId;

- (void)createDataWithResult:(void (^) (id value))result;

@end

NS_ASSUME_NONNULL_END
