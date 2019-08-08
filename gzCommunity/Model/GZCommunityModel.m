//
//  GZCommunityModel.m
//  gzCommunity
//
//  Created by qige on 2019/8/7.
//  Copyright © 2019 qige. All rights reserved.
//

#import "GZCommunityModel.h"
#import "NSString+Date.h"

@implementation GZCommunityModel

+ (instancetype)initWithDic:(NSDictionary *)dic{
    GZCommunityModel *model = [[self alloc] init];
    model.boardId = dic[@"board_id"];
    model.boardName = dic[@"board_name"];
    model.boardContent = dic[@"board_content"];
    if ([model.boardContent isEqual:@1]) {
        model.lastPostsDate = [NSString dateStringWithSecondNumber:dic[@"last_posts_date"]];
    }
    return model;
}

@end
