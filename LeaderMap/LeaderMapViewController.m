//
//  LeaderMapViewController.m
//  LeaderMap
//
//  Created by sw on 14-5-8.
//  Copyright (c) 2014年 sw. All rights reserved.
//

#import "LeaderMapViewController.h"

#import "Mapbox.h"
#import "RMFSMapSource.h"
#import "RMMapboxSource.h"
#import "RMMBTilesSource.h"
#import "RMGenericMapSource.h"
#import "RMTianDiTuMapSource.h"

@interface LeaderMapViewController ()

@end

@implementation LeaderMapViewController

@synthesize mapSource=_mapSource;
//@synthesize mapSources=_mapSources;
@synthesize mapView=_mapView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    // create and add mapview
    _mapView = [self createMapView];
    [self.view addSubview:_mapView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backOff:(id)sender
{
    //[self dismissModalViewControllerAnimated:YES];
    [self.navigationController popViewControllerAnimated:YES];
}

-(RMMapView*)createMapView
{
    RMMapView *mapView = nil;
    RMAbstractMercatorTileSource *mapSource = nil;
    
    NSString *resource = [self.mapSource resource];
    NSString *type = [self.mapSource type];
    float zoom = [self.mapSource zoom];

    
    if([type isEqualToString:@"filesystem"]) {
        NSArray *res = [resource componentsSeparatedByString:@","];
        NSInteger count = [res count];
        NSString *path = [res objectAtIndex:0];
        path = [NSString stringWithFormat:@"%@/Documents/%@",NSHomeDirectory(), path];
        float minZoom = 0.;
        float maxZoom = 6.;
        if (count > 1) {
            minZoom = [[res objectAtIndex:1] floatValue];
        }
        if (count > 2) {
            maxZoom = [[res objectAtIndex:2] floatValue];
        }
        mapSource = [[RMFSMapSource alloc] initWithPath:path minZoom:minZoom maxZoom:maxZoom];
    } else if ([type isEqualToString:@"mbtile"]) {
        NSString *path = [NSString stringWithFormat:@"%@/Documents/%@", NSHomeDirectory(), resource];
        mapSource = [[RMMBTilesSource alloc] initWithTileSetResource:path ofType:@"mbtiles"];
    } else if ([type isEqualToString:@"tianditu"]) {
        mapSource = [[RMTianDiTuMapSource alloc] initWithHost:resource];
    } else if ([type isEqualToString:@"mapbox"]) {
        NSArray *mapIds = [resource componentsSeparatedByString:@","];
        NSString *kRetinaMapID = [mapIds objectAtIndex:0];
        NSString *kNormalMapID = [mapIds objectAtIndex:1];
        mapSource = [[RMMapboxSource alloc] initWithMapID:(([[UIScreen mainScreen] scale] > 1.0) ? kRetinaMapID : kNormalMapID)];
    } else if([type isEqualToString:@"general"]) {
        NSArray *res = [resource componentsSeparatedByString:@","];
        NSInteger count = [res count];
        NSString *host = [res objectAtIndex:0];
        NSString *key = @"";
        float minZoom = 0.;
        float maxZoom = 18.;
        if(count > 1)
            key = [res objectAtIndex:1];
        if (count > 2) {
            minZoom = [[res objectAtIndex:2] floatValue];
        }
        if (count > 3) {
            maxZoom = [[res objectAtIndex:3] floatValue];
        }
        mapSource = [[RMGenericMapSource alloc] initWithHost:host tileCacheKey:key minZoom:minZoom maxZoom:maxZoom];
    }
    mapView = [[RMMapView alloc] initWithFrame:self.view.bounds andTilesource:mapSource];
    mapView.showLogoBug = NO;
    mapView.hideAttribution = YES;
    mapView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    mapView.adjustTilesForRetinaDisplay = YES;
    mapView.zoom = zoom;
    mapView.minZoom = mapSource.minZoom;
    mapView.maxZoom = mapSource.maxZoom;
    return mapView;
}


@end
