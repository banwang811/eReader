//
//  LSReadingView.h
//  eReader
//
//  Created by banwang on 2017/12/6.
//  Copyright © 2017年 guanqun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreText/CoreText.h>

@interface LSReadingView : UIView

@property (nonatomic,  assign) CTFrameRef        frameRef;
@property (nonatomic , strong) NSString         *content;

@end
