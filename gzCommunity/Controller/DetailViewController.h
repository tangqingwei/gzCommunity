//
//  DetailViewController.h
//  gzCommunity
//
//  Created by qige on 2019/7/31.
//  Copyright © 2019 qige. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DetailViewController : UIViewController

@property (nonatomic, strong) NSNumber *boardId;
@property (nonatomic, strong) NSNumber *topicId;
@property (nonatomic, copy) NSString *boardName;
@property (nonatomic, copy) NSString *userId;

@end

NS_ASSUME_NONNULL_END
