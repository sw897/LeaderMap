//
//  MainViewController.h
//  LeaderMap
//
//  Created by sw on 14-5-8.
//  Copyright (c) 2014年 sw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MapSourceConfig.h"

@interface MainViewController : UIViewController <NSXMLParserDelegate>
{
    NSMutableArray *mapSources;
    MapSourceConfig *mapSource;
}
@end
