//
//  LSMenuView.h
//  eReader
//
//  Created by banwang on 2017/12/12.
//  Copyright © 2017年 guanqun. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LSMenuView;
@protocol LSMenuViewDelegate <NSObject>
@optional
- (void)menuViewDidHidden:(LSMenuView *)menu;
- (void)menuViewDidAppear:(LSMenuView *)menu;
@end

@interface LSMenuView : UIView

@property (nonatomic, assign) id<LSMenuViewDelegate>   delegate;

- (void)showAnimation:(BOOL)animation;

- (void)hiddenAnimation:(BOOL)animation;

@end
