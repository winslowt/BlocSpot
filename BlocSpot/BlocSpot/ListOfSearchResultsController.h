//
//  ListOfSearchResultsController.h
//  BlocSpot
//
//  Created by Tony  Winslow on 4/4/16.
//  Copyright © 2016 Bloc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/Mapkit.h>

@interface ListOfSearchResultsController : UIViewController

@property (nonatomic, weak) IBOutlet UITableView *tableView;

-(void)displayResults:(NSArray *)resultsArray;


@end
