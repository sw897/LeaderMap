//
//  AppDelegate.m
//  LeaderMap
//
//  Created by sw on 14-4-29.
//  Copyright (c) 2014年 sw. All rights reserved.
//

#import "AppDelegate.h"
#import "MapSourceConfig.h"
#import "LeaderMapViewController.h"

@implementation AppDelegate

//@synthesize mapSource=_mapSource;
//@synthesize mapSources=_mapSources;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // copy resource to document
    BOOL success;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    //for (NSString* filename in [NSArray arrayWithObjects:@"maps.xml", @"nightworld.mbtiles", nil]) {
    for (NSString* filename in [NSArray arrayWithObjects:@"maps.xml", nil]) {
        NSString *targetFile = [documentsDirectory stringByAppendingPathComponent:filename];
        success = [fileManager fileExistsAtPath:targetFile];
        if (!success) {
            NSString *sourceFile = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:filename];
            success = [fileManager copyItemAtPath:sourceFile toPath:targetFile error:&error];
        }
    }
    
    // get all maps config
    NSString *maps = [NSString stringWithFormat:@"%@/Documents/maps.xml", NSHomeDirectory()];
    if ([[NSFileManager defaultManager] fileExistsAtPath:maps])
    {
        NSFileHandle *file = [NSFileHandle fileHandleForReadingAtPath:maps];
        NSData *data = [file readDataToEndOfFile];
        [file closeFile];
        
        NSXMLParser *xmlParser = [[NSXMLParser alloc] initWithData:data];
        [xmlParser setDelegate:self];
        [xmlParser setShouldProcessNamespaces:NO];
        [xmlParser setShouldReportNamespacePrefixes:NO];
        [xmlParser setShouldResolveExternalEntities:NO];
        [xmlParser parse];
    }
    
    // init tabbar
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    UITabBarController *tabBarController = [[UITabBarController alloc] init];
    
    NSMutableArray *viewControllers = [NSMutableArray array];
    
    for (MapSourceConfig* mapSource in mapSources)
    {
        LeaderMapViewController *leaderMapViewController = [[LeaderMapViewController alloc] init];
        [leaderMapViewController setMapSource:mapSource];
        UIImage *image = nil;
        if([mapSource.type isEqualToString:@"filesystem"] || [mapSource.type isEqualToString:@"mbtile"])
            image = [UIImage imageNamed:@"offline.png"];
        else
            image = [UIImage imageNamed:@"online.png"];
        leaderMapViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:[NSString stringWithFormat:@"%@", mapSource.name] image:image tag:0];
        
        [viewControllers addObject:leaderMapViewController];
    }
    
    tabBarController.viewControllers = viewControllers;
    
    self.window.rootViewController = tabBarController;
    
    [self.window makeKeyAndVisible];
    
    return YES;

}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void) parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
    if([elementName isEqualToString:@"mapsources"]) {
        mapSources = [[NSMutableArray alloc] init];
    } else if ([elementName isEqualToString:@"mapsource"]) {
        MapSourceConfig* mapSource = [[MapSourceConfig alloc] init];
        mapSource.name = [attributeDict objectForKey:@"name"];
        mapSource.type = [attributeDict objectForKey:@"type"];
        mapSource.resource = [attributeDict objectForKey:@"resource"];
        mapSource.zoom = [[attributeDict objectForKey:@"zoom"] floatValue];
        [mapSources addObject:mapSource];
    }
}


@end
