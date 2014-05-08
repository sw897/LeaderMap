//
//  MainViewController.m
//  LeaderMap
//
//  Created by sw on 14-5-8.
//  Copyright (c) 2014年 sw. All rights reserved.
//

#import "MainViewController.h"
#import "LeaderMapViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

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
    
//    NSMutableArray *tileSetList = [[NSMutableArray alloc] init];
//    NSString *documentDir = [NSString stringWithFormat:@"%@/Documents", NSHomeDirectory()];
//    NSFileManager *fileManager = [NSFileManager defaultManager];
//    NSArray *tempArray = [fileManager contentsOfDirectoryAtPath:documentDir error:nil];
//    for (NSString *fileName in tempArray) {
//        BOOL flag = YES;
//        NSString *fullPath = [documentDir stringByAppendingPathComponent:fileName];
//        if ([fileManager fileExistsAtPath:fullPath isDirectory:&flag]) {
//            if (flag) {
//                NSString *config = [fullPath stringByAppendingPathComponent:@"ImageProperties.xml"];
//                if ([fileManager fileExistsAtPath:config])
//                {
//                    [tileSetList addObject:fileName];
//                    NSLog(@"%@", fileName);
//                }
//            }
//        }
//    }
    
    NSString *maps = [NSString stringWithFormat:@"%@/Documents/maps.xml", NSHomeDirectory()];
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:maps])
    {
        NSFileHandle *file = [NSFileHandle fileHandleForReadingAtPath:maps];
        NSData *data = [file readDataToEndOfFile];
        [file closeFile];
        
        //NSString *dataString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        //NSLog(@"%@",dataString);
        
        NSXMLParser *xmlParser = [[NSXMLParser alloc] initWithData:data];
        [xmlParser setDelegate:self];
        [xmlParser setShouldProcessNamespaces:NO];
        [xmlParser setShouldReportNamespacePrefixes:NO];
        [xmlParser setShouldResolveExternalEntities:NO];
        [xmlParser parse];
    }
    else
    {
        NSString * info = @"no mapresource config file";
        NSLog(@"%@", info);
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"title" message:info delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"otherbuttontitles", nil];
        [alert show];
    }
    
    // add button
    CGRect frame = CGRectMake(10.0f, 10.0f, 120.0f, 50.0f);
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    button.frame = frame;
    
    [button setTitle:@"title"forState:UIControlStateNormal];
    
    button.backgroundColor = [UIColor clearColor];
    
    button.tag = 2000;
    
    [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:button];
}

-(IBAction)buttonClicked:(id)sender
{
    LeaderMapViewController *leaderMapViewController = [[LeaderMapViewController alloc] init];
    mapSource = [mapSources objectAtIndex:1];
    [leaderMapViewController setMapSourceConfig:mapSource];
    [self setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
    [self presentModalViewController:leaderMapViewController animated:YES];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void) parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
    if([elementName isEqualToString:@"mapsources"]) {
        mapSources = [[NSMutableArray alloc] init];
    } else if ([elementName isEqualToString:@"mapsource"]) {
        mapSource = [[MapSourceConfig alloc] init];
        mapSource.name = [attributeDict objectForKey:@"name"];
        mapSource.type = [attributeDict objectForKey:@"type"];
        mapSource.resource = [attributeDict objectForKey:@"resource"];
        mapSource.zoom = [[attributeDict objectForKey:@"zoom"] floatValue];
        [mapSources addObject:mapSource];
    }
}

@end
