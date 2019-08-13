//
//  LoginView.h
//  gzCommunity
//
//  Created by qige on 2019/8/12.
//  Copyright © 2019 qige. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol LoginViewDelegate <NSObject>

- (void)loginViewLoginEventWithUsername:(NSString *)username password:(NSString *)password;
- (void)loginViewSignUpEvent;

@end

@interface LoginView : UIView

@property (nonatomic, weak) id<LoginViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
