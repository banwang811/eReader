//
//  LSPageController.m
//  eReader
//
//  Created by banwang on 2017/12/6.
//  Copyright © 2017年 guanqun. All rights reserved.
//

#import "LSPageController.h"
#import "LSReadingController.h"
#import "LSMenuView.h"

@interface LSPageController ()<UIPageViewControllerDelegate,UIPageViewControllerDataSource>

{
    NSUInteger _chapter;    //当前显示的章节
    NSUInteger _page;       //当前显示的页数
    NSUInteger _chapterChange;  //将要变化的章节
    NSUInteger _pageChange;     //将要变化的页数
    BOOL _isTransition;     //是否开始翻页
}

@property (nonatomic, strong) UIPageViewController     *pageViewController;
@property (nonatomic, strong) LSReadingController      *readView;   //当前阅读视图
@property (nonatomic, strong) LSMenuView               *menuView;

@end

@implementation LSPageController

- (void)viewDidLoad {
    [super viewDidLoad];
    _page = self.model.recordModel.page;
    _chapter = self.model.recordModel.chapter;
    [self addChildViewController:self.pageViewController];
    [self.view addSubview:self.pageViewController.view];
    [self loadChapter:_chapter page:_page];
    
    [self.view addGestureRecognizer:({
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showToolMenu)];
        tap.delegate = self;
        tap;
    })];
    [self.view addSubview:self.menuView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(backClick)
                                                 name:LSDidPageBackNotification
                                               object:nil];
}

- (void)backClick{
    [self.navigationController popViewControllerAnimated:YES];
}

- (LSMenuView *)menuView{
    if (_menuView == nil) {
        _menuView = [[LSMenuView alloc] init];
        _menuView.hidden = YES;
    }
    return _menuView;
}

- (void)showToolMenu{
    [self.menuView showAnimation:YES];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIPageViewController *)pageViewController{
    if (!_pageViewController) {
        _pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStylePageCurl navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
        _pageViewController.delegate = self;
        _pageViewController.dataSource = self;
    }
    return _pageViewController;
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    _pageViewController.view.frame = self.view.frame;
    _menuView.frame = self.view.frame;
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController{
    NSLog(@"%@",NSStringFromSelector(_cmd));
    _pageChange = _page;
    _chapterChange = _chapter;
    if (_pageChange == 0) {
        //判断是否更换章节
        if (_chapterChange > 0) {
            //加载上一章
            _chapterChange --;
            //判断上一章内容是否存在
            LSChapterModel *model = [self.model.chapters objectAtIndex:_chapterChange];
            if (model.content && model.content.length > 0) {
                _pageChange = model.pageCount - 1;
               return [self readViewWithChapter:_chapterChange page:_pageChange];
            }else{
                _pageChange = model.pageCount - 1;
                [self loadChapter:_chapterChange page:_pageChange];
                return nil;
            }
        }else{
            //加载到第0章节
            return nil;
        }
    }else{
        _pageChange --;
    }
    return [self readViewWithChapter:_chapterChange page:_pageChange];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController{
    NSLog(@"%@",NSStringFromSelector(_cmd));
    _pageChange = _page;
    _chapterChange = _chapter;
    LSChapterModel *model = [self.model.chapters objectAtIndex:_chapterChange];
    if (_pageChange == model.pageCount - 1) {
        //判断是否更换章节
        if (_chapterChange < self.model.chapters.count - 1) {
            //加载下一章
            _chapterChange ++;
            _pageChange = 0;
            //判断下一章内容是否存在
            LSChapterModel *model = [self.model.chapters objectAtIndex:_chapterChange];
            if (model.content && model.content.length > 0) {
                return [self readViewWithChapter:_chapterChange page:0];
            }else{
                [self loadChapter:_chapterChange page:_pageChange];
                return nil;
            }
        }else{
            //加载到最后章节
            return nil;
        }
    }else{
        _pageChange ++ ;
    }
    return [self readViewWithChapter:_chapterChange page:_pageChange];
}

- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray *)previousViewControllers transitionCompleted:(BOOL)completed
{
    NSLog(@"%@",NSStringFromSelector(_cmd));
    if (!completed) {
        LSReadingController *readView = previousViewControllers.firstObject;
        _readView = readView;
        _page = readView.page;
        _chapter = readView.chapter;
    }
}
- (void)pageViewController:(UIPageViewController *)pageViewController willTransitionToViewControllers:(NSArray<UIViewController *> *)pendingViewControllers
{
    NSLog(@"%@",NSStringFromSelector(_cmd));
    _chapter = _chapterChange;
    _page = _pageChange;
}

- (LSReadingController *)readViewWithChapter:(NSUInteger)chapter page:(NSUInteger)page{
    LSChapterModel *model = [self.model.chapters objectAtIndex:chapter];
    NSString *content = [model stringOfPage:page];
    LSReadingController *con = [LSReadingController new];
    con.content = content;
    con.page = page;
    con.chapter = chapter;
    return con;
}

- (void)loadChapter:(NSInteger)chapter  page:(NSInteger)page{
    __block LSChapterModel *model = [self.model.chapters objectAtIndex:chapter];
    __block NSUInteger pageCount = page;
    [LSService getChapterContent:model.url completionHandler:^(NSString *string, NSURLResponse *response, NSError *error) {
        NSString *content = [[LSEngine shareEngine] getArticleContent:string];
        NSLog(@"%@",content);
        model = [LSPrase praseChapterWithContent:content chapterModel:model];
        if (page == -1) {
            pageCount = model.pageCount - 1;
        }
        _page = pageCount;
        _chapter = chapter;
        [self.pageViewController setViewControllers:[NSArray arrayWithObject:[self readViewWithChapter:chapter page:pageCount]]
                                          direction:UIPageViewControllerNavigationDirectionReverse
                                           animated:NO
                                         completion:nil];
    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
