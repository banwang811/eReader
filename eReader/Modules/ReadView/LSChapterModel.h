//
//  LSChapterModel.h
//  eReader
//
//  Created by banwang on 2017/12/6.
//  Copyright © 2017年 guanqun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LSChapterModel : NSObject

@property (nonatomic, strong) NSString               *title;
@property (nonatomic, assign) NSInteger               pageCount;
@property (nonatomic, strong) NSMutableArray         *pageLocations;
@property (nonatomic, strong) NSString               *url;
@property (nonatomic, strong) NSString               *content;

- (NSString *)stringOfPage:(NSUInteger)index;

@end
