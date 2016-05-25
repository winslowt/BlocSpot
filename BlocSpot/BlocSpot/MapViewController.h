//
//  MapViewController.h
//  BlocSpot
//
//  Created by Tony  Winslow on 3/24/16.
//  Copyright © 2016 Bloc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@class BlocSpot;

@class MKMapView;
@class MKAnnotationView;
@class NSDataDetector;
@class CLLocationManager;


#define BlocSpotSelected @"BlocSpotSelected"


@interface MapViewController : UIViewController <MKMapViewDelegate, CLLocationManagerDelegate>

@property (nonatomic, strong) CLLocationManager *locationManager;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *SavedLocationsController;
@property (nonatomic, weak) IBOutlet MKMapView *mapView;
@property (nonatomic, strong) BlocSpot *itemToDisplay;



@end
