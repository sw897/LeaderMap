//
//  MapSourceConfig.h
//  LeaderMap
//
//  Created by sw on 14-5-8.
//  Copyright (c) 2014年 sw. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface MapSourceConfig : NSObject

@property (nonatomic,retain) NSString *name;
@property (nonatomic,retain) NSString *type;
@property (nonatomic,retain) NSString *resource;
@property float zoom;
@end
