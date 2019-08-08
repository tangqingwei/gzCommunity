//
//  AFNetworkingHttp.h
//  JJLiPad
//
//  Created by  ireadyit on 17/4/7.
//  Copyright © 2017年 ireadyit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

typedef void(^SuccessBlock)(NSData *responseObject);
typedef void(^FailureBlock)(NSError *error);

@interface AFNetworkingSchenley : NSObject

+(AFNetworkingSchenley *)sharedInstance;

@property (nonatomic, weak) id delegate;
@property (nonatomic, assign) CGFloat timeoutInterval;

/**不携带请求头的POST请求*/
- (void)requestWithPOST:(NSString *)URL parameters:(NSDictionary *)parameters  success:(SuccessBlock)successBlock failure:(FailureBlock)failureBlock;

/**携带请求头的POST请求*/
- (void)requestWithPOST:(NSString *)URL parameters:(NSDictionary *)parameters headerParameters:(NSDictionary *)headerParameters success:(SuccessBlock)successBlock failure:(FailureBlock)failureBlock;
/**携带请求头的GET请求*/
- (void)requestWithGET:(NSString *)URL parameters:(NSDictionary *)parameters headerParameters:(NSDictionary *)headerParameters success:(SuccessBlock)successBlock failure:(FailureBlock)failureBlock;

/**不携带请求头的GET请求*/
- (void)requestWithGET:(NSString *)URL parameters:(NSDictionary *)parameters  success:(SuccessBlock)successBlock failure:(FailureBlock)failureBlock;

/**
 application/json 不携带请求头的POST请求
 */
- (void)json_requestWithPOST:(NSString *)URL parameters:(NSDictionary *)parameters  success:(SuccessBlock)successBlock failure:(FailureBlock)failureBlock;

/**
 application/json 携带请求头的POST请求
 */
- (void)json_requestWithPOST:(NSString *)URL parameters:(NSDictionary *)parameters headerParameters:(NSDictionary *)headerParameters success:(SuccessBlock)successBlock failure:(FailureBlock)failureBlock;

/**结果处理*/
- (BOOL)successErroeHandle:(id)responseObject;
- (BOOL)failureErroeHandle:(NSError *)error;
- (void)cancel;

@end
