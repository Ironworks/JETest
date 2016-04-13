//
//  LocationManager.m
//  JETest
//
//  Created by Trevor Doodes on 12/04/2016.
//  Copyright © 2016 Trevor Doodes. All rights reserved.
//

#import "LocationServicesManager.h"
#import <CoreLocation/CoreLocation.h>
#import "Constants.h"

@interface LocationServicesManager () <CLLocationManagerDelegate>



@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) success successBlock;
@property (nonatomic, strong) failure failureBlock;
@end

@implementation LocationServicesManager

- (void)outCodeForLocationWithSuccess:(success)success
                              failure:(failure)failure
{
    self.successBlock = success;
    self.failureBlock = failure;
    
    [self lookforLocation];
}

-(void)lookforLocation
{
    self.locationManager = [CLLocationManager new];
    self.locationManager.delegate = self;
    self.locationManager.distanceFilter = kCLDistanceFilterNone;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [self.locationManager requestWhenInUseAuthorization];
    }
    [self.locationManager startUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *currentLocation = [locations objectAtIndex:0];
    [self.locationManager stopUpdatingLocation];
    
    CLGeocoder *geocoder = [[CLGeocoder alloc] init] ;
    [geocoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray *placemarks, NSError *error)
     {
         if (!(error))
         {
             dispatch_async(dispatch_get_main_queue(), ^{
                 if (self.successBlock) {
                     CLPlacemark *placemark = [placemarks objectAtIndex:0];
                     NSString *postCode = [[NSString alloc]initWithString:placemark.postalCode];
                     NSArray *postCodeComponents = [postCode componentsSeparatedByString:@" "];
                     self.successBlock(postCodeComponents[0]);
                 }

             });
             
         }
         else
         {
             if (self.failureBlock) {
                 dispatch_async(dispatch_get_main_queue(), ^{
                     NSDictionary *userInfo = @{NSLocalizedDescriptionKey : @"Outcode not found"};
                     NSError *error = [NSError errorWithDomain:kCLErrorDomain code:1003 userInfo:userInfo];
                     self.failureBlock(error);

                 });
             }
             
         }
     }];
}
@end
