//
//  RestaurantBuilderTests.m
//  JETest
//
//  Created by Trevor Doodes on 12/04/2016.
//  Copyright © 2016 Trevor Doodes. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "RestaurantBuilder.h"
#import "Restaurant.h"

@interface RestaurantBuilderTests : XCTestCase

@property (nonatomic, strong) RestaurantBuilder *restaurantBuilder;
@end

@implementation RestaurantBuilderTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    self.restaurantBuilder = [[RestaurantBuilder alloc] init];
    
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    self.restaurantBuilder = nil;
    [super tearDown];
}

- (void)testCanCreateARestaurantBuilder {
    XCTAssertNotNil(self.restaurantBuilder, @"Should be able to create a restaurant builder.");
}

- (void)testThatnilIsNotAnAcceptableParameter {
    XCTAssertThrows([self.restaurantBuilder restaurantFromDictionary:nil], @"Should throw error if dictionary is nil");
}

- (void)testCanBuildApplicationFromDictionary {
    
    NSDictionary *italian = @{@"Id" : @27, @"Name" : @"Italian", @"SeoName" : [NSNull null]};
    NSDictionary *pizza = @{@"Id" : @82, @"Name" : @"Pizza", @"SeoName" : [NSNull null]};
    NSDictionary *restaurantDictionary = @{@"Name" : @"Godfather Pizza Wood Oven", @"CuisineTypes" : @[italian, pizza], @"RatingStars" : @4.19};
    
    
    Restaurant *restaurant = [self.restaurantBuilder restaurantFromDictionary:restaurantDictionary];
    
    XCTAssertEqualObjects(restaurant.name, @"Godfather Pizza Wood Oven", @"CuisineTypes");
    XCTAssertTrue(restaurant.foodTypes.count == 2, @"Should have 2 cuisine types");
    XCTAssertTrue([restaurant.foodTypes[0] isEqualToString:@"Italian"], @"Should have Italian as first cuisine type");
    XCTAssertTrue([restaurant.foodTypes[1] isEqualToString:@"Pizza"], @"Should have Pizza as second cuisine type");
    XCTAssertTrue([restaurant.rating isEqualToString:@"4.19"], @"Should have rating of 4.19");
    
}

@end
