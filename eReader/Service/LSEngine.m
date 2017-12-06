//
//  LSEngine.m
//  LSYReader
//
//  Created by banwang on 2017/12/5.
//  Copyright © 2017年 okwei. All rights reserved.
//

#import "LSEngine.h"
#import <JavaScriptCore/JavaScriptCore.h>

@interface LSEngine ()<UIWebViewDelegate>

@property (nonatomic ,strong) JSContext   *context;

@end

@implementation LSEngine

- (instancetype)init{
    if (self = [super init]) {
        
    }
    return self;
}

+ (LSEngine *)shareEngine{
    static LSEngine *share = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        share = [[LSEngine alloc] init];
        semaphore = dispatch_semaphore_create(0);
    });
    return share;
}

- (UIWebView *)webView{
    if (_webView == nil) {
        _webView = [[UIWebView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _webView.delegate = self;
    }
    return _webView;
}

- (void)startEngine{
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"index" withExtension:@"html" subdirectory:@"prase"];
    [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
}

dispatch_semaphore_t semaphore;

- (void)webViewDidFinishLoad:(UIWebView *)webView{
   _context = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    dispatch_semaphore_signal(semaphore);
}

- (NSArray *)searchArticleList:(NSString *)htmlStr{
    JSValue *prase = _context[@"searchArticleList"];
    JSValue *content  = [prase callWithArguments:[NSArray arrayWithObject:htmlStr]];
    NSArray *infos = [content toArray];
    return infos;
}

- (NSArray *)getPraseCatalogue:(NSString *)htmlStr{
    JSValue *prase = _context[@"parseCatalogue"];
    JSValue *content  = [prase callWithArguments:[NSArray arrayWithObject:htmlStr]];
    NSArray *infos = [content toArray];
    return infos;
}

- (NSArray *)getRecentlyChapter:(NSString *)htmlStr{
    JSValue *prase = _context[@"getRecentlyChapter"];
    JSValue *content  = [prase callWithArguments:[NSArray arrayWithObject:htmlStr]];
    NSArray *infos = [content toArray];
    return infos;
}

- (NSArray *)getChapterList:(NSString *)htmlStr{
    JSValue *prase = _context[@"getChapterList"];
    JSValue *content  = [prase callWithArguments:[NSArray arrayWithObject:htmlStr]];
    NSArray *infos = [content toArray];
    return infos;
}

- (NSString *)getArticleContent:(NSString *)htmlStr{
    dispatch_semaphore_wait(semaphore, 10);
    JSValue *prase = _context[@"parseContent"];
    JSValue *content  = [prase callWithArguments:[NSArray arrayWithObject:htmlStr]];
    NSString *articleStr = [content toString];
    articleStr = [articleStr stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@" "];
    articleStr = [articleStr stringByReplacingOccurrencesOfString:@"<br>" withString:@""];
    return articleStr;
}


@end
