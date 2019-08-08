//
//  GZParameters.m
//  gzCommunity
//
//  Created by qige on 2019/8/3.
//  Copyright © 2019 qige. All rights reserved.
//

#import "GZParameters.h"

@implementation NSMutableDictionary (GZParameters)

+ (instancetype)parameters{
    NSMutableDictionary *dic = [self dictionary];
    dic[@"egnVersion"] = @"v2103.5";
    dic[@"sdkVersion"]= @"2.5.0.0";
    dic[@"apphash"]=@"c1856a18";
    dic[@"forumKey"]=@"dslehe33VEouwxwPEi";
    return dic;
}

@end
