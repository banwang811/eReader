//
//  NSString+Unit.m
//  LSYReader
//
//  Created by banwang on 2017/12/5.
//  Copyright © 2017年 okwei. All rights reserved.
//

#import "NSString+Unit.h"

@implementation NSString (Unit)

- (NSString *)urlEncode{
    NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding (kCFStringEncodingGB_18030_2000);
    return [self stringByAddingPercentEscapesUsingEncoding:enc];
}

@end
