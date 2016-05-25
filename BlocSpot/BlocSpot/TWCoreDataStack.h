//
//  TWCoreDataStack.h
//  BlocSpot
//
//  Created by Tony  Winslow on 4/17/16.
//  Copyright © 2016 Bloc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface TWCoreDataStack : NSObject

+ (instancetype)defaultStack;



@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;


- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;
//-(void)moveItemAtIndex:(NSUInteger)fromIndex toIndex:(NSUInteger)toIndex; 
@end
