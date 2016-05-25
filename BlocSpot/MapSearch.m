//
//  MapSearch.m
//  BlocSpot
//
//  Created by Tony  Winslow on 3/21/16.
//  Copyright © 2016 Bloc. All rights reserved.
//

#import "MapSearch.h"
#import "ListOfSearchResultsController.h"

@interface MapSearch () <UISearchResultsUpdating>

@property (nonatomic, strong) MKLocalSearch *currentSearch;

@end

@implementation MapSearch

- (void)searchWithTerm:(NSString *)searchString {
    
    if (!searchString || searchString.length <1) {
        [self.delegate errorFound:@"invalid argument"];
        return;
    }
    
    if (self.currentSearch != nil) {
        // if there is a search ongoing --try to search for another before search returns, cancel search in progress
        
        [self.currentSearch cancel];
        
    }
    
    MKLocalSearchRequest *searchRequest= [[MKLocalSearchRequest alloc] init];
    searchRequest.naturalLanguageQuery = searchString;
    
    MKLocalSearch *search = [[MKLocalSearch alloc] initWithRequest:searchRequest];
    self.currentSearch = search;
    
    [self.currentSearch startWithCompletionHandler:^(MKLocalSearchResponse *response, NSError *error) {
        
        if (error) {
            [self.delegate errorFound:error.description];
            return;
        }
        
        [self.delegate foundResults:response.mapItems];
    }];
    
}

-(void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    
}




@end
