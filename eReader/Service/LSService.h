//
//  LSService.h
//  LSYReader
//
//  Created by banwang on 2017/12/5.
//  Copyright © 2017年 okwei. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^completionHandler)(NSString *string, NSURLResponse *response, NSError *error);

@interface LSService : NSObject

+ (void)searchArticle:(NSString *)searchkey completionHandler:(completionHandler)completionHandler;

+ (void)getRecentlyChapter:(NSString *)urlStr completionHandler:(completionHandler)completionHandler;

+ (void)getChapterContent:(NSString *)urlStr completionHandler:(completionHandler)completionHandler;

+ (void)getChapterList:(NSString *)urlStr completionHandler:(completionHandler)completionHandler;

@end
