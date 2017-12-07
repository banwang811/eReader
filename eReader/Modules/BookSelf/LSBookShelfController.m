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
#import "LSSearchDelegate.h"

@interface LSBookShelfController ()<UITableViewDelegate,UITableViewDataSource,UISearchControllerDelegate>{
    UISearchDisplayController           *searchDisplayController;
    UISearchBar                         *searchBar;
    LSSearchDelegate                    *searchDelegate;
    UISearchController                  *searchController;

}
@property (nonatomic, strong)JSContext *context;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation LSBookShelfController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self layoutSearchBar];
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
    
//    [LSService getChapterContent:@"http://m.book9.net/wapbook/10_1836647.html" completionHandler:^(NSString *string, NSURLResponse *response, NSError *error) {
//            NSLog(@"%@",string);
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            NSString *content = [[LSEngine shareEngine] getArticleContent:string];
//            NSLog(@"%@",content);
//            LSChapterModel *model = [LSPrase praseChapterModel:content];
//            LSPageController *con = [[LSPageController alloc] init];
//            [con.chapterModels addObject:model];
//            [self.navigationController pushViewController:con animated:YES];
//        });
//    }];
}

- (void)layoutSearchBar{
    searchDelegate = [[LSSearchDelegate alloc] init];
    searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
    searchBar.placeholder = @"搜索";
    searchBar.delegate = searchDelegate;
    searchBar.backgroundImage = [UIImage imageWithColor:[UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1]];
    self.tableView.tableHeaderView = searchBar;
    searchDisplayController = [[UISearchDisplayController alloc] initWithSearchBar:searchBar contentsController:self];
    searchDisplayController.searchResultsDataSource = searchDelegate;
    searchDisplayController.searchResultsDelegate = searchDelegate;
    searchDisplayController.delegate = searchDelegate;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
