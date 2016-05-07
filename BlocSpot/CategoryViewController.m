//
//  CategoryViewController.m
//  BlocSpot
//
//  Created by Tony  Winslow on 5/7/16.
//  Copyright © 2016 Bloc. All rights reserved.
//

#import "CategoryViewController.h"

@interface CategoryViewController ()
@property (weak, nonatomic) IBOutlet UILabel *selectCategory;
@property (weak, nonatomic) IBOutlet UILabel *restaurants;
@property (weak, nonatomic) IBOutlet UILabel *sweetTreats;
@property (weak, nonatomic) IBOutlet UILabel *sports;
@property (weak, nonatomic) IBOutlet UILabel *entertainment;

@end

@implementation CategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
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
