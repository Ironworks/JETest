//
//  RestaurantManager.h
//  JETest
//
//  Created by Trevor Doodes on 12/04/2016.
//  Copyright © 2016 Trevor Doodes. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, ErrorCode){
    ErrorCodeInvalidOutcode    = 1001,
    ErrorCodeNoRestaurantsFound,
    ErrorCodeUnknownError
};

@class NetworkManager;
@interface RestaurantManager : NSObject

typedef void (^successBlock) (NSArray *restaurantsArray);
typedef void (^failureBlock) (NSError *error);

@property (nonatomic, strong, readonly) NetworkManager *networkManager;

-(instancetype) initWithNetworkManager:(NetworkManager *)networkManager;

- (void)getRestaurantsForOutCode:(NSString *)outcode
                    successBlock:(successBlock)successBlock
                    failureBlock:(failureBlock)failureBlock;
@end
