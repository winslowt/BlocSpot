//
//  ListOfSearchResultsController.h
//  BlocSpot
//
//  Created by Tony  Winslow on 4/4/16.
//  Copyright © 2016 Bloc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/Mapkit.h>
#import "MapSearch.h"

@protocol ClickLocation <NSObject>


- (void)selectedLocationOnSearchController:(MKMapItem *)mapItem;

//1.define protocol, create property of type in class that wants to use delegate, implement protocol in class that wants to use it, and set that class that implements it as the delegate


@end


@interface ListOfSearchResultsController : UIViewController <MapSearchProtocol>

@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, weak) id <ClickLocation> delegate;

-(void)displayResults:(NSArray *)resultsArray;


@end
