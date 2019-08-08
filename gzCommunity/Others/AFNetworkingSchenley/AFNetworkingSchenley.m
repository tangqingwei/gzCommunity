
//
//  AFNetworkingHttp.m
//  JJLiPad
//
//  Created by  ireadyit on 17/4/7.
//  Copyright © 2017年 ireadyit. All rights reserved.
//

#import "AFNetworkingSchenley.h"

@interface AFNetworkingSchenley()

@property (nonatomic, strong) AFHTTPSessionManager *manager;
@property (nonatomic, strong) NSMutableDictionary *headerParameters;

@end

@implementation AFNetworkingSchenley

+(AFNetworkingSchenley *)sharedInstance{
    static AFNetworkingSchenley *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[AFNetworkingSchenley alloc] init];
    });
    return instance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _manager=[AFHTTPSessionManager manager];
        _manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        [_manager.requestSerializer setTimeoutInterval:15.f];
        _timeoutInterval = 15.f;
    }
    return self;
}

- (void)setTimeoutInterval:(CGFloat)timeoutInterval {
    [self.manager.requestSerializer setTimeoutInterval:timeoutInterval];
}

/**不携带请求头的POST请求*/
- (void)requestWithPOST:(NSString *)URL parameters:(NSDictionary *)parameters  success:(SuccessBlock)successBlock failure:(FailureBlock)failureBlock {
    [self requestWithPOST:URL parameters:parameters headerParameters:nil success:successBlock failure:failureBlock];
}

/**携带请求头的POST请求*/
- (void)requestWithPOST:(NSString *)URL parameters:(NSDictionary *)parameters headerParameters:(NSDictionary *)headerParameters success:(SuccessBlock)successBlock failure:(FailureBlock)failureBlock {
    __weak typeof(self) weakSelf = self;
    [self addHTTPHeader:headerParameters];
    [self.manager POST:URL parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //校验是否token失效
        
        [weakSelf successGlobalHandle:nil object:responseObject success:successBlock];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [weakSelf failureGlobalHandle:nil error:error failure:failureBlock];
    }];
    [self removeHTTPHeader];
}

- (void)requestWithGET:(NSString *)URL parameters:(NSDictionary *)parameters headerParameters:(NSDictionary *)headerParameters success:(SuccessBlock)successBlock failure:(FailureBlock)failureBlock{
    __weak typeof(self) weakSelf = self;
    [self addHTTPHeader:headerParameters];
    [self.manager GET:URL parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [weakSelf successGlobalHandle:task object:responseObject success:successBlock];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [weakSelf failureGlobalHandle:task error:error failure:failureBlock];
    }];
}

/**不携带请求头的GET请求*/
- (void)requestWithGET:(NSString *)URL parameters:(NSDictionary *)parameters  success:(SuccessBlock)successBlock failure:(FailureBlock)failureBlock{
    [self requestWithGET:URL parameters:parameters headerParameters:nil success:successBlock failure:failureBlock];
}

- (void)json_requestWithPOST:(NSString *)URL parameters:(NSDictionary *)parameters  success:(SuccessBlock)successBlock failure:(FailureBlock)failureBlock{
    self.manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [self.manager.requestSerializer requestWithMethod:@"POST" URLString:URL parameters:parameters error:nil];
    [self requestWithPOST:URL parameters:parameters success:successBlock failure:failureBlock];
}

- (void)json_requestWithPOST:(NSString *)URL parameters:(NSDictionary *)parameters headerParameters:(NSDictionary *)headerParameters success:(SuccessBlock)successBlock failure:(FailureBlock)failureBlock{
    self.manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [self.manager.requestSerializer requestWithMethod:@"POST" URLString:URL parameters:parameters error:nil];
    [self requestWithPOST:URL parameters:parameters headerParameters:headerParameters success:successBlock failure:failureBlock];
}

- (void)addHTTPHeader:(NSDictionary *)parameters {
    if (!self.headerParameters) {
        self.headerParameters = [[NSMutableDictionary alloc] init];
    }
    [self.headerParameters setValuesForKeysWithDictionary:parameters];
    for (NSString *key in [self.headerParameters allKeys]) {
        [self.manager.requestSerializer setValue:parameters[key] forHTTPHeaderField:key];
    }
}

- (void)removeHTTPHeader {
    if (!self.headerParameters) {
        return;
    }
    for (NSString *key in [self.headerParameters allKeys]) {
        [self.manager.requestSerializer setValue:nil forHTTPHeaderField:key];
    }
}

/**结果处理*/
- (void)successGlobalHandle:(NSURLSessionDataTask *)task object:(id)responseObject success:(SuccessBlock)successBlock {
    //    NSLog(@"数据请求成功：%@", [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil]);
    if ([self successErroeHandle:responseObject]) {
        if (successBlock) {
            successBlock(responseObject);
        }
    }
}

- (void)failureGlobalHandle:(NSURLSessionDataTask *)task error:(NSError *)error failure:(FailureBlock)failureBlock {
    //    NSLog(@"通用请求错误：%@", error.localizedDescription);
    if ([self failureErroeHandle:error]) {
        if (failureBlock) {
            failureBlock(error);
        }
    }
}

- (BOOL)successErroeHandle:(id)responseObject {
    //overlay
    return YES;
}

- (BOOL)failureErroeHandle:(NSError *)error {
    //overlay
    return YES;
}

- (void)cancel {
    [[self.manager operationQueue] cancelAllOperations];
}

@end
