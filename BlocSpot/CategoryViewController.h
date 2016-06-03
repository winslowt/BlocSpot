//
//  CategoryViewController.h
//  BlocSpot
//
//  Created by Tony  Winslow on 5/7/16.
//  Copyright © 2016 Bloc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "POICategory.h"

@class BlocSpot;

#define DismissedCategory @"DismissedCategory"

@interface CategoryViewController : UITableViewController


@property (nonatomic, strong) BlocSpot *placeOfInterest;
@property (nonatomic, strong) POICategory *categoryToDisplay;

@end
