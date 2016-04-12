//
//  Restaurant.m
//  JETest
//
//  Created by Trevor Doodes on 06/04/2016.
//  Copyright © 2016 Trevor Doodes. All rights reserved.
//

#import "Restaurant.h"

@interface Restaurant ()

@end

@implementation Restaurant

- (instancetype)initWithName:(NSString *)name rating:(NSString *)rating foodTypes:(NSArray *)foodTypes
{
    
    if (self = [super init]) {
        _name = name;
        _rating = rating;
        _foodTypes = foodTypes;
    }
    
    return self;
}


@end
