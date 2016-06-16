//
//  SavedLocationsTableViewController.m
//  BlocSpot
//
//  Created by Tony  Winslow on 4/16/16.
//  Copyright © 2016 Bloc. All rights reserved.
//

#import "SavedLocationsTableViewController.h"
#import "SavedLocationsTableViewCell.h"
#import "TWCoreDataStack.h"
#import "BlocSpot.h"
#import "MapViewController.h"
#import "POICategory.h"
#import "BlocSpot+CoreDataProperties.h"
@interface SavedLocationsTableViewController () <NSFetchedResultsControllerDelegate, ShareLocationDelegate>

@property (nonatomic, strong) NSArray *placesOfInterest;
@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSFetchRequest *placeFetchRequest;
@property (nonatomic) BOOL isFiltering;
@property (nonatomic, strong) NSArray *filteredSpots;

@end

@implementation SavedLocationsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSFetchedResultsController *)fetchedResultsController {
    if (_fetchedResultsController !=nil) {
        return _fetchedResultsController;
    }
    TWCoreDataStack *coreDataStack = [TWCoreDataStack defaultStack];
    NSFetchRequest *fetchRequest = [self placeFetchRequest];
    
    _fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:coreDataStack.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
    
    _fetchedResultsController.delegate = self;
    
    return _fetchedResultsController;
}


-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.isFiltering = NO;
    [self.fetchedResultsController performFetch:nil];
}

-(void)didLongPressCell:(SavedLocationsTableViewCell *)cell {
    
    UIActivityViewController *shareLocation = [[UIActivityViewController alloc]initWithActivityItems:@[cell.blocLocation.name, cell.blocLocation.category.name, cell.blocLocation.note] applicationActivities:nil];
    [self presentViewController:shareLocation animated:YES completion:nil];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (self.isFiltering) {
        return self.filteredSpots.count;
    }
    if (self.placeFetchRequest == nil) {
        id <NSFetchedResultsSectionInfo> sectionInfo = [self.fetchedResultsController sections][section];
        
        return [sectionInfo numberOfObjects];
        
    } else {
        return self.fetchedResultsController.fetchedObjects.count;
    }
    
}
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
    
}
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    BlocSpot *dataItem = (BlocSpot *)self.fetchedResultsController.fetchedObjects[indexPath.row];
    //we are telling the above item that we want it to be a blocSpot item
    
    [[NSNotificationCenter defaultCenter] postNotificationName:BlocSpotSelected object:dataItem];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    BlocSpot *entry = [self.fetchedResultsController objectAtIndexPath:indexPath];
    TWCoreDataStack *coreDataStack = [TWCoreDataStack defaultStack];
    NSError *error = nil;
    [[coreDataStack managedObjectContext] deleteObject:entry];
    [self.fetchedResultsController performFetch:&error];
    if (error) {
        NSLog(@"This broke");
    }
    [tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
    [coreDataStack saveContext];
}

- (NSFetchRequest *)placeFetchRequest {
    
    if (_placeFetchRequest != nil)
    {
        return _placeFetchRequest;
    }
    _placeFetchRequest = [[NSFetchRequest alloc] init];
    TWCoreDataStack *stackedCore = [TWCoreDataStack defaultStack];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"BlocSpot" inManagedObjectContext:stackedCore.managedObjectContext];
    [_placeFetchRequest setEntity:entity];
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"pointOfInterest" ascending:YES];
    NSArray *sortDescriptors = [NSArray arrayWithObjects:sortDescriptor, nil];
    [_placeFetchRequest setSortDescriptors:sortDescriptors];
    return _placeFetchRequest;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SavedLocationsTableViewCell *cell =(SavedLocationsTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"SavedLocationsTableViewCell" forIndexPath:indexPath];
    BlocSpot *dataItem = (BlocSpot *)self.fetchedResultsController.fetchedObjects[indexPath.row];
    POICategory *imageCategory = dataItem.category;
    tableView.rowHeight = 87;
    cell.locationNameLabel.text = dataItem.name;
    cell.delegate = self;
    cell.blocLocation = dataItem;
    cell.sameTextView.text = dataItem.note;
    cell.imageView.image = imageCategory.logo;
    return cell;
    //this is where you will set your BlocSpot content (images, notes)
    
}

- (IBAction)backToMap:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)filterCategories:(id)sender {
    
    NSError *error = nil;
    NSFetchRequest *categoryFetch = [NSFetchRequest fetchRequestWithEntityName:@"POICategory"];
    NSArray *fetchedCategories = [[TWCoreDataStack defaultStack].managedObjectContext executeFetchRequest:categoryFetch error:&error];
    UIAlertController *categoryPicker = [UIAlertController alertControllerWithTitle:@"Pick Category" message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    for (POICategory *category in fetchedCategories) {
        UIAlertAction *catCall = [UIAlertAction actionWithTitle:category.name style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            [self userPickedCategory:category];
            [categoryPicker dismissViewControllerAnimated:YES completion:nil];
        }];
        
        [categoryPicker addAction:catCall];
    }
    [self presentViewController:categoryPicker animated:YES completion:nil];
}

- (void)userPickedCategory:(POICategory *)category
{
    NSPredicate *predicate = [NSPredicate predicateWithBlock:^BOOL(BlocSpot *evaluatedObject, NSDictionary<NSString *,id> * bindings) {
        return evaluatedObject.category == category;  //this gets called on each object in the array
    }];
    self.filteredSpots = [self.fetchedResultsController.fetchedObjects filteredArrayUsingPredicate:predicate];
    self.isFiltering = YES;
    [self.tableView reloadData];
}

//// pick a button that will filter by category & update query


@end
