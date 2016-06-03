//
//  BlocSpot+CoreDataProperties.h
//  BlocSpot
//
//  Created by Tony  Winslow on 6/2/16.
//  Copyright © 2016 Bloc. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "BlocSpot.h"

@class POICategory; 
NS_ASSUME_NONNULL_BEGIN

@interface BlocSpot (CoreDataProperties)

@property (nullable, nonatomic, retain) NSDate *date;
@property (nullable, nonatomic, retain) NSData *image;
@property (nullable, nonatomic, retain) NSNumber *latitude;
@property (nullable, nonatomic, retain) NSNumber *longitude;
@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSString *note;
@property (nullable, nonatomic, retain) NSString *pointOfInterest;
@property (nullable, nonatomic, retain) POICategory *category;


@end

NS_ASSUME_NONNULL_END
