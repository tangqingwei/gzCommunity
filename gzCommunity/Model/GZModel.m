//
//  GZModel.m
//  gzCommunity
//
//  Created by qige on 2019/8/3.
//  Copyright © 2019 qige. All rights reserved.
//

#import "GZModel.h"
#import "NSString+Date.h"

@implementation GZModel

+ (instancetype)initWithDic:(NSDictionary *)dic{
    GZModel *model = [GZModel new];
    model.summary = dic[@"summary"];
    model.sourceType = dic[@"source_type"];
    model.sourceId = dic[@"source_id"];
    model.title = dic[@"title"];
    model.userNickName = dic[@"user_nick_name"];
    model.boardName = dic[@"board_name"];
    model.userAvatar = [NSURL URLWithString:dic[@"userAvatar"]];
    model.lastReplyDateStr = [NSString dateStringWithSecondNumber:dic[@"last_reply_date"]];
    model.imageList = dic[@"imageList"];
    model.boardId = dic[@"board_id"];
    model.topicId = dic[@"topic_id"];
    return model;
}


@end
