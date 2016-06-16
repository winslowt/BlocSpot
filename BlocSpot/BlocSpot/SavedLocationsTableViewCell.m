//
//  SavedLocationsTableViewCell.m
//  BlocSpot
//
//  Created by Tony  Winslow on 4/16/16.
//  Copyright © 2016 Bloc. All rights reserved.
//

#import "SavedLocationsTableViewCell.h"
#import "BlocSpot.h"

@implementation SavedLocationsTableViewCell


- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.longPressGestureRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressFired:)];
    //        self.longPressGestureRecognizer.delegate = self;
    [self.contentView addGestureRecognizer:self.longPressGestureRecognizer];
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
    }
    return self;
}

- (void)longPressFired:(UILongPressGestureRecognizer *)sender {
    
    [self.delegate didLongPressCell:self];
    
}

@end
