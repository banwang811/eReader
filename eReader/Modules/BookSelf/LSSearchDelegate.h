//
//  LSSearchDelegate.h
//  eReader
//
//  Created by banwang on 2017/12/6.
//  Copyright © 2017年 guanqun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LSSearchDelegate : NSObject<UISearchBarDelegate,UISearchDisplayDelegate>

@property (nonatomic, strong) UISearchDisplayController           *searchDisplayController;

@end
