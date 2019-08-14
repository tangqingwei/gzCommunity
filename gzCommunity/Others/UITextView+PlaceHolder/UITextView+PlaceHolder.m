//
//  UITextView+PlaceHolder.m
//  Schenley
//
//  Created by songshushan on 2018/7/10.
//  Copyright © 2018年 sqhtech. All rights reserved.
//

#import "UITextView+PlaceHolder.h"
#import <objc/runtime.h>

@interface UITextView()

@property (nonatomic, readonly) UILabel *placeHolderLabel;

@end

@implementation UITextView (PlaceHolder)

+ (void)load{
    [super load];
    method_exchangeImplementations(class_getInstanceMethod(self.class, NSSelectorFromString(@"layoutSubviews")), class_getInstanceMethod(self.class, @selector(placeHolder_LayoutSubviews)));
    method_exchangeImplementations(class_getInstanceMethod(self.class, NSSelectorFromString(@"dealloc")), class_getInstanceMethod(self.class, @selector(placeHolder_Dealloc)));
    method_exchangeImplementations(class_getInstanceMethod(self.class, NSSelectorFromString(@"setText:")), class_getInstanceMethod(self.class, @selector(placeHolder_setText:)));
}

- (void)placeHolder_Dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    //已经是交换后的方法
    [self placeHolder_Dealloc];
}
- (void)placeHolder_LayoutSubviews{
    if (self.placeHolder) {
        UIEdgeInsets textContainerInset = self.textContainerInset;
        CGFloat lineFragmentPadding = self.textContainer.lineFragmentPadding;
        CGFloat x = lineFragmentPadding + textContainerInset.left + self.layer.borderWidth;
        CGFloat y = textContainerInset.top + self.layer.borderWidth;
        CGFloat width = CGRectGetWidth(self.bounds) - x - textContainerInset.right - 2 * self.layer.borderWidth;
        CGFloat height = [self.placeHolderLabel sizeThatFits:CGSizeMake(width, 0)].height;
        self.placeHolderLabel.frame = CGRectMake(x, y, width, height);
    }
    [self placeHolder_LayoutSubviews];
}

- (void)placeHolder_setText:(NSString *)text{
    [self placeHolder_setText:text];
    if (self.placeHolder) {
        [self updatePlaceHolder];
    }
}

- (void)setPlaceHolder:(NSString *)placeHolder{
    //TODO
    objc_setAssociatedObject(self, @selector(placeHolder), placeHolder, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self updatePlaceHolder];
}
- (NSString *)placeHolder{
    return objc_getAssociatedObject(self, @selector(placeHolder));
}

- (void)setPlaceHolderColor:(UIColor *)placeHolderColor{
    self.placeHolderLabel.textColor = placeHolderColor;
}

- (UIColor *)placeHolderColor{
    return self.placeHolderLabel.textColor;
}

#pragma mark - update
- (void)updatePlaceHolder{
    if (self.text.length) {
        [self.placeHolderLabel removeFromSuperview];
        return;
    }
    self.placeHolderLabel.font = self.font ? self.font : self.defaultFont;
    self.placeHolderLabel.textAlignment = self.textAlignment;
    self.placeHolderLabel.text = self.placeHolder;
    [self insertSubview:self.placeHolderLabel atIndex:0];
}

#pragma mark - lazzing
- (UILabel *)placeHolderLabel{
    UILabel *placeHolderLabel = objc_getAssociatedObject(self, @selector(placeHolderLabel));
    if (!placeHolderLabel) {
        placeHolderLabel = [[UILabel alloc] init];
        placeHolderLabel.numberOfLines = 0;
        placeHolderLabel.textColor = UIColor.lightGrayColor;
        objc_setAssociatedObject(self, @selector(placeHolderLabel), placeHolderLabel, OBJC_ASSOCIATION_RETAIN);
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updatePlaceHolder) name:UITextViewTextDidChangeNotification object:self];
    }
    return placeHolderLabel;
}

- (UIFont *)defaultFont{
    static UIFont *font = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        UITextView *textView = [[UITextView alloc] init];
        textView.text = @" ";
        font = textView.font;
    });
    return font;
}

@end
