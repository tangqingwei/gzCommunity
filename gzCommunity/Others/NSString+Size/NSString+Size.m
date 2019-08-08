//
//  NSString+Size.m
//  gzCommunity
//
//  Created by qige on 2019/8/4.
//  Copyright © 2019 qige. All rights reserved.
//

#import "NSString+Size.h"

@implementation NSString (Size)

- (CGFloat)calculateRowHeightWithWidth:(CGFloat)width fontSize:(NSInteger)fontSize{
    NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]};
    CGRect rect = [self boundingRectWithSize:CGSizeMake(width, 0) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:dic context:nil];
    return rect.size.height;
}

- (CGFloat)lineBreak_calculateRowHeightWithWidth:(CGFloat)width fontSize:(NSInteger)fontSize{
    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, width, 10)];
    textView.text = self;
    textView.font = [UIFont systemFontOfSize:fontSize];
    CGSize size = CGSizeMake(width, CGFLOAT_MAX);
    CGSize constraint = [textView sizeThatFits:size];
    return constraint.height;
}

@end
