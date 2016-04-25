//
//  PoiDetailController.m
//  BlocSpot
//
//  Created by Tony  Winslow on 4/14/16.
//  Copyright © 2016 Bloc. All rights reserved.
//

#import "PoiDetailController.h"

@interface PoiDetailController () <UIPopoverPresentationControllerDelegate>

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation PoiDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titleLabel.text = self.specialMapItem.name;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
