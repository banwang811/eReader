//
//  LSSearchDelegate.m
//  eReader
//
//  Created by banwang on 2017/12/6.
//  Copyright © 2017年 guanqun. All rights reserved.
//

#import "LSSearchDelegate.h"

@interface LSSearchDelegate()
@property (nonatomic, strong) NSMutableArray        *articleList;
@end

@implementation LSSearchDelegate

- (instancetype)init{
    if (self = [super init]) {
        _articleList = [NSMutableArray array];
    }
    return self;
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
    return self.articleList.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString{
    searchString = [searchString stringByReplacingOccurrencesOfString:@" " withString:@""];
    [LSService searchArticle:@"圣墟"
           completionHandler:^(NSString *string, NSURLResponse *response, NSError *error) {
                NSArray *array = [[LSEngine shareEngine] searchArticleList:string];
               [self.articleList removeAllObjects];
               [self.articleList addObjectsFromArray:array];
               [controller.searchResultsTableView reloadData];
    }];
    return YES;
}


- (void)searchDisplayController:(UISearchDisplayController *)controller didLoadSearchResultsTableView:(UITableView *)tableView {
    [self configureTableView:tableView];
}

- (void)configureTableView:(UITableView *)tableView {
    tableView.separatorInset = UIEdgeInsetsZero;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    UIView *tableFooterViewToGetRidOfBlankRows = [[UIView alloc] initWithFrame:CGRectZero];
    tableFooterViewToGetRidOfBlankRows.backgroundColor = [UIColor clearColor];
    tableView.tableFooterView = tableFooterViewToGetRidOfBlankRows;
}

@end
