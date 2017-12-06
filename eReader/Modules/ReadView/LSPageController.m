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
@property (nonatomic, strong) NSMutableArray           *chapterModels;

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
    [self.pageViewController setViewControllers:[NSArray arrayWithObject:[UIViewController new]]
                                      direction:UIPageViewControllerNavigationDirectionReverse
                                       animated:NO
                                     completion:nil];
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
        [self.view addSubview:_pageViewController.view];
    }
    return _pageViewController;
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController{
    if (_page == 0) {
        //判断是否更换章节
        if (_chapter > 0) {
            _chapter --;
            LSChapterModel *model = [self.chapterModels objectAtIndex:_chapter];
            _page = model.pageCount - 1;
            return [self readViewWithChapter:_chapter page:_page];
        }else{
            //加载到第0章节
            return nil;
        }
    }else{
        _page --;
    }
    return [self readViewWithChapter:_chapter page:_page];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController{
    LSChapterModel *model = [self.chapterModels objectAtIndex:_chapter];
    if (_page == model.pageCount) {
        //判断是否更换章节
        if (_chapter < self.chapterModels.count) {
            _chapter ++;
            _page = 0;
            return [self readViewWithChapter:_chapter page:_page];
        }else{
            //加载到最后章节
            return nil;
        }
    }else{
        _page ++ ;
    }
    return [self readViewWithChapter:_chapter page:_page];
}

- (LSReadingController *)readViewWithChapter:(NSUInteger)chapter page:(NSUInteger)page{
    LSChapterModel *model = [self.chapterModels objectAtIndex:_chapter];
    NSString *content = [model stringOfPage:page];
    LSReadingController *con = [LSReadingController new];
    con.content = content;
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
