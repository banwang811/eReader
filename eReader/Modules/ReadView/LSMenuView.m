//
//  LSMenuView.m
//  eReader
//
//  Created by banwang on 2017/12/12.
//  Copyright © 2017年 guanqun. All rights reserved.
//

#import "LSMenuView.h"
#import "LSMenuTopView.h"

#define AnimationDelay 0.3f
#define TopViewHeight 64.0f
#define BottomViewHeight 200.0f

@interface LSMenuView ()

@property (nonatomic, strong) LSMenuTopView       *topView;
@property (nonatomic, strong) LSMenuTopView       *bottomView;

@end

@implementation LSMenuView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (LSMenuTopView *)topView{
    if (_topView == nil) {
        _topView = [[LSMenuTopView alloc] init];
    }
    return _topView;
}

- (void)setup{
    self.backgroundColor = [UIColor clearColor];
    [self addSubview:self.topView];
    [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenSelf)]];
}

- (void)hiddenSelf{
    [self hiddenAnimation:YES];
}

- (void)showAnimation:(BOOL)animation{
    self.hidden = NO;
    [UIView animateWithDuration:animation?AnimationDelay:0 animations:^{
        _topView.frame = CGRectMake(0, 0, ViewSize(self).width, TopViewHeight);
        _bottomView.frame = CGRectMake(0, ViewSize(self).height - BottomViewHeight, ViewSize(self).width,BottomViewHeight);
    } completion:^(BOOL finished) {
        
    }];
    if ([self.delegate respondsToSelector:@selector(menuViewDidAppear:)]) {
        [self.delegate menuViewDidAppear:self];
    }
}

- (void)hiddenAnimation:(BOOL)animation{
    [UIView animateWithDuration:animation?AnimationDelay:0 animations:^{
        _topView.frame = CGRectMake(0, -TopViewHeight, ViewSize(self).width, TopViewHeight);
        _bottomView.frame = CGRectMake(0, ViewSize(self).height, ViewSize(self).width,BottomViewHeight);
    } completion:^(BOOL finished) {
        self.hidden = YES;
    }];
    if ([self.delegate respondsToSelector:@selector(menuViewDidHidden:)]) {
        [self.delegate menuViewDidHidden:self];
    }
}

- (void)layoutSubviews{
    [super layoutSubviews];
    _topView.frame = CGRectMake(0, -TopViewHeight, ViewSize(self).width,TopViewHeight);
    _bottomView.frame = CGRectMake(0, ViewSize(self).height, ViewSize(self).width,BottomViewHeight);
}

@end
