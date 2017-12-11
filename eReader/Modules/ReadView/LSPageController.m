//
//  LSPageController.m
//  eReader
//
//  Created by banwang on 2017/12/6.
//  Copyright © 2017年 guanqun. All rights reserved.
//

#import "LSPageController.h"
#import "LSReadingController.h"

@interface LSPageController ()<UIPageViewControllerDelegate,UIPageViewControllerDataSource>

{
    NSUInteger _chapter;    //当前显示的章节
    NSUInteger _page;       //当前显示的页数
    NSUInteger _chapterChange;  //将要变化的章节
    NSUInteger _pageChange;     //将要变化的页数
    BOOL _isTransition;     //是否开始翻页
}

@property (nonatomic, strong) UIPageViewController     *pageViewController;
@property (nonatomic, strong) LSChapterModel           *model;
@property (nonatomic, strong) LSReadingController      *readView;   //当前阅读视图


@end

@implementation LSPageController

- (instancetype)init{
    if (self = [super init]) {
        self.chapterModels = [NSMutableArray array];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addChildViewController:self.pageViewController];
    [self.view addSubview:self.pageViewController.view];
    [self.pageViewController setViewControllers:[NSArray arrayWithObject:[self readViewWithChapter:_chapter page:_page]]
                                      direction:UIPageViewControllerNavigationDirectionReverse
                                       animated:NO
                                     completion:nil];
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
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController{
    NSLog(@"%@",NSStringFromSelector(_cmd));
    _pageChange = _page;
    _chapterChange = _chapter;
    if (_pageChange == 0) {
        //判断是否更换章节
        if (_chapterChange > 0) {
            _chapterChange --;
            LSChapterModel *model = [self.chapterModels objectAtIndex:_chapterChange];
            _pageChange = model.pageCount - 1;
            return [self readViewWithChapter:_chapterChange page:_pageChange];
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
    LSChapterModel *model = [self.chapterModels lastObject];
    if (_pageChange == model.pageCount - 1) {
        //判断是否更换章节
        if (_chapterChange < self.chapterModels.count - 1) {
            _chapterChange ++;
            _pageChange = 0;
            return [self readViewWithChapter:_chapterChange page:_pageChange];
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
    LSChapterModel *model = [self.chapterModels objectAtIndex:_chapter];
    NSString *content = [model stringOfPage:page];
    LSReadingController *con = [LSReadingController new];
    con.content = content;
    con.page = page;
    con.chapter = chapter;
    return con;
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
