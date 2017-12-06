//
//  LSReadingController.m
//  eReader
//
//  Created by banwang on 2017/12/6.
//  Copyright © 2017年 guanqun. All rights reserved.
//

#import "LSReadingController.h"
#import "LSReadingView.h"

@interface LSReadingController ()

@property (nonatomic, strong) LSReadingView     *readingView;

@end

@implementation LSReadingController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.view addSubview:self.readingView];
}

- (LSReadingView *)readingView{
    if (_readingView == nil) {
        _readingView = [[LSReadingView alloc] initWithFrame:CGRectMake(LeftSpacing, TopSpacing, [UIScreen mainScreen].bounds.size.width-LeftSpacing - RightSpacing, [UIScreen mainScreen].bounds.size.height - TopSpacing - BottomSpacing)];
        _readingView.frameRef = [LSPrase parserContent:_content bouds:CGRectMake(0, 0, _readingView.frame.size.width,  _readingView.frame.size.height)];
    }
    return _readingView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
