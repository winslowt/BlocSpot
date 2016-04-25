//
//  BlocSpot.h
//  BlocSpot
//
//  Created by Tony  Winslow on 4/25/16.
//  Copyright © 2016 Bloc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

NS_ASSUME_NONNULL_BEGIN

@interface BlocSpot : NSManagedObject

// Insert code here to declare functionality of your managed object subclass

@property (nullable, nonatomic, retain) NSString *pointOfInterest;
@property (nonatomic) NSTimeInterval date;
@property (nullable, nonatomic, retain) NSData *image;
@property (nullable, nonatomic, retain) NSString *name;



@end

NS_ASSUME_NONNULL_END

#import "BlocSpot+CoreDataProperties.h"
