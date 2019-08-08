//
//  GZCommunityViewModel.m
//  gzCommunity
//
//  Created by qige on 2019/8/7.
//  Copyright © 2019 qige. All rights reserved.
//

#import "GZCommunityViewModel.h"
#import "AFNetworkingSchenley.h"
#import "GZParameters.h"
#import "GZCommunityModel.h"

@implementation GZCommunityViewModel

- (void)createDataWithResult:(void (^) (id value))result failure:(void (^) (NSError *error))failure{
    NSMutableDictionary *parameters = [NSMutableDictionary parameters];
    //    http://www.guanzhuangwang.com/mobcent/app/web/index.php?r=forum/forumlist
    NSMutableArray *resultArr = [NSMutableArray array];
    [[AFNetworkingSchenley sharedInstance] requestWithPOST:REQUEST_URL(@"/mobcent/app/web/index.php?r=forum/forumlist") parameters:parameters success:^(NSData *responseObject) {
        NSDictionary *rootDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        //        NSLog(@"%@",rootDic);
        NSArray *list = rootDic[@"list"][0][@"board_list"];
        for (NSDictionary *dic in list) {
            GZCommunityModel *model = [GZCommunityModel initWithDic:dic];
            [resultArr addObject:model];
        }
        if (result) {
            result(resultArr);
        }
    } failure:^(NSError *error) {
        failure(error);
    }];
}


@end
