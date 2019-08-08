//
//  NSString+Date.m
//  gzCommunity
//
//  Created by qige on 2019/8/4.
//  Copyright © 2019 qige. All rights reserved.
//

#import "NSString+Date.h"

@implementation NSString (Date)

+ (instancetype)dateStringWithSecondNumber:(NSNumber *)secondNumber{
    NSString *str1=[NSString stringWithFormat:@"%@",secondNumber];
    int x=[[str1 substringToIndex:10] intValue];
    NSDate  *date1 = [NSDate dateWithTimeIntervalSince1970:x];
    NSDateFormatter *dateformatter=[[NSDateFormatter alloc]init];
    [dateformatter setDateFormat:@"yyyy-MM-dd"];
    return [dateformatter stringFromDate:date1];
}

@end
