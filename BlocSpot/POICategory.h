//
//  POICategory.h
//  BlocSpot
//
//  Created by Tony  Winslow on 4/28/16.
//  Copyright © 2016 Bloc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import <UIKit/UIKit.h>

@class BlocSpot;

NS_ASSUME_NONNULL_BEGIN

@interface POICategory : NSManagedObject


@property (nonatomic,strong) UIColor *color;


@end

NS_ASSUME_NONNULL_END

#import "POICategory+CoreDataProperties.h"
