//
//  LSReadingView.m
//  eReader
//
//  Created by banwang on 2017/12/6.
//  Copyright © 2017年 guanqun. All rights reserved.
//

#import "LSReadingView.h"
#import <CoreText/CoreText.h>

@implementation LSReadingView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (NSString *)content{
    return _content;
}

- (void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    if (_frameRef) {
        CGContextRef ctx = UIGraphicsGetCurrentContext();
        CGContextSetTextMatrix(ctx,CGAffineTransformIdentity);
        CGContextTranslateCTM(ctx, 0, self.frame.size.height);
        CGContextScaleCTM(ctx, 1, -1);
        CTFrameDraw(_frameRef, ctx);
    }
}

@end
