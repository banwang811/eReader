//
//  LSReadModel.m
//  eReader
//
//  Created by banwang on 2017/12/6.
//  Copyright © 2017年 guanqun. All rights reserved.
//

#import "LSReadModel.h"

@implementation LSReadModel

- (NSString *)url{
    return [NSString stringWithFormat:@"%@%@",SERVER_ADDRESS,_url];
}

- (NSString *)libraryUrl{
    return [self.url stringByReplacingOccurrencesOfString:@".html" withString:@"_all.html"];
}

@end
