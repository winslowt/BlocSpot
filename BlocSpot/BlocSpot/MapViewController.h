//
//  MapViewController.h
//  BlocSpot
//
//  Created by Tony  Winslow on 3/24/16.
//  Copyright © 2016 Bloc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/Mapkit.h>
#import <MapKit/MKAnnotation.h>
#import <CoreLocation/CoreLocation.h>




@interface MapViewController : UIViewController <MKMapViewDelegate, CLLocationManagerDelegate>

@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) CLGeocoder * geoLocation;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *SavedLocationsController;
@property (nonatomic, weak) IBOutlet MKMapView *mapView;

-(void)setOutsideBox:(UITapGestureRecognizer *)outsideBox;

@end
