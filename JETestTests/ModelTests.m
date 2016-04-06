//
//  ModelTests.m
//  JETest
//
//  Created by Trevor Doodes on 06/04/2016.
//  Copyright © 2016 Trevor Doodes. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Restaurant.h"

@interface ModelTests : XCTestCase

@property (nonatomic, strong) Restaurant *testRestaurant;

@end

@implementation ModelTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    self.testRestaurant = [[Restaurant alloc] initWithName:@"Test Restaurant"
                                                    rating:@"1"
                                                 foodTypes:@[@"Indian", @"Italian"]];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    self.testRestaurant = nil;
    [super tearDown];
}

- (void)testCanCreateRestaurant {
    
    XCTAssertNotNil(self.testRestaurant, @"Should be able to create a retaurant instance");
}

- (void)testCanSetTheRestaurantName {
    
    XCTAssertEqual(self.testRestaurant.name, @"Test Restaurant", @"Should be able to give restaurant a name");
    
}

- (void)testCanSetRestaurantRating {
    
    XCTAssertEqual(self.testRestaurant.rating, @"1", @"Should be able to set rating");
    
}

- (void)testCanAddCuisineTypes {
    
    XCTAssertEqual(self.testRestaurant.foodTypes[0], @"Indian", @"Should be able to add cuisines");
    XCTAssertEqual(self.testRestaurant.foodTypes[1], @"Italian", @"Should be able to add cuisines");
}


@end
