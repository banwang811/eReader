//
//  LSChapterModel.m
//  eReader
//
//  Created by banwang on 2017/12/6.
//  Copyright © 2017年 guanqun. All rights reserved.
//

#import "LSChapterModel.h"

@implementation LSChapterModel

- (instancetype)init{
    if (self = [super init]) {
        self.pageLocations = [NSMutableArray array];
    }
    return self;
}

- (NSString *)stringOfPage:(NSUInteger)index{
    NSUInteger local = [_pageLocations[index] integerValue];
    NSUInteger length;
    if (index < self.pageCount - 1) {
        length = [_pageLocations[index + 1] integerValue] - [_pageLocations[index] integerValue];
    }else{
        length = _content.length - [_pageLocations[index] integerValue];
    }
    return [_content substringWithRange:NSMakeRange(local, length)];
}
@end
