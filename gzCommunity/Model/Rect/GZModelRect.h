//
//  GZModelReact.h
//  gzCommunity
//
//  Created by qige on 2019/8/3.
//  Copyright © 2019 qige. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "GZModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface GZModelRect : NSObject

@property (nonatomic, assign) CGRect iconFrame;
@property (nonatomic, assign) CGRect nameFrame;
@property (nonatomic, assign) CGRect dateFrame;
@property (nonatomic, assign) CGRect classFrame;
@property (nonatomic, assign) CGRect titleFrame;
@property (nonatomic, assign) CGRect contentFrame;
@property (nonatomic, assign) CGRect ciViewFFrame;
@property (nonatomic, assign) CGRect ciViewSFrame;
@property (nonatomic, assign) CGRect ciViewTFrame;

@property (nonatomic, assign) CGFloat height;

- (instancetype)initWithModel:(GZModel *)model;

@end

NS_ASSUME_NONNULL_END
