//
//  CategoryViewController.m
//  BlocSpot
//
//  Created by Tony  Winslow on 5/7/16.
//  Copyright © 2016 Bloc. All rights reserved.
//

#import "CategoryViewController.h"
#import "CategoryTableViewCell.h"
#import "TWCoreDataStack.h"
#import "POICategory.h"
#import "BlocSpot.h"
#import "UIColor+String.h"


@interface CategoryViewController () <NSFetchedResultsControllerDelegate>

@property (nonatomic, strong) NSFetchedResultsController *frcAlert;
@property (strong, nonatomic) NSFetchRequest *fetchItBaby;


@end

@implementation CategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}

-(void)viewWillAppear:(BOOL)animated {
    
    [[self fetchedResultsController] performFetch:nil];
    
    if (self.frcAlert.fetchedObjects.count == 0) {
        [self declareCategory:@"Restaurants" color:[UIColor blueColor]];
        [self declareCategory:@"Sporting and Entertainment" color:[UIColor redColor]];
        [self declareCategory:@"Taverns" color:[UIColor greenColor]];
        [self declareCategory:@"Shopping" color:[UIColor purpleColor]];
    }
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSFetchedResultsController *)fetchedResultsController {
    
    if (_frcAlert !=nil) {
        return _frcAlert;
    }
    TWCoreDataStack *coreDataStack = [TWCoreDataStack defaultStack];
    NSFetchRequest *fetchRequest = [self fetchItBaby];
    _frcAlert = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:coreDataStack.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
    
    _frcAlert.delegate = self;
    return _frcAlert;
}

-(void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    
    [self.tableView reloadData];
}

- (NSFetchRequest *)fetchItBaby {
    
    if (_fetchItBaby != nil)
    {
        return _fetchItBaby;
    }
    
    _fetchItBaby = [[NSFetchRequest alloc] init];
    TWCoreDataStack *stackedCore = [TWCoreDataStack defaultStack];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"POICategory" inManagedObjectContext:stackedCore.managedObjectContext];
    [_fetchItBaby setEntity:entity];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
    NSArray *sortDescriptors = [NSArray arrayWithObjects:sortDescriptor, nil];
    [_fetchItBaby setSortDescriptors:sortDescriptors];
    
    return _fetchItBaby;
    
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.frcAlert.fetchedObjects.count + 1;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *categoryCell = [tableView dequeueReusableCellWithIdentifier:@"CategoryTableViewCellID" forIndexPath:indexPath];
    categoryCell.textLabel.textColor = [UIColor whiteColor];
    categoryCell.textLabel.textAlignment = NSTextAlignmentCenter;
  
    if (indexPath.row == self.frcAlert.fetchedObjects.count) {

        categoryCell.textLabel.text = @"Add New Category";
        categoryCell.backgroundColor = [UIColor orangeColor];
    }
    else {
        POICategory *category = self.frcAlert.fetchedObjects[indexPath.row];
        categoryCell.textLabel.text = category.name;
        categoryCell.backgroundColor = category.color;
    }
    
    return categoryCell;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleNone;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == self.frcAlert.fetchedObjects.count) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Select Category" message:@"Word" preferredStyle:UIAlertControllerStyleAlert];
        [alert addTextFieldWithConfigurationHandler:nil];
        [alert addAction:[UIAlertAction actionWithTitle:@"Okay" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            UITextField *textField = alert.textFields.firstObject;
            [self declareCategory:textField.text color:[UIColor randomColor]];
        }]];
        [self presentViewController:alert animated:YES completion:nil];
    } else {
        self.placeOfInterest.category = self.frcAlert.fetchedObjects[indexPath.row];
    }
}

-(void)declareCategory:(NSString *)name color:(UIColor*)color {
    TWCoreDataStack *catStack = [TWCoreDataStack defaultStack];
    POICategory *category = [NSEntityDescription insertNewObjectForEntityForName:@"POICategory" inManagedObjectContext:catStack.managedObjectContext];
    category.name = name;
    category.color = color;
    [catStack.managedObjectContext save:nil];
    
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    POICategory *entry = [self.frcAlert objectAtIndexPath:indexPath];
    TWCoreDataStack *coreDataStack = [TWCoreDataStack defaultStack];
    
    [[coreDataStack managedObjectContext] deleteObject:entry];
    
    [coreDataStack saveContext];
    
    
}

@end
