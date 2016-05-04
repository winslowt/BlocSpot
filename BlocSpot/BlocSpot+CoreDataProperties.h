//
//  BlocSpot+CoreDataProperties.h
//  BlocSpot
//
//  Created by Tony  Winslow on 4/28/16.
//  Copyright © 2016 Bloc. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "BlocSpot.h"

NS_ASSUME_NONNULL_BEGIN

@interface BlocSpot (CoreDataProperties)

@property (nullable, nonatomic, retain) NSDate *date;
@property (nullable, nonatomic, retain) NSData *image;
@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSString *pointOfInterest;
@property (nullable, nonatomic, retain) NSManagedObject *category;

@end

NS_ASSUME_NONNULL_END
