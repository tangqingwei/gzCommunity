//
//  GZCLViewModel.m
//  gzCommunity
//
//  Created by qige on 2019/8/7.
//  Copyright © 2019 qige. All rights reserved.
//

#import "GZCLViewModel.h"
#import "AFNetworkingSchenley.h"
#import "GZParameters.h"
#import "GZModel.h"

@implementation GZCLViewModel

- (void)createDataWithResult:(void (^) (id value))result{
    NSMutableDictionary *parameters = [NSMutableDictionary parameters];
    parameters[@"circle"]= @0;
    parameters[@"pageSize"] = @20;
    parameters[@"page"] = @1;
    parameters[@"isImageList"] = @1;
    parameters[@"boardId"] = self.boardId;
    parameters[@"topOrder"] = @1;
    parameters[@"isRatio"] = @0;
    parameters[@"orderby"] = @"all";
    NSMutableArray *resultArr = [NSMutableArray array];
    [[AFNetworkingSchenley sharedInstance] requestWithPOST:REQUEST_URL(@"/mobcent/app/web/index.php?r=forum/topiclistex") parameters:parameters success:^(NSData *responseObject) {
        NSDictionary *rootDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        //        NSLog(@"%@",rootDic);
        NSArray *list = rootDic[@"list"];
        for (NSDictionary *dic in list) {
            GZModel *model = [GZModel initWithDic:dic];
            [resultArr addObject:model];
        }
        if (result) {
            result(resultArr);
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

@end
