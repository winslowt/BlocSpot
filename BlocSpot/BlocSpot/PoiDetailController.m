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
@property (weak, nonatomic) IBOutlet UITextView *textView;
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
    
    self.titleLabel.text = self.placeOfInterest.name;
    self.titleLabel.textColor = [UIColor blackColor];
    
    self.view.userInteractionEnabled = YES;
    
}
- (IBAction)pickCategory:(id)sender {
    
    self.catView = [self.storyboard instantiateViewControllerWithIdentifier:@"CategoryViewController"];
    self.catView.placeOfInterest = self.placeOfInterest;
    self.catView.view.frame = self.view.bounds;
    [self.view addSubview:self.catView.view];

    [self.catView didMoveToParentViewController:self];
   
}

 
-(void)dealloc {
    
}
-(void)viewWillAppear:(BOOL)animated {
    //UI related so in viewwill appear
    [super viewWillAppear:animated];
    
    self.swipeOut = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(setOutsideBox:)];
    self.swipeOut.numberOfTouchesRequired = 1;

    self.swipeOut.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:self.swipeOut];
    self.swipeOut.delegate = self;
    self.textView.text = self.placeOfInterest.note;
}

-(void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    self.placeOfInterest.note = self.textView.text;
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
