//
//  LSLibraryController.m
//  eReader
//
//  Created by banwang on 2017/12/11.
//  Copyright © 2017年 guanqun. All rights reserved.
//

#import "LSLibraryController.h"
#import "LSLibraryCell.h"
#import "LSPageController.h"

@interface LSLibraryController ()<UITableViewDelegate,UITableViewDataSource,UISearchControllerDelegate>

@property (weak, nonatomic) IBOutlet UITableView          *tableView;

@end

@implementation LSLibraryController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = self.model.title;
    [LSService getChapterList:self.model.libraryUrl
            completionHandler:^(NSString *string, NSURLResponse *response, NSError *error) {
        NSArray *content = [[LSEngine shareEngine] getChapterList:string];
                for (NSDictionary *info in content) {
                    LSChapterModel *model = [[LSChapterModel alloc] init];
                    model.title = [info objectForKey:@"name"];
                    model.url = [info objectForKey:@"url"];
                    [self.model.chapters addObject:model];
                }
                [self.tableView reloadData];
    }];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    LSChapterModel *model = [self.model.chapters objectAtIndex:indexPath.row];
    LSRecordModel *recordModel = [[LSRecordModel alloc] init];
    recordModel.chapter = indexPath.row;
    recordModel.page = 0;
    recordModel.chapterModel = model;
    self.model.recordModel = recordModel;
    LSPageController *con = [[LSPageController alloc] init];
    con.model = self.model;
    [self.navigationController pushViewController:con animated:YES];
//    __block LSChapterModel *model = [self.model.chapters objectAtIndex:indexPath.row];
//    [LSService getChapterContent:model.url completionHandler:^(NSString *string, NSURLResponse *response, NSError *error) {
//        NSString *content = [[LSEngine shareEngine] getArticleContent:string];
//        NSLog(@"%@",content);
//        model = [LSPrase praseChapterWithContent:content chapterModel:model];
//        LSPageController *con = [[LSPageController alloc] init];
//        [con.chapterModels addObject:model];
//        [self.navigationController pushViewController:con animated:YES];
//    }];
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    LSLibraryCell  *cell = [tableView dequeueReusableCellWithIdentifier:@"LSLibraryCell"];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"LSLibraryCell" owner:nil options:0] firstObject];
    }
    LSChapterModel *model = [self.model.chapters objectAtIndex:indexPath.row];
    cell.model = model;
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.model.chapters.count;
}

@end
