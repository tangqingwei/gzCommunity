//
//  SignUpView.h
//  gzCommunity
//
//  Created by qige on 2019/8/12.
//  Copyright © 2019 qige. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol SignUpViewDelegate <NSObject>

- (void)signUpLoginEventWithUsername:(NSString *)username password:(NSString *)password;

@end


@interface SignUpView : UIView

@property (nonatomic, weak) id<SignUpViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
