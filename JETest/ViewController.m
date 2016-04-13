//
//  ViewController.m
//  JETest
//
//  Created by Trevor Doodes on 06/04/2016.
//  Copyright © 2016 Trevor Doodes. All rights reserved.
//

#import "ViewController.h"
#import "LocationServicesManager.h"
#import "RestaurantManager.h"
#import "RestaurantListTableViewController.h"
#import "NetworkManager.h"
#import "MBProgressHUD.h"


@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *searchTextField;
@property (nonatomic, strong) LocationServicesManager *locMgr;
@property (nonatomic, strong) RestaurantManager *restMgr;
@property (nonatomic, strong) NSArray *restaurantArray;

- (IBAction)getLocationButtonPressed:(id)sender;
- (IBAction)searchButtonPressed:(id)sender;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //Add border to text field
    CALayer *layer = [self.searchTextField layer];
    layer.borderWidth = 1;
    layer.borderColor = [[UIColor blackColor] CGColor];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)getLocationButtonPressed:(id)sender {
    
    [self.locMgr outCodeForLocationWithSuccess:^(NSString *outCode) {
        self.searchTextField.text = outCode;
    } failure:^(NSError *error) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error"
                                                                       message:@"Postcode not found please enter a post code manaually and press search"
                                                                preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* ok = [UIAlertAction
                             actionWithTitle:@"OK"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 [alert dismissViewControllerAnimated:YES completion:nil];
                                 
                             }];
        
        [alert addAction:ok];
        
        [self presentViewController:alert animated:YES completion:nil];
    }];
}

- (IBAction)searchButtonPressed:(id)sender {
    
    if (self.searchTextField.text.length > 2) {
        
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        __weak typeof (self)weakSelf = self;
        [self.restMgr getRestaurantsForOutCode:self.searchTextField.text
            successBlock:^(NSArray *restaurantsArray) {
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                self.restaurantArray = restaurantsArray;
                [weakSelf performSegueWithIdentifier:@"listSegue" sender:nil];
            } failureBlock:^(NSError *error) {
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error"
                                                                               message:@"Postcode not found please a different one"
                                                                        preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction* ok = [UIAlertAction
                                     actionWithTitle:@"OK"
                                     style:UIAlertActionStyleDefault
                                     handler:^(UIAlertAction * action)
                                     {
                                         [alert dismissViewControllerAnimated:YES completion:nil];
                                         
                                     }];
                
                [alert addAction:ok];
                
                [self presentViewController:alert animated:YES completion:nil];
            }];
        
        
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"listSegue"]) {
        RestaurantListTableViewController *vc = (RestaurantListTableViewController *)[segue destinationViewController];
        vc.restaurantArray = self.restaurantArray;
    }
}

#pragma mark - Accessor methods
- (LocationServicesManager *)locMgr
{
    if (_locMgr == nil) {
        _locMgr = [[LocationServicesManager alloc] init];
    }
    
    return _locMgr;
}

- (RestaurantManager *)restMgr
{
    if (_restMgr == nil) {
        NetworkManager *mgr = [[NetworkManager alloc] init];
        _restMgr = [[RestaurantManager alloc] initWithNetworkManager:mgr];
    }
    
    return _restMgr;
}
@end
