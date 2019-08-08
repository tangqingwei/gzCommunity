//
//  GZViewModel.m
//  gzCommunity
//
//  Created by qige on 2019/8/3.
//  Copyright © 2019 qige. All rights reserved.
//

#import "GZViewModel.h"
#import "AFNetworkingSchenley.h"
#import "GZParameters.h"
#import "GZModel.h"

@implementation GZViewModel

- (void)createDataWithResult:(void (^) (id value))result failure:(void (^) (NSError *error))failure{
    NSMutableDictionary *parameters = [NSMutableDictionary parameters];
    parameters[@"circle"]= @0;
    parameters[@"pageSize"] = @20;
    parameters[@"moduleId"] = @1;
    parameters[@"page"] = @1;
    parameters[@"isImageList"] = @1;
    NSMutableArray *resultArr = [NSMutableArray array];
    [[AFNetworkingSchenley sharedInstance] requestWithPOST:REQUEST_URL(@"/mobcent/app/web/index.php?r=portal/newslist") parameters:parameters success:^(NSData *responseObject) {
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
        failure(error);
    }];
}


@end
