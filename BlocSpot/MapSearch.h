//
//  MapSearch.h
//  BlocSpot
//
//  Created by Tony  Winslow on 3/21/16.
//  Copyright © 2016 Bloc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/Mapkit.h>

@protocol MapSearchProtocol

- (void)foundResults:(NSArray *)resultsArray;
- (void)errorFound:(NSString *)failureReason;


@end

@interface MapSearch : NSObject


@property (nonatomic, weak)id <MapSearchProtocol> delegate;
@property (nonatomic, strong) CLLocationManager *locationManager;


//delegate can be any class that implements search protocol


- (void)searchWithTerm:(NSString *)searchString;


@end
