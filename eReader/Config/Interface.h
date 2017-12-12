//
//  Interface.h
//  LSYReader
//
//  Created by banwang on 2017/12/5.
//  Copyright © 2017年 okwei. All rights reserved.
//

#ifndef Interface_h
#define Interface_h

#define TopSpacing 40.0f
#define BottomSpacing 40.0f
#define LeftSpacing 15.0f
#define RightSpacing  15.0f

#define ViewSize(view)  (view.frame.size)

//屏幕宽度
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
//屏幕高度
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

#define LSDidSelectBookNotification  @"LSDidSelectBookNotification"
#define LSDidPageBackNotification    @"LSDidPageBackNotification"


#define LSAppDelegate ((AppDelegate *)[UIApplication sharedApplication].delegate)

#define SEARCH_URL               @"http://m.book9.net/s.php?"

#define SERVER_ADDRESS           @"http://m.book9.net"

#endif /* Interface_h */
