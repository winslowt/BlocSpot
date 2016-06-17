//
//  SavedLocationsTableViewCell.h
//  BlocSpot
//
//  Created by Tony  Winslow on 4/16/16.
//  Copyright © 2016 Bloc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SavedLocationsTableViewController.h"
#import "PoiDetailController.h"

@class SavedLocationsTableViewCell;
@class BlocSpot;

@protocol ShareLocationDelegate <NSObject>

- (void)didLongPressCell:(SavedLocationsTableViewCell *)cell;

@end

@interface SavedLocationsTableViewCell : UITableViewCell <NSObject>

@property (weak, nonatomic) IBOutlet UILabel *locationNameLabel;
@property (weak, nonatomic) IBOutlet UITextView *sameTextView;
@property (nonatomic, strong) UILongPressGestureRecognizer *longPressGestureRecognizer;
@property (nonatomic, weak) id<ShareLocationDelegate> delegate; 
@property (nonatomic, strong) BlocSpot *blocLocation;
@property (weak, nonatomic) IBOutlet UIImageView *imageForCategory;

@end
