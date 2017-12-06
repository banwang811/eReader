//
//  LSEngine.h
//  LSYReader
//
//  Created by banwang on 2017/12/5.
//  Copyright © 2017年 okwei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface LSEngine : NSObject

@property (nonatomic, strong) UIWebView *webView;

+ (LSEngine *)shareEngine;

- (void)startEngine;

- (NSArray *)getPraseCatalogue:(NSString *)htmlStr;

- (NSString *)getArticleContent:(NSString *)htmlStr;

- (NSArray *)searchArticleList:(NSString *)htmlStr;

- (NSArray *)getRecentlyChapter:(NSString *)htmlStr;

- (NSArray *)getChapterList:(NSString *)htmlStr;

@end
