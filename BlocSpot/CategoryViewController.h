//
//  CategoryViewController.h
//  BlocSpot
//
//  Created by Tony  Winslow on 5/7/16.
//  Copyright © 2016 Bloc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BlocSpot;

#define CategoryPicked @"CategoryPicked"

@interface CategoryViewController : UITableViewController


@property (nonatomic, strong) BlocSpot *placeOfInterest;


@end
