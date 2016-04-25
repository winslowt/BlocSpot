//
//  MapViewController.m
//  BlocSpot
//
//  Created by Tony  Winslow on 3/24/16.
//  Copyright © 2016 Bloc. All rights reserved.
//

#import "MapViewController.h"
#import "MapSearch.h"
#import <MapKit/MKAnnotation.h>
#import "ListOfSearchResultsController.h"
#import "PoiDetailController.h"
#import "CallOutAnnotationView.h"
#import "TWCoreDataStack.h"
#import "BlocSpot.h"
#import "PointOfInterest.h"


@class MKMapView;
@class locationServicesEnabled;
@class MKAnnotationView;
@class NSDataDetector;



@interface MapViewController () <UISearchControllerDelegate, UITableViewDataSource, UISearchBarDelegate, UISearchResultsUpdating, MapSearchProtocol, ClickLocation, UIViewControllerTransitioningDelegate, UINavigationControllerDelegate>


@property (nonatomic,strong) NSArray *resultsArray;
@property (nonatomic, strong) MapSearch *mapSearch;
@property(nonatomic, weak) id< UISearchResultsUpdating > searchResultsUpdater;
@property (nonatomic, strong) UISearchController *searchController;
@property(nonatomic, getter=isEditing) BOOL isSearching;
@property (nonatomic, strong) UITableView *tableView;
@property (strong, nonatomic) NSMutableArray* allTableData;
@property (nonatomic, strong) MKMapItem *mapItem;

@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.locationManager = [[CLLocationManager alloc] init];
    [self.locationManager requestWhenInUseAuthorization];
    
    self.mapSearch = [[MapSearch alloc] init];
    self.mapSearch.delegate = self;

    self.mapView.delegate = self;
    [[self mapView] setShowsUserLocation:YES];
    [[self locationManager] setDelegate:self];
    [[self locationManager] setDesiredAccuracy:kCLLocationAccuracyBest];
    [[self locationManager] startUpdatingLocation];
    self.mapView.showsUserLocation = YES;
    [self.mapView setMapType:MKMapTypeStandard];
    [self.mapView setZoomEnabled:YES];
    [self.mapView setScrollEnabled:YES];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ListOfSearchResultsController *resultsController = (ListOfSearchResultsController*)[storyboard instantiateViewControllerWithIdentifier:@"ListOfSearchResultsController"];
    resultsController.delegate = self;
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:resultsController];
    self.searchController.searchResultsUpdater = self;
    self.searchController.dimsBackgroundDuringPresentation = NO;
    self.searchController.searchBar.delegate = self;
    self.mapSearch.delegate = (ListOfSearchResultsController*)self.searchController.searchResultsController;
    self.definesPresentationContext = YES;
    [self.view addSubview:self.searchController.searchBar];
    
    self.searchController.searchBar.frame = CGRectMake(0, 0, self.view.frame.size.width, 40);
//    self.tableView.tableHeaderView =self.searchController.searchBar;
//    [self.tableView scrollRectToVisible:searchBarFrame animated:NO];

    

}


-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    
    [self.locationManager requestWhenInUseAuthorization];
    [self.locationManager startUpdatingLocation];
    
}

-(void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    
    if (status == kCLAuthorizationStatusAuthorizedWhenInUse) {
        self.mapView.showsUserLocation = YES;
    }
    
}

-(void)selectedLocationOnSearchController:(MKMapItem *)mapItem {
    
    NSLog(@"Did select location");
   
    [self.mapView addAnnotation:mapItem.placemark];
    
    self.mapItem = mapItem;
    //indirectly calling MKAnnotationView method
    
    [self.mapView setCenterCoordinate:mapItem.placemark.coordinate];
    
    [self dismissSelf];
    
    //dismiss tableView, create a pin that you can place on the map & zoom to that item. give it a new region for the map view, zoom to region around pin
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    
    MKAnnotationView *annotationView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"AnnotationReuseId"];
    
    annotationView.image = [UIImage imageNamed:@"Joel's"];
    
    UIButton *detailsButton = [UIButton buttonWithType:UIButtonTypeInfoDark];
    
    [detailsButton addTarget:self action:@selector(openDetailButton) forControlEvents:UIControlEventTouchUpInside];
    
    annotationView.rightCalloutAccessoryView = detailsButton;
    
    annotationView.canShowCallout = YES;
    
    return annotationView;
    
}


-(void)openDetailButton {
    
    PoiDetailController *detailsView = [self.storyboard instantiateViewControllerWithIdentifier:@"PoiDetailController"];
    
    [detailsView willMoveToParentViewController:self];
    
    [self declarePointOfInterest];

    [self.mapView addSubview:detailsView.view];

    [detailsView didMoveToParentViewController:self];
    detailsView.view.frame = CGRectMake(50, 100, 100, 75);
    detailsView.specialMapItem = self.mapItem;
    
///create point of interest and pass it to POIDetailController --- NSFetched results controller in saved locations table view controller 
}

-(void)declarePointOfInterest {
    TWCoreDataStack *coreDataStack = [TWCoreDataStack defaultStack];
    BlocSpot *pointOfInterest = [NSEntityDescription insertNewObjectForEntityForName:@"BlocSpot" inManagedObjectContext:coreDataStack.managedObjectContext];
    
    pointOfInterest.date = [[NSDate date] timeIntervalSince1970];
    [coreDataStack saveContext];
    
}




- (void)dismissSelf {
    [self.searchController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark search controller delegate

- (void)willPresentSearchController:(UISearchController *)searchController {
    
}
#pragma mark tableView data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.resultsArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"resultsCell" forIndexPath:indexPath];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"resultsCell"];
    }
    cell.textLabel.text = self.resultsArray [indexPath.row];
    
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
    
}
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleNone;
    
}

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(nonnull MKUserLocation *)userLocation {
    
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(userLocation.coordinate, 800, 800);
    [self.mapView setRegion:[self.mapView regionThatFits:region] animated:YES];
}

- (instancetype)initWithSearchResultsController:(nullable UIViewController *)searchResultsController {
    
    return nil;
    
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    
    [searchBar setShowsCancelButton:YES];
    self.mapView.scrollEnabled = NO;
    self.tableView.allowsSelection = YES;

}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    
    //[searchBar becomeFirstResponder];
    NSLog(@"%@",searchBar.text);
    NSString *searchString = self.searchController.searchBar.text;
    
    [self.mapSearch searchWithTerm:searchString];
    
    
}

- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar
{
    return YES;
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar{
    self.isSearching = NO;
    [self.searchController.searchBar resignFirstResponder];
    
    
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    
    [self.searchController.searchBar resignFirstResponder];
}
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    
    if (searchController.searchBar.text.length < 1) return;
    
    
    NSString *searchString = self.searchController.searchBar.text;
    
    [self.mapSearch searchWithTerm:searchString];
    [self.tableView reloadData];
}

-(void)foundResults:(NSArray *)resultsArray {
    
    self.resultsArray = resultsArray;
    NSLog(@"found results, %@", resultsArray);
   
    
}

- (void)errorFound:(NSString *)failureReason {
    
    NSLog(@"Could not perform search");
    
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
