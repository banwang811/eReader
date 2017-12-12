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
#import "LSBookCell.h"
#import "LSLibraryController.h"

@interface LSBookShelfController ()<UITableViewDelegate,UITableViewDataSource,UISearchControllerDelegate>{
    UISearchDisplayController           *searchDisplayController;
    UISearchBar                         *searchBar;
    LSSearchDelegate                    *searchDelegate;
    UISearchController                  *searchController;

}
@property (nonatomic, strong)JSContext *context;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray        *dataArray;
@end

@implementation LSBookShelfController

- (instancetype)init{
    if (self = [super init]) {
        self.dataArray = [NSMutableArray array];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"书架";
    [self layoutSearchBar];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didSelctBook:)
                                                 name:LSDidSelectBookNotification object:nil];
//    [LSService getRecentlyChapter:@"http://m.book9.net/wapbook/10.html" completionHandler:^(NSString *string, NSURLResponse *response, NSError *error) {
//        NSArray *content = [[LSEngine shareEngine] getRecentlyChapter:string];
//        NSLog(@"%@",content);
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
    searchDelegate.searchDisplayController = searchDisplayController;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LSBookCell  *cell = [tableView dequeueReusableCellWithIdentifier:@"LSBookCell"];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"LSBookCell" owner:nil options:0] firstObject];
    }
    LSReadModel *model = [self.dataArray objectAtIndex:indexPath.row];
    cell.model = model;
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    LSReadModel *model = [self.dataArray objectAtIndex:indexPath.row];
    LSLibraryController *controller = [[LSLibraryController alloc] init];
    controller.model = model;
    
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)didSelctBook:(NSNotification *)noti{
    LSReadModel *model = (LSReadModel *)noti.object;
    [self addBook:model];
    LSLibraryController *controller = [[LSLibraryController alloc] init];
    controller.model = model;
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)addBook:(LSReadModel *)model{
    BOOL shouldAdd = YES;
    for (LSReadModel *book in self.dataArray){
        if ([book.url isEqualToString:model.url]) {
            shouldAdd = NO;
            break;
        }
    }
    if (shouldAdd) {
        [self.dataArray addObject:model];
        [self.tableView reloadData];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
