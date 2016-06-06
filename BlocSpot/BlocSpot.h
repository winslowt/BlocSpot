//
//  BlocSpot.h
//  BlocSpot
//
//  Created by Tony  Winslow on 4/25/16.
//  Copyright © 2016 Bloc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import <MapKit/MapKit.h>


NS_ASSUME_NONNULL_BEGIN

@interface BlocSpot : NSManagedObject

// Insert code here to declare functionality of your managed object subclass

@property (nullable, nonatomic, retain) NSString *pointOfInterest;
@property (nonatomic) NSDate* date;
@property (nullable, nonatomic, retain) NSData *image;
@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSString *note;
@property (nonatomic, retain) NSString *locationLock;

+(BlocSpot *)existingMarkForCoordinates:(CLLocationCoordinate2D)coordinate;


@end

NS_ASSUME_NONNULL_END




