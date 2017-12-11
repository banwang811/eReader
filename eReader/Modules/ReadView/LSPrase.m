//
//  LSPrase.m
//  eReader
//
//  Created by banwang on 2017/12/6.
//  Copyright © 2017年 guanqun. All rights reserved.
//

#import "LSPrase.h"

@implementation LSPrase

+ (LSChapterModel *)praseChapterWithContent:(NSString *)content chapterModel:(LSChapterModel *)model{
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:content];
    NSDictionary *attribute = [LSPrase parserAttribute:[LSYReadConfig shareInstance]];
    [attStr setAttributes:attribute range:NSMakeRange(0, attStr.length)];
    CTFramesetterRef setter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef) attStr);
    CGPathRef path = CGPathCreateWithRect(CGRectMake(LeftSpacing, TopSpacing, [UIScreen mainScreen].bounds.size.width-LeftSpacing - RightSpacing, [UIScreen mainScreen].bounds.size.height - TopSpacing - BottomSpacing), NULL);
    BOOL hasMorePages = YES;
    int currentOffset = 0;
    [model.pageLocations removeAllObjects];
    while (hasMorePages) {
        [model.pageLocations addObject:@(currentOffset)];
        CTFrameRef frame = CTFramesetterCreateFrame(setter, CFRangeMake(currentOffset, 0), path, NULL);
        CFRange range = CTFrameGetVisibleStringRange(frame);
        if (range.location + range.length >= attStr.length) {
            hasMorePages = NO;
        }else{
            currentOffset += range.length;
        }
        if (frame) {
            CFRelease(frame);
        }
    }
    model.pageCount = [model.pageLocations count];
    model.content = content;
    CFRelease(path);
    CFRelease(setter);
    return model;
}

+ (CTFrameRef)parserContent:(NSString *)content  bouds:(CGRect)bounds{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:content];
    NSDictionary *attribute = [self parserAttribute:[LSYReadConfig shareInstance]];
    [attributedString setAttributes:attribute range:NSMakeRange(0, content.length)];
    CTFramesetterRef setterRef = CTFramesetterCreateWithAttributedString((__bridge CFAttributedStringRef)attributedString);
    CGPathRef pathRef = CGPathCreateWithRect(bounds, NULL);
    CTFrameRef frameRef = CTFramesetterCreateFrame(setterRef, CFRangeMake(0, 0), pathRef, NULL);
    CFRelease(setterRef);
    CFRelease(pathRef);
    return frameRef;
}


+ (NSDictionary *)parserAttribute:(LSYReadConfig *)config{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[NSForegroundColorAttributeName] = config.fontColor;
    dict[NSFontAttributeName] = [UIFont systemFontOfSize:config.fontSize];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = config.lineSpace;
    paragraphStyle.alignment = NSTextAlignmentLeft;
    dict[NSParagraphStyleAttributeName] = paragraphStyle;
    return [dict copy];
}

@end
