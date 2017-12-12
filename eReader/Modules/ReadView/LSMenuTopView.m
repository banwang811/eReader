//
//  LSMenuTopView.m
//  eReader
//
//  Created by banwang on 2017/12/12.
//  Copyright © 2017年 guanqun. All rights reserved.
//

#import "LSMenuTopView.h"

@interface LSMenuTopView()

@property (nonatomic,strong) UIButton *back;
@property (nonatomic,strong) UIButton *more;

@end

@implementation LSMenuTopView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup{
    [self setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.8]];
    [self addSubview:self.back];
}

- (UIButton *)back{
    if (!_back) {
        _back = [UIButton buttonWithType:UIButtonTypeCustom];
        [_back addTarget:self action:@selector(backView) forControlEvents:UIControlEventTouchUpInside];
        [_back setImage:[UIImage imageNamed:@"bg_back_white"] forState:UIControlStateNormal];
    }
    return _back;
}

- (void)backView{
    [[NSNotificationCenter defaultCenter] postNotificationName:LSDidPageBackNotification object:nil];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    _back.frame = CGRectMake(0, 24, 40, 40);
}

@end
