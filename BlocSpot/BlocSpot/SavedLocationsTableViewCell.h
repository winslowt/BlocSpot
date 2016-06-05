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

@interface SavedLocationsTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *locationNameLabel;
@property (weak, nonatomic) IBOutlet UITextView *sameTextView;


@end
