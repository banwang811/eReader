//
//  LSBookShelfController.m
//  LSYReader
//
//  Created by banwang on 2017/12/4.
//  Copyright © 2017年 okwei. All rights reserved.
//

#import "LSBookShelfController.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import <AFNetworking/AFNetworking.h>
#import "LSPageController.h"

@interface LSBookShelfController ()

@property (nonatomic, strong)JSContext *context;

@end

@implementation LSBookShelfController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    [self.view addSubview:[LSEngine shareEngine].webView];
    [[LSEngine shareEngine] startEngine];
//    [LSService searchArticle:@"圣墟"
//           completionHandler:^(NSString *string, NSURLResponse *response, NSError *error) {
//                NSArray *content = [[LSEngine shareEngine] searchArticleList:string];
//               NSLog(@"%@",content);
//    }];
    
//    [LSService getRecentlyChapter:@"http://m.book9.net/wapbook/10.html" completionHandler:^(NSString *string, NSURLResponse *response, NSError *error) {
//        NSArray *content = [[LSEngine shareEngine] getRecentlyChapter:string];
//        NSLog(@"%@",content);
//    }];
    
//    [LSService getChapterList:@"http://m.book9.net/wapbook/10_all.html" completionHandler:^(NSString *string, NSURLResponse *response, NSError *error) {
//        NSArray *content = [[LSEngine shareEngine] getChapterList:string];
//        NSLog(@"%@",content);
//    }];
    
    [LSService getChapterContent:@"http://m.book9.net/wapbook/10_1836647.html" completionHandler:^(NSString *string, NSURLResponse *response, NSError *error) {
            NSLog(@"%@",string);
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            NSString *content = [[LSEngine shareEngine] getArticleContent:string];
            NSLog(@"%@",content);
            LSChapterModel *model = [LSPrase praseChapterModel:content];
            LSPageController *con = [[LSPageController alloc] init];
            [con.chapterModels addObject:model];
            [self.navigationController pushViewController:con animated:YES];
        });
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
