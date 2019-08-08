//
//  GZCommunityModel.h
//  gzCommunity
//
//  Created by qige on 2019/8/7.
//  Copyright © 2019 qige. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GZCommunityModel : NSObject

@property (nonatomic, strong) NSNumber *boardId;
@property (nonatomic, copy) NSString *boardName;
@property (nonatomic, strong) NSNumber *boardContent;
@property (nonatomic, copy) NSString *lastPostsDate;

+ (instancetype)initWithDic:(NSDictionary *)dic;

@end

NS_ASSUME_NONNULL_END
