//
//  RestaurantListTableViewController.m
//  JETest
//
//  Created by Trevor Doodes on 13/04/2016.
//  Copyright © 2016 Trevor Doodes. All rights reserved.
//

#import "RestaurantListTableViewController.h"
#import "RestaurantTableViewCell.h"
#import "Restaurant.h"

@interface RestaurantListTableViewController ()

@end

@implementation RestaurantListTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Restaurants";
    
 }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.restaurantArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RestaurantTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"restaurantCell" forIndexPath:indexPath];
    
    // Configure the cell...
    Restaurant *restaurant = self.restaurantArray[indexPath.row];
    cell.nameLabel.text = restaurant.name;
    cell.ratingsLabel.text = restaurant.rating;
    cell.cuisineTypesLabel.text = [restaurant.foodTypes componentsJoinedByString:@", "];
    
    return cell;
}



@end
