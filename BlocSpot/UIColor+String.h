//
//  UIColor+String.h
//  BlocSpot
//
//  Created by Tony  Winslow on 5/24/16.
//  Copyright © 2016 Bloc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (String)


-(NSString *)toString;
+(UIColor *)colorFromString:(NSString*)string;
+(UIColor *)randomColor;


@end
