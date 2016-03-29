//
//  LocationTableViewController.m
//  BlocSpot
//
//  Created by Tony  Winslow on 3/26/16.
//  Copyright © 2016 Bloc. All rights reserved.
//

#import "LocationTableViewController.h"
#import "MapViewController.h"
#import "MapSearch.h"


@interface LocationTableViewController () <UISearchControllerDelegate, UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate, UISearchResultsUpdating, MapSearchProtocol>

@property (nonatomic, strong) NSArray *resultsArray;
@property (nonatomic, strong) MapSearch *mapSearch;
@property (nonatomic, strong) UISearchController *searchResultsController;

@end

@implementation LocationTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.locationManager = [[CLLocationManager alloc] init];
    [self.locationManager requestWhenInUseAuthorization];
    [self.locationManager startUpdatingLocation];
    self.searchResultsController = [[UISearchController alloc] initWithSearchResultsController:nil];
    self.searchResultsController.dimsBackgroundDuringPresentation = NO;
    self.searchResultsController.searchResultsUpdater = self;
    self.mapSearch = [[MapSearch alloc] init];
    
    self.mapSearch.delegate = self;
    [self.searchResultsController.searchBar sizeToFit];
}


- (void)foundResults:(NSArray *)resultsArray {
    
    self.resultsArray = resultsArray;
    [self.tableView reloadData];
}

- (void)errorFound:(NSString *)failureReason {
    
    NSLog(@"Could not perform search");
    
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    
    [searchBar setShowsCancelButton:YES];
    self.tableView.allowsSelection = NO;
    self.tableView.scrollEnabled = NO;
    
}

#pragma mark Search Bar 

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    
    [searchBar becomeFirstResponder];
    //
    //    searchBar.text = searchBar.text;
    
    NSLog(@"%@",searchBar.text);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return self.resultsArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.resultsArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"resultsCell" forIndexPath:indexPath];
    
    return cell;
}

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    
    NSString *searchString = self.searchBar.text;
    [self.mapSearch searchWithTerm:searchString];
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here, for example:
    // Create the next view controller.
    <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:<#@"Nib name"#> bundle:nil];
    
    // Pass the selected object to the new view controller.
    
    // Push the view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
