//
//  DataSource.m
//  BlocSpot
//
//  Created by Tony  Winslow on 3/26/16.
//  Copyright © 2016 Bloc. All rights reserved.
//

#import "DataSource.h"

@implementation DataSource

+ (instancetype) sharedInstance {
    static dispatch_once_t once;
    static id sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

@end
