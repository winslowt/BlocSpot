//
//  MapViewController.m
//  BlocSpot
//
//  Created by Tony  Winslow on 3/24/16.
//  Copyright © 2016 Bloc. All rights reserved.
//

#import "MapViewController.h"
#import "MapSearch.h"

@class MKMapView;
@class locationServicesEnabled;


@interface MapViewController () <UISearchControllerDelegate, UISearchBarDelegate,UISearchResultsUpdating, MapSearchProtocol>


@property (nonatomic,strong) NSArray *resultsArray;
@property (nonatomic, strong) MapSearch *mapSearch;
@property (nonatomic, strong) UISearchController *searchController;
@property(nonatomic, weak) id< UISearchResultsUpdating > searchResultsUpdater;
@property(nonatomic, getter=isEditing) BOOL isSearching;


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
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    self.searchController.searchResultsUpdater = self;
    self.searchController.dimsBackgroundDuringPresentation = NO;
    self.searchController.searchBar.delegate = self;
    
    
    // Do any additional setup after loading the view.
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

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(nonnull MKUserLocation *)userLocation {
    
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(userLocation.coordinate, 800, 800);
    [self.mapView setRegion:[self.mapView regionThatFits:region] animated:YES];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    
    [searchBar becomeFirstResponder];
    NSString *searchString = self.searchController.searchBar.text;
    
    [self.mapSearch searchWithTerm:searchString];

    
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    
    [searchBar setShowsCancelButton:YES];
    self.mapView.scrollEnabled = NO;
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar{
    self.isSearching = NO;
    
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    
    [self.searchBar resignFirstResponder];
}
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    
    NSString *searchString = self.searchController.searchBar.text;

    [self.mapSearch searchWithTerm:searchString];
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
