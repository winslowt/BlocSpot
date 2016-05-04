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

@interface PoiDetailController ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (nonatomic, strong) UITapGestureRecognizer *writeNote;
@property (weak, nonatomic) IBOutlet UITextView *mapItemNote;
@property (nonatomic, strong) UISwipeGestureRecognizer *outsideBox;

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
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(setWriteNote:)];
    tapGesture.numberOfTapsRequired = 2;
    
    UISwipeGestureRecognizer *swipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(setOutsideBox:)];
    [self.view addGestureRecognizer:swipeGesture];
    swipeGesture.numberOfTouchesRequired = 1;
    swipeGesture.direction = UISwipeGestureRecognizerDirectionRight;
    
    
    // Do any additional setup after loading the view.
}

-(void)setOutsideBox:(UISwipeGestureRecognizer *)outsideBox {

    [self dismissViewControllerAnimated:YES completion:nil];
}


-(void)setWriteNote:(UITapGestureRecognizer *)writeNote {
    
    self.mapItemNote.editable = YES;
    self.mapItemNote.userInteractionEnabled = YES;
    
    if (self.mapItemNote.editable == NO) {
        
        self.mapItemNote.dataDetectorTypes = UIDataDetectorTypeAll;
        
        
    }
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
