//
//  BlocSpot.m
//  BlocSpot
//
//  Created by Tony  Winslow on 4/25/16.
//  Copyright © 2016 Bloc. All rights reserved.
//

#import "BlocSpot.h"

@implementation BlocSpot

// Insert code here to add functionality to your managed object subclass

@dynamic pointOfInterest;
@dynamic date;
@dynamic image;
@dynamic name;
@dynamic note;


- (NSString *)sectionName {
    NSDate *date = [NSDate date];
    //convenience initiliazer for NSDate
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MMM yyyy"];
    
    return [dateFormatter stringFromDate:date];
}

@end
