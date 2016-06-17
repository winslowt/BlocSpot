//
//  AppDelegate.m
//  BlocSpot
//
//  Created by Tony  Winslow on 3/16/16.
//  Copyright © 2016 Bloc. All rights reserved.
//

#import "AppDelegate.h"
#import "TWCoreDataStack.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [self.locationManager requestWhenInUseAuthorization];
    [application registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert categories:nil]];
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.pausesLocationUpdatesAutomatically = YES;
    [self setupAppearance];
    
    [self.window makeKeyAndVisible];
    [TWCoreDataStack defaultStack];
    
    return YES;
}

- (void)startStandardUpdates {
    // Create the location manager if this object does not
    // already have one.
//    if (nil == self.locationManager)
//        self.locationManager = [[CLLocationManager alloc] init];
//    
//    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyKilometer;
    self.locationManager.distanceFilter = 500; // meters
    
    [self.locationManager startUpdatingLocation];
}
-(void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"Receive notification" object:notification];
    
}

- (void)setupAppearance {
    UINavigationBar *navigationBarAppearance = [UINavigationBar appearance];
    navigationBarAppearance.barTintColor = [UIColor colorWithRed:84.0/155.0 green:45.0/120.0 blue:180.0/67.0 alpha:1.0f];
    navigationBarAppearance.tintColor = [UIColor whiteColor];
    navigationBarAppearance.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor]};
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
