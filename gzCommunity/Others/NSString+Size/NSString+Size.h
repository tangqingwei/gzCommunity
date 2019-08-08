//
//  NSString+Size.h
//  gzCommunity
//
//  Created by qige on 2019/8/4.
//  Copyright © 2019 qige. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (Size)

/**
 计算普通文本高度（不含换行符）
 */
- (CGFloat)calculateRowHeightWithWidth:(CGFloat)width fontSize:(NSInteger)fontSize;

/**
 计算带换行符的文本高度
 */
- (CGFloat)lineBreak_calculateRowHeightWithWidth:(CGFloat)width fontSize:(NSInteger)fontSize;

@end

NS_ASSUME_NONNULL_END
