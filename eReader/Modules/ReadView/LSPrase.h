//
//  LSPrase.h
//  eReader
//
//  Created by banwang on 2017/12/6.
//  Copyright © 2017年 guanqun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreText/CoreText.h>

@interface LSPrase : NSObject

+ (CTFrameRef)parserContent:(NSString *)content  bouds:(CGRect)bounds;

+ (LSChapterModel *)praseChapterWithContent:(NSString *)content chapterModel:(LSChapterModel *)model;

+ (NSDictionary *)parserAttribute:(LSYReadConfig *)config;

@end
