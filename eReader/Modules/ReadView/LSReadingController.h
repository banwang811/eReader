//
//  LSReadingController.h
//  eReader
//
//  Created by banwang on 2017/12/6.
//  Copyright © 2017年 guanqun. All rights reserved.
//

#import "LSBaseController.h"

@interface LSReadingController : LSBaseController

@property (nonatomic, strong) NSString        *content;
@property (nonatomic, assign) NSInteger       page;
@property (nonatomic, assign) NSInteger       chapter;

@end
