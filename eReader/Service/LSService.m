//
//  LSService.m
//  LSYReader
//
//  Created by banwang on 2017/12/5.
//  Copyright © 2017年 okwei. All rights reserved.
//

#import "LSService.h"

@implementation LSService

//http://www.book9.net/modules/article/search.php?searchkey=%CA%A5%D0%E6
+ (void)searchArticle:(NSString *)searchkey completionHandler:(completionHandler)completionHandler{
    NSURLSession *session = [NSURLSession sharedSession];
    NSURL *url = [NSURL URLWithString:SEARCH_URL];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    [request setHTTPMethod:@"post"];
    NSData *body = [[[NSString stringWithFormat:@"keyword=%@",searchkey] urlEncode] dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPBody:body];
    NSURLSessionTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse *response, NSError *error) {
        NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding (kCFStringEncodingGB_18030_2000);
        NSString *htmlStr=[[NSString alloc]initWithData:data encoding:enc];
        dispatch_async(dispatch_get_main_queue(), ^{
            completionHandler(htmlStr,response,error);
        });
    }];
    [task resume];
}

+ (void)getChapterList:(NSString *)urlStr completionHandler:(completionHandler)completionHandler{
    NSURLSession *session = [NSURLSession sharedSession];
    NSURL *url = [NSURL URLWithString:urlStr];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    NSURLSessionTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse *response, NSError *error) {
        NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding (kCFStringEncodingGB_18030_2000);
        NSString *htmlStr=[[NSString alloc]initWithData:data encoding:enc];
        dispatch_async(dispatch_get_main_queue(), ^{
            completionHandler(htmlStr,response,error);
        });
    }];
    [task resume];
}

+ (void)getRecentlyChapter:(NSString *)urlStr completionHandler:(completionHandler)completionHandler{
    NSURLSession *session = [NSURLSession sharedSession];
    NSURL *url = [NSURL URLWithString:urlStr];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    NSURLSessionTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse *response, NSError *error) {
        NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding (kCFStringEncodingGB_18030_2000);
        NSString *htmlStr=[[NSString alloc]initWithData:data encoding:enc];
        dispatch_async(dispatch_get_main_queue(), ^{
            completionHandler(htmlStr,response,error);
        });
    }];
    [task resume];
}



+ (void)getChapterContent:(NSString *)urlStr completionHandler:(completionHandler)completionHandler{
    NSURLSession *session = [NSURLSession sharedSession];
    NSURL *url = [NSURL URLWithString:urlStr];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    NSURLSessionTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse *response, NSError *error) {
        NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding (kCFStringEncodingGB_18030_2000);
        NSString *htmlStr=[[NSString alloc]initWithData:data encoding:enc];
        dispatch_async(dispatch_get_main_queue(), ^{
            completionHandler(htmlStr,response,error);
        });
    }];
    [task resume];
}

@end
