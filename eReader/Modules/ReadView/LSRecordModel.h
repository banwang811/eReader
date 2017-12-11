//
//  LSRecordModel.h
//  eReader
//
//  Created by banwang on 2017/12/11.
//  Copyright © 2017年 guanqun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LSRecordModel : NSObject

@property (nonatomic,strong) LSChapterModel *chapterModel;  //阅读的章节
@property (nonatomic) NSUInteger page;  //阅读的页数
@property (nonatomic) NSUInteger chapter;    //阅读的章节数
@property (nonatomic) NSUInteger chapterCount;  //总章节数

@end
