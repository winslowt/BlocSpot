//
//  MapSearch.m
//  BlocSpot
//
//  Created by Tony  Winslow on 3/21/16.
//  Copyright © 2016 Bloc. All rights reserved.
//

#import "MapSearch.h"

@interface MapSearch ()

@property (nonatomic, strong) MKLocalSearch *currentSearch;

@end

@implementation MapSearch

- (void)searchWithTerm:(NSString *)searchString {
    
    if (!searchString || searchString.length <1) {
        [self.delegate errorFound:@"invalid argument"];
        return;
    }
    
    if (self.currentSearch != nil) {
        // if there is a search ongoing
        
        [self.currentSearch cancel];
        
    }
    
    MKLocalSearchRequest *searchRequest= [[MKLocalSearchRequest alloc] init];
    searchRequest.naturalLanguageQuery = searchString;
    
    MKLocalSearch *search = [[MKLocalSearch alloc] initWithRequest:searchRequest];
    self.currentSearch = search;
    
    [self.currentSearch startWithCompletionHandler:^(MKLocalSearchResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error) {
            [self.delegate errorFound:error.description];
            return;
        }
        
        [self.delegate foundResults:response.mapItems];
    }];
    
}





@end
