//
//  LeaderMapViewController.h
//  LeaderMap
//
//  Created by sw on 14-5-8.
//  Copyright (c) 2014年 sw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MapSourceConfig.h"
#import "Mapbox.h"

@interface LeaderMapViewController : UIViewController

//@property (retain,nonatomic) NSMutableArray *mapSources;
@property (retain,nonatomic) MapSourceConfig *mapSource;
@property (retain,nonatomic) RMMapView *mapView;

-(RMMapView*)createMapView;
- (void) unzip:(NSString *)zipfile;
@end
