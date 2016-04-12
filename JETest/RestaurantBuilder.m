//
//  RestaurantBuilder.m
//  JETest
//
//  Created by Trevor Doodes on 12/04/2016.
//  Copyright © 2016 Trevor Doodes. All rights reserved.
//

#import "RestaurantBuilder.h"
#import "Restaurant.h"
@implementation RestaurantBuilder

- (NSArray *)cuisineTypesFromArray:(NSArray *)cuisineList
{
    NSMutableArray *results = [NSMutableArray array];
    
    for (NSDictionary *cuisine in cuisineList) {
        NSString *cuisineString = cuisine[@"Name"];
        [results addObject:cuisineString];
    }
    
    return [NSArray arrayWithArray:results];
}

- (Restaurant *)restaurantFromDictionary:(NSDictionary *)dictionary
{
    NSParameterAssert(dictionary != nil);

    
    NSString *name = dictionary[@"Name"];
    NSArray *cuisines = [self cuisineTypesFromArray:dictionary[@"CuisineTypes"]];
    NSString *rating = [NSString stringWithFormat:@"%@",dictionary[@"RatingStars"]];
    
    Restaurant *newRestaurant = [[Restaurant alloc] initWithName:name
                                                          rating:rating
                                                       foodTypes:cuisines];
    return newRestaurant;
}

@end
