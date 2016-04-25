//
//  NavigationController.m
//  BlocSpot
//
//  Created by Tony  Winslow on 4/16/16.
//  Copyright © 2016 Bloc. All rights reserved.
//

#import "NavigationController.h"

@interface NavigationController () <UINavigationControllerDelegate>

@end

@implementation NavigationController

-(UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.navigationController.delegate = self;
    
}

@end
