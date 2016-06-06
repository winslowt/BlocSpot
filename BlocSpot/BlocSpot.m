//
//  BlocSpot.m
//  BlocSpot
//
//  Created by Tony  Winslow on 4/25/16.
//  Copyright © 2016 Bloc. All rights reserved.
//

#import "BlocSpot.h"
#import "TWCoreDataStack.h"
#import "BlocSpot+CoreDataProperties.h"

@implementation BlocSpot

// Insert code here to add functionality to your managed object subclass

@dynamic pointOfInterest;
@dynamic date;
@dynamic image;
@dynamic name;
@dynamic note;
@dynamic locationLock;


- (NSString *)sectionName {
    NSDate *date = [NSDate date];
    //convenience initiliazer for NSDate
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MMM yyyy"];
    
    return [dateFormatter stringFromDate:date];
}

+(BlocSpot *)existingMarkForCoordinates:(CLLocationCoordinate2D)coordinate {
    
    NSFetchRequest *fetchMarks = [[NSFetchRequest alloc] initWithEntityName:@"BlocSpot"];
    NSError *error = nil;
    NSArray *results =[[TWCoreDataStack defaultStack].managedObjectContext executeFetchRequest:fetchMarks error:&error];
    if (error) {
        NSLog(@"Existing mark didn't work");
    }
    for (BlocSpot *spot in results) {
        if (spot.latitude.doubleValue == coordinate.latitude && spot.longitude.doubleValue == coordinate.longitude) {
            return spot;
        }
    }
    return nil;
}

@end
