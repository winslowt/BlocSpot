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

-(UIColor *)color {
    
    return [UIColor colorFromString:self.colorString];
}

-(void)setColor:(UIColor *)color {
    
    self.colorString = [color toString];
}

@end
