//
//  NetworkManager.m
//  JETest
//
//  Created by Trevor Doodes on 12/04/2016.
//  Copyright © 2016 Trevor Doodes. All rights reserved.
//

#import "NetworkManager.h"
#import "AFNetworking.h"

@implementation NetworkManager

NSString * const kURL = @"https://public.je-apis.com/restaurants";

- (void)retrieveRestaurantsForOutcode:(NSString *)outcode
                              success:(apiSuccess)success
                              failure:(apiFailure)failure
{
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSDictionary *parameters = @{@"q":outcode};
    

    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] requestWithMethod:@"Get" URLString:kURL parameters:parameters error:nil];
    [request addValue:@"uk" forHTTPHeaderField:@"Accept-Tenant"];
    [request addValue:@"en-GB" forHTTPHeaderField:@"Accept-Language"];
    [request addValue:@"Basic VGVjaFRlc3RBUEk6dXNlcjI=" forHTTPHeaderField:@"Authorization"];
    [request addValue:@"public.je-apis.com" forHTTPHeaderField:@"Host"];

   
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            NSHTTPURLResponse *httpResp = (NSHTTPURLResponse *)response;
            
            dispatch_async(dispatch_get_main_queue(), ^{
                if (failure) {
                    failure(error.localizedDescription, httpResp.statusCode);
                }
            });
            
        } else {
            
            NSArray *restaurants = responseObject[@"Restaurants"];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                if (success) {
                    success(restaurants);
                }
            });
            
        }
    }];
    [dataTask resume];

}

@end
