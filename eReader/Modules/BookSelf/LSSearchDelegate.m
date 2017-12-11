//
//  LSSearchDelegate.m
//  eReader
//
//  Created by banwang on 2017/12/6.
//  Copyright © 2017年 guanqun. All rights reserved.
//

#import "LSSearchDelegate.h"
#import "LSBookCell.h"

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
    LSBookCell  *cell = [tableView dequeueReusableCellWithIdentifier:@"LSBookCell"];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"LSBookCell" owner:nil options:0] firstObject];
    }
    LSReadModel *model = [self.articleList objectAtIndex:indexPath.row];
    cell.model = model;
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.articleList.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString{
    searchString = [searchString stringByReplacingOccurrencesOfString:@" " withString:@""];
    [LSService searchArticle:searchString
           completionHandler:^(NSString *string, NSURLResponse *response, NSError *error) {
                NSArray *array = [[LSEngine shareEngine] searchArticleList:string];
               [self.articleList removeAllObjects];
               for (NSDictionary *info in array) {
                   LSReadModel *model = [[LSReadModel alloc] init];
                   [model setValuesForKeysWithDictionary:info];
                   [self.articleList addObject:model];
               }
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
