//
//  NetworkManager.h
//  JETest
//
//  Created by Trevor Doodes on 12/04/2016.
//  Copyright © 2016 Trevor Doodes. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetworkManager : NSObject

typedef void (^apiSuccess) (NSArray *restaurantsArray);
typedef void (^apiFailure) (NSString *message, NSUInteger statusCode);


- (void)retrieveRestaurantsForOutcode:(NSString *)outcode
                              success:(apiSuccess)success
                            failure:(apiFailure)failure;

@end
