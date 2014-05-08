//
//  FsLayerViewController.m
//  LeaderMap
//
//  Created by sw on 14-5-7.
//  Copyright (c) 2014年 sw. All rights reserved.
//

#import "FsLayerViewController.h"

#import "Mapbox.h"
#import "RMFSMapSource.h"

@interface FsLayerViewController ()

@end

@implementation FsLayerViewController

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
    RMFSMapSource *fsSource = [[RMFSMapSource alloc] initWithPath:@"潍坊市地图"];
    RMMapView *mapView = [[RMMapView alloc] initWithFrame:self.view.bounds andTilesource:fsSource];
    mapView.showLogoBug = NO;
    mapView.hideAttribution = YES;
    mapView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    mapView.adjustTilesForRetinaDisplay = YES; // these tiles aren't designed specifically for retina, so make them legible
    mapView.zoom = 0;
    [self.view addSubview:mapView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
