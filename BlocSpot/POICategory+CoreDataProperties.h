//
//  POICategory+CoreDataProperties.h
//  BlocSpot
//
//  Created by Tony  Winslow on 6/2/16.
//  Copyright © 2016 Bloc. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "POICategory.h"

NS_ASSUME_NONNULL_BEGIN

@interface POICategory (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *colorString;
@property (nullable, nonatomic, retain) NSData *logo;
@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSSet<BlocSpot *> *blocSpots;

@end

@interface POICategory (CoreDataGeneratedAccessors)

- (void)addBlocSpotsObject:(BlocSpot *)value;
- (void)removeBlocSpotsObject:(BlocSpot *)value;
- (void)addBlocSpots:(NSSet<BlocSpot *> *)values;
- (void)removeBlocSpots:(NSSet<BlocSpot *> *)values;

@end

NS_ASSUME_NONNULL_END
