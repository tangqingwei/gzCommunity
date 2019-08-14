//
//  GZModel.h
//  gzCommunity
//
//  Created by qige on 2019/8/3.
//  Copyright © 2019 qige. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GZModel : NSObject

@property (nonatomic, copy) NSString *sourceType;
@property (nonatomic, strong) NSNumber *sourceId;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *userNickName;
@property (nonatomic, copy) NSString *summary;
@property (nonatomic, strong) NSString *lastReplyDateStr;
@property (nonatomic, copy) NSString *boardName;
@property (nonatomic, strong) NSNumber *boardId;
@property (nonatomic, strong) NSURL *userAvatar;
@property (nonatomic, strong) NSArray *imageList;
@property (nonatomic, strong) NSNumber *topicId;
@property (nonatomic, copy) NSString *userId;

+ (instancetype)initWithDic:(NSDictionary *)dic;

@end

NS_ASSUME_NONNULL_END
