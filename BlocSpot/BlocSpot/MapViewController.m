//
//  MapViewController.m
//  BlocSpot
//
//  Created by Tony  Winslow on 3/24/16.
//  Copyright © 2016 Bloc. All rights reserved.
//

#import "MapViewController.h"
#import "MapSearch.h"
#import "ListOfSearchResultsController.h"
#import "PoiDetailController.h"
#import "TWCoreDataStack.h"
#import "BlocSpot.h"
#import "PointOfInterest.h"
#import "BlocSpot+CoreDataProperties.h"


@interface MapViewController () <UISearchControllerDelegate, UITableViewDataSource, UISearchBarDelegate, UISearchResultsUpdating, MapSearchProtocol, ClickLocation, UIViewControllerTransitioningDelegate, UINavigationControllerDelegate>


@property (nonatomic,strong) NSArray *resultsArray;
@property (nonatomic, strong) MapSearch *mapSearch;
@property(nonatomic, weak) id< UISearchResultsUpdating > searchResultsUpdater;
@property (nonatomic, strong) UISearchController *searchController;
@property(nonatomic, getter=isEditing) BOOL isSearching;
@property (nonatomic, strong) UITableView *tableView;
@property (strong, nonatomic) NSMutableArray* allTableData;
@property (nonatomic, strong) MKMapItem *mapItem;
@property (nonatomic, strong) UITapGestureRecognizer *outsideBox;
@property (nonatomic,strong) PoiDetailController *detailsView;


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
    //tell the storyboard to instantiate a view controller
    ListOfSearchResultsController *resultsController = (ListOfSearchResultsController*)[storyboard instantiateViewControllerWithIdentifier:@"ListOfSearchResultsController"];
    resultsController.delegate = self;
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:resultsController];
    self.searchController.searchResultsUpdater = self;
    self.searchController.dimsBackgroundDuringPresentation = NO;
    self.searchController.searchBar.delegate = self;
    self.mapSearch.delegate = (ListOfSearchResultsController*)self.searchController.searchResultsController;
    //when the map search does its thing, give results to searchResultsController
    self.definesPresentationContext = YES;
    [self.view addSubview:self.searchController.searchBar];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(blocSpotted:) name:BlocSpotSelected object:nil];
      [[NSNotificationCenter defaultCenter]addObserverForName:@"Receive notification" object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {
          UILocalNotification *localNotification = note.object;
        
          //notification you are posting from the app delegate
          UIAlertController *alert = [UIAlertController alertControllerWithTitle:localNotification.alertTitle message:localNotification.alertBody preferredStyle:UIAlertControllerStyleAlert];
          
          UIAlertAction *dismiss = [UIAlertAction actionWithTitle:@"Okay" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
              [alert dismissViewControllerAnimated:YES completion:nil];
          }];
          
          [alert addAction:dismiss];
          
          [self presentViewController:alert animated:YES completion:nil];
      }];
    
    self.searchController.searchBar.frame = CGRectMake(0, 0, self.view.frame.size.width, 40);
}


-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if (self.itemToDisplay != nil) {
        
        MKPointAnnotation *place = [MKPointAnnotation new];
        place.title = self.itemToDisplay.name;
        CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(self.itemToDisplay.latitude.doubleValue, self.itemToDisplay.longitude.doubleValue);
        [place setCoordinate:coordinate];
        [self.mapView addAnnotation:place];
        
        NSDictionary *dictionary = @{};
        MKPlacemark *placeMark = [[MKPlacemark alloc] initWithCoordinate:coordinate addressDictionary:dictionary];
        
        MKMapItem *item = [[MKMapItem alloc] initWithPlacemark:placeMark];
        item.name = self.itemToDisplay.name;
        self.mapItem = item;
        [self.mapView setCenterCoordinate:place.coordinate];
    }
}

-(void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
    self.itemToDisplay = nil;
}

-(void)blocSpotted:(NSNotification *)notification {
    
    BlocSpot *spot = notification.object;
    self.itemToDisplay = spot;
    
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    
    [self.locationManager requestAlwaysAuthorization];
    [self.locationManager startUpdatingLocation];
    
}

-(void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    
    if (status == kCLAuthorizationStatusAuthorizedAlways) {
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


- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    
}



-(void)openDetailButton {
    
    CLLocationCoordinate2D coordinates = self.mapItem.placemark.coordinate;
    BlocSpot *spot = [BlocSpot existingMarkForCoordinates:coordinates];
    if (spot == nil) {
        spot = [self declarePointOfInterest];
    }
    self.detailsView = [self.storyboard instantiateViewControllerWithIdentifier:@"PoiDetailController"];
    self.detailsView.view.frame = CGRectMake(50, 100, 250, 250);
    self.detailsView.placeOfInterest = spot;
    self.detailsView.specialMapItem = self.mapItem;
    [self.detailsView willMoveToParentViewController:self];
    [self.mapView addSubview:self.detailsView.view];
    
    [self.detailsView didMoveToParentViewController:self];
    
    for (id currentAnnotation in self.mapView.annotations) {
        [self.mapView deselectAnnotation:currentAnnotation animated:YES];
    }
    
}

-(BlocSpot *)declarePointOfInterest {
    TWCoreDataStack *coreDataStack = [TWCoreDataStack defaultStack];
    BlocSpot *pointOfInterest = [NSEntityDescription insertNewObjectForEntityForName:@"BlocSpot" inManagedObjectContext:coreDataStack.managedObjectContext];
    pointOfInterest.name = self.mapItem.name;
    MKPlacemark *placeMark = self.mapItem.placemark;
    pointOfInterest.latitude = @(placeMark.coordinate.latitude);
    //nsnumber numberwithdouble, can only have object properties not primitives, Boxing it with NSNumber
    pointOfInterest.longitude = @(placeMark.coordinate.longitude);
    
    pointOfInterest.date = [NSDate date];
    [coreDataStack saveContext];
    
    UILocalNotification *notification = [[UILocalNotification alloc] init];
    notification.alertBody = @"You are close to your point of interest";
    notification.alertTitle = @"Get Ready";
    notification.region = [[CLCircularRegion alloc] initWithCenter:placeMark.coordinate radius:1600 identifier:pointOfInterest.name];
    
    [[UIApplication sharedApplication]scheduleLocalNotification:notification];
    return pointOfInterest;
}


- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view {
    
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


@end
