//
//  PoiDetailController.h
//  BlocSpot
//
//  Created by Tony  Winslow on 4/14/16.
//  Copyright © 2016 Bloc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@class BlocSpot;

@interface PoiDetailController : UIViewController

//@property (nonatomic, strong) MKMapItem *specialMapItem;
@property (nonatomic, strong) BlocSpot *placeOfInterest;

@end
