//
//  PoiDetailController.m
//  BlocSpot
//
//  Created by Tony  Winslow on 4/14/16.
//  Copyright © 2016 Bloc. All rights reserved.
//

#import "PoiDetailController.h"
#import "TWCoreDataStack.h"
#import "BlocSpot.h"
#import "POICategory.h"
#import "CategoryViewController.h"
#import "MapViewController.h"


@interface PoiDetailController () <UIGestureRecognizerDelegate>

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UITextView *mapItemNote;
@property (nonatomic, strong) UISwipeGestureRecognizer *swipeOut;
@property (weak, nonatomic) IBOutlet UIButton *categoryName;
@property (nonatomic, strong) NSFetchRequest *fetchRequest;
@property (nonatomic, strong) CategoryViewController *catView;


@end

@implementation PoiDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.layer.cornerRadius = 15;
    //makes rounded edges of view controller
    self.view.clipsToBounds = YES;
    self.view.backgroundColor = [UIColor colorWithWhite:1.4 alpha:0.9];
    //if you have rounded covers, it doesn't draw anything outside
    
    self.titleLabel.text = self.specialMapItem.name;
    
    self.view.userInteractionEnabled = YES;
    


    // Do any additional setup after loading the view.
}
- (IBAction)pickCategory:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    MapViewController *mapVC = (MapViewController *)self.presentingViewController;
    self.catView = [self.storyboard instantiateViewControllerWithIdentifier:@"CategoryViewController"];
    self.catView.view.frame = CGRectMake(50, 100, 400, 400);

    [self.catView willMoveToParentViewController:mapVC];
//    [self.mapVC addSubview:self.catView.view];
    [self.catView didMoveToParentViewController:mapVC];
    
    
    
//    
//    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"Select Category" message:nil preferredStyle:UIAlertControllerStyleAlert];
////    
//    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"POICategory"];
//    fetchRequest.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES]];
//    
//    TWCoreDataStack *defaultStack = [TWCoreDataStack defaultStack];
//    
//    NSMutableArray *results = [[defaultStack.managedObjectContext executeFetchRequest:fetchRequest error:nil]mutableCopy];
//    
//    if (results.count == 0) {
//        
//        NSArray *categoryArray = [NSArray arrayWithObjects:@"Eats", @"Entertainment", @"Sweets", @"Parks", nil];
//        
//        TWCoreDataStack *coreDataStack = [TWCoreDataStack defaultStack];
//        
//        for (int i = 0; i < categoryArray.count; i++) {
//            NSString *categoryName = categoryArray[i];
//            //element at index i
//            POICategory *category = [NSEntityDescription insertNewObjectForEntityForName:@"POICategory" inManagedObjectContext:coreDataStack.managedObjectContext];
//            category.name = categoryName;
//            [results addObject:category];
//        }
//    }
//    
//    for (POICategory *category in results) {
//        
//        UIAlertAction *actionOne = [UIAlertAction actionWithTitle:category.name style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//            //assign category to BlocSpot object and save BlocSpot object
//           
//        }];
//        [actionSheet addAction:actionOne];
//    }
//    [self presentViewController:self.catView animated:YES completion:nil];
}


-(void)dealloc {
    
}


-(void)viewWillAppear:(BOOL)animated {
    //UI related so in viewwill appear
    
    self.swipeOut = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(setOutsideBox:)];
    self.swipeOut.numberOfTouchesRequired = 1;

    self.swipeOut.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:self.swipeOut];
    self.swipeOut.delegate = self;
    
}

-(void)setOutsideBox:(UISwipeGestureRecognizer *)outsideBox {

    [self.view removeFromSuperview];
}

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    
    return YES;
}

-(BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    
    return YES;
}


-(void)insertNoteEntry {
    TWCoreDataStack *coreDataStack = [TWCoreDataStack defaultStack];
    
    BlocSpot *mapNote= [NSEntityDescription insertNewObjectForEntityForName:@"BlocSpot" inManagedObjectContext:coreDataStack.managedObjectContext];
    mapNote.note = self.mapItemNote.text;
    
    
}
- (void) dismissSelf {
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backItUp:(id)sender {
    [self dismissSelf];
}

    


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
