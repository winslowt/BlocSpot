//
//  POICategory.m
//  BlocSpot
//
//  Created by Tony  Winslow on 4/28/16.
//  Copyright © 2016 Bloc. All rights reserved.
//

#import "POICategory.h"
#import "BlocSpot.h"
#import "TWCoreDataStack.h"
#import "UIColor+String.h"

@implementation POICategory

@synthesize logo;

-(UIColor *)color {
    
    return [UIColor colorFromString:self.colorString];
}

-(void)setColor:(UIColor *)color {
    
    self.colorString = [color toString];
}

- (void)setLogo:(UIImage *)aLogo {
    if (aLogo == nil) {
        self.logoData = nil;
    }
    else {
        self.logoData = UIImagePNGRepresentation(aLogo);
    }
}

- (UIImage *)logo
{
    if (self.logoData == nil) {
        return nil;
    }
    else {
        return [UIImage imageWithData:self.logoData];
    }
}


@end
