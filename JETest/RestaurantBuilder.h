//
//  RestaurantBuilder.h
//  JETest
//
//  Created by Trevor Doodes on 12/04/2016.
//  Copyright © 2016 Trevor Doodes. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Restaurant;
@interface RestaurantBuilder : NSObject

- (Restaurant *)restaurantFromDictionary:(NSDictionary *)dictionary;
@end
