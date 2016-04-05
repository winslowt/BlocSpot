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

@interface ListOfSearchResultsController () <UITableViewDataSource, UITableViewDelegate, MapSearchProtocol>

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
