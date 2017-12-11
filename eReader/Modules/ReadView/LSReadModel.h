//
//  LSReadModel.h
//  eReader
//
//  Created by banwang on 2017/12/6.
//  Copyright © 2017年 guanqun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LSChapterModel.h"

@interface LSReadModel : NSObject<NSCoding>

@property (nonatomic, strong) NSString          *url;
@property (nonatomic, strong) NSString          *title;
@property (nonatomic, strong) NSString          *author;
@property (nonatomic, strong) NSString          *discripe;
@property (nonatomic, strong) NSString          *libraryUrl;
@property (nonatomic, strong) NSMutableArray <LSChapterModel *>*chapters;

@end
