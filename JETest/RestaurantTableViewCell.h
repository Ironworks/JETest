//
//  RestaurantTableViewCell.h
//  JETest
//
//  Created by Trevor Doodes on 13/04/2016.
//  Copyright © 2016 Trevor Doodes. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RestaurantTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *ratingsLabel;
@property (weak, nonatomic) IBOutlet UILabel *cuisineTypesLabel;

@end
