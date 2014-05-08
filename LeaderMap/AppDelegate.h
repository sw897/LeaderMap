//
//  AppDelegate.h
//  LeaderMap
//
//  Created by sw on 14-4-29.
//  Copyright (c) 2014年 sw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate,NSXMLParserDelegate>
{
    NSMutableArray *mapSources;
}
@property (strong, nonatomic) UIWindow *window;

//@property (retain,nonatomic) NSMutableArray *mapSources;
//@property (retain,nonatomic) MapSourceConfig *mapSource;

@end
