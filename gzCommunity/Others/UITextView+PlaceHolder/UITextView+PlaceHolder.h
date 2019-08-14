//
//  UITextView+PlaceHolder.h
//  Schenley
//
//  Created by songshushan on 2018/7/10.
//  Copyright © 2018年 sqhtech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextView (PlaceHolder)
/**
 IQKeyboardManager 等第三方框架会读取placeHolder属性并创建UIToolbar展示
 */
@property (nonatomic, copy) NSString *placeHolder;
@property (nonatomic, strong) UIColor *placeHolderColor;

@end
