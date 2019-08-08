//
//  GZModelReact.m
//  gzCommunity
//
//  Created by qige on 2019/8/3.
//  Copyright © 2019 qige. All rights reserved.
//

#import "GZModelRect.h"
#import "NSString+Size.h"

@implementation GZModelRect

- (instancetype)initWithModel:(GZModel *)model{
    self = [super init];
    if (self) {
        CGFloat totalHeight = 0.0;
        self.iconFrame = CGRectMake(8.0, 8.0, 36.0, 36.0);
        self.nameFrame = CGRectMake(CGRectGetMaxX(self.iconFrame), CGRectGetMinY(self.iconFrame), 100.0, 18.0);
        self.dateFrame = CGRectMake(CGRectGetMaxX(self.iconFrame), CGRectGetMaxY(self.nameFrame), 100.0, 18.0);
        self.classFrame = CGRectMake(WIDTH - 100.0, 8.0, 92.0, 36.0);
        CGFloat titleW = WIDTH - 16.0;
        CGFloat titleH = [model.title calculateRowHeightWithWidth:titleW fontSize:18.0];
        self.titleFrame = CGRectMake(8.0, CGRectGetMaxY(self.iconFrame),titleW, titleH);
        CGFloat contentW = titleW;
        CGFloat contentH = [model.summary calculateRowHeightWithWidth:contentW fontSize:14.0];
        if (contentH > 30.0) {
            contentH = 36.0;
        }
        self.contentFrame = CGRectMake(CGRectGetMinX(self.iconFrame), CGRectGetMaxY(self.titleFrame), WIDTH - 16.0, contentH);
        totalHeight = CGRectGetMaxY(self.contentFrame) + 12.0;
        NSLog(@"--------%ld",model.imageList.count);
        if (model.imageList.count != 0) {
            CGFloat imagesSpace = 8.0;
            CGFloat imageW = (titleW - imagesSpace * 2.0) * 0.333333;
            CGFloat imageH = imageW;
            CGFloat imageY = CGRectGetMaxY(self.contentFrame) + 8.0;
            self.ciViewFFrame = CGRectMake(8.0, imageY, imageW, imageH);
            self.ciViewSFrame = CGRectMake(CGRectGetMaxX(self.ciViewFFrame) + imagesSpace, imageY, imageW, imageH);
            self.ciViewTFrame = CGRectMake(CGRectGetMaxX(self.ciViewSFrame) + imagesSpace, imageY, imageW, imageH);
            totalHeight = CGRectGetMaxY(self.ciViewFFrame) + 12.0;
        }
        self.height = totalHeight + 12.0;
    }
    return self;
}

@end
