//
//  RestaurantManager.m
//  JETest
//
//  Created by Trevor Doodes on 12/04/2016.
//  Copyright © 2016 Trevor Doodes. All rights reserved.
//

#import "RestaurantManager.h"
#import "NetworkManager.h"
#import "RestaurantBuilder.h"
#import "Restaurant.h"
#import "Constants.h"

@interface RestaurantManager ()

@property (nonatomic, strong) NSMutableArray *restaurantsArray;


@end


@implementation RestaurantManager

-(instancetype) initWithNetworkManager:(NetworkManager *)networkManager
{
    
    if (self = [super init]) {
        _networkManager = networkManager;
    }
    
    return self;
}

- (NSArray *)restuarantArrayFromResturantsArray:(NSArray *)restaurantArray {
    
    RestaurantBuilder *restaurantBuilder = [[RestaurantBuilder alloc] init];
    
    for (NSDictionary *restaurant in restaurantArray) {
        Restaurant *newRestaurant = [restaurantBuilder restaurantFromDictionary:restaurant];
        [self.applicationsArray addObject:newRestaurant];
    }
    
    return [self.applicationsArray copy];
}

- (NSError *)errorWithErrorCode:(ErrorCode) errorCode localizedDescription:(NSString *)localizedDescription
{
    //Outcode is required
    NSDictionary *userInfo = @{NSLocalizedDescriptionKey : localizedDescription};
    
    return [NSError errorWithDomain:kErrorDomain code:errorCode userInfo:userInfo];

}
- (void)getRestaurantsForOutCode:(NSString *)outcode
                    successBlock:(successBlock)successBlock
                    failureBlock:(failureBlock)failureBlock
{
    if (outcode == nil ||
        outcode.length == 0)
    {
        NSError *error = [self errorWithErrorCode:ErrorCodeInvalidOutcode localizedDescription:@"Invalid Outcode"];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (failureBlock) {
                failureBlock(error);
            }
        });        
        return;
    }
    
    __weak typeof (self)weakSelf = self;
    
    [self.networkManager retrieveRestaurantsForOutcode:outcode
        success:^(NSArray *restaurantsArray) {
            RestaurantManager *blockSelf = weakSelf;
            
            dispatch_async(dispatch_get_main_queue(), ^{
                if (successBlock) {
                    NSArray *restaurantArray = [blockSelf restuarantArrayFromResturantsArray:restaurantsArray];
                    successBlock(restaurantArray);
                }
            });

        } failure:^(NSString *message, NSUInteger statusCode) {
            
            NSError *error = [self errorWithErrorCode:ErrorCodeNoRestaurantsFound localizedDescription:@"No restaurants found"];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                if (failureBlock) {
                    failureBlock(error);
                }
            });

            
        }];
    

}


#pragma mark - Accessor Methods
- (NSMutableArray *)applicationsArray {
    
    if (_restaurantsArray == nil) {
        _restaurantsArray = [NSMutableArray array];
    }
    
    return _restaurantsArray;
}

@end

