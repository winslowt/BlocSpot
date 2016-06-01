//
//  ListOfSearchResultsController.m
//  BlocSpot
//
//  Created by Tony  Winslow on 4/4/16.
//  Copyright © 2016 Bloc. All rights reserved.
//

#import "ListOfSearchResultsController.h"
#import "SearchResultsTableViewCell.h"
#import "MapSearch.h"

@interface ListOfSearchResultsController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong)NSArray *searchResults;

@end

@implementation ListOfSearchResultsController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.searchResults = [NSMutableArray array];
    //same as alloc init method
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.searchResults.count;
}

- (void)displayResults:(NSArray *)resultsArray {
    
    self.searchResults = resultsArray;
    [self.tableView reloadData];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SearchResultsTableViewCell *cell =(SearchResultsTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"SearchResultsTableViewCell" forIndexPath:indexPath];
    
    MKMapItem *item = self.searchResults[indexPath.row];
    cell.label.text = item.name;
    
    return cell;
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return NO;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(selectedLocationOnSearchController:)]) {
        
       [self.delegate selectedLocationOnSearchController:self.searchResults[indexPath.row]];
    }
    
    
}

-(void)foundResults:(NSArray *)resultsArray {
    
    [self displayResults: resultsArray];
}

-(void)errorFound:(NSString *)failureReason {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Whoops" message:failureReason  preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *dismiss = [UIAlertAction actionWithTitle:@"Word" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [alert dismissViewControllerAnimated:YES completion:nil];
    
    }];
    
    
    [alert addAction:dismiss];
    [self presentViewController:alert animated:YES completion:nil];
}



@end
