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

@interface SavedLocationsTableViewController () <NSFetchedResultsControllerDelegate> 

@property (nonatomic, strong) NSArray *placesOfInterest;
@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSFetchRequest *placeFetchRequest;


@end

@implementation SavedLocationsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.fetchedResultsController performFetch:nil];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

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

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    BlocSpot *dataItem = (BlocSpot *)self.fetchedResultsController.fetchedObjects[indexPath.row];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:BlocSpotSelected object:dataItem];
    
//    MapViewController *mapVC = (MapViewController *)self.presentingViewController.presentingViewController;
//    mapVC.itemToDisplay = dataItem;
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    BlocSpot *entry = [self.fetchedResultsController objectAtIndexPath:indexPath];
    TWCoreDataStack *coreDataStack = [TWCoreDataStack defaultStack];
    [[coreDataStack managedObjectContext] deleteObject:entry];
    [coreDataStack saveContext];
    [tableView reloadData];
    
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
    //cast-this is a BlocSpot object
    cell.locationNameLabel.text = dataItem.name;
    return cell;
}

- (IBAction)backToMap:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
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
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
