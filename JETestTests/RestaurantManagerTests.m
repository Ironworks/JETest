//
//  RestaurantManagerTests.m
//  JETest
//
//  Created by Trevor Doodes on 12/04/2016.
//  Copyright © 2016 Trevor Doodes. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>
#import "RestaurantManager.h"
#import "Restaurant.h"
#import "NetworkManager.h"

@interface RestaurantManagerTests : XCTestCase

@property (nonatomic, strong) RestaurantManager *mgr;

@end

@implementation RestaurantManagerTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    NetworkManager *networkManager = [[NetworkManager alloc] init];
    self.mgr = [[RestaurantManager alloc] initWithNetworkManager:networkManager];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    self.mgr = nil;
    [super tearDown];
}

- (NSArray *)stubResults {
    
    NSMutableArray *results = [NSMutableArray arrayWithCapacity:20];
    
    Restaurant *restaurant = [[Restaurant alloc] initWithName:@"Papadam"
                                                       rating:@"5.14"
                                                    foodTypes:@[@"Indian"]];
    
    for (int i = 0; i < 20; i++) {
        [results addObject:restaurant];
    }
    
    return results;
}

- (void)testCanCreateARestaurantManagerObject {
    
    XCTAssertNotNil(self.mgr, @"Should be able to create an applications manager");
}

- (void)testCanSetNetworkManager {
    
    XCTAssertNotNil(self.mgr.networkManager, @"Should be able to set newtwork manager");
}

- (void)testCanGetListOfRestaurants {
    
    id sut = [OCMockObject mockForClass:[RestaurantManager class]];
    NSString *outcode = @"se19";
    
    [[[sut stub] andDo:^(NSInvocation *invocation) {
        //Our stubbed results
        NSArray *restaurants = [self stubResults];
        successBlock blockToExecute = nil;
        
        [invocation getArgument:&blockToExecute atIndex:3];
        
        blockToExecute(restaurants);
    }] getRestaurantsForOutCode:[OCMArg any] successBlock:[OCMArg any] failureBlock:[OCMArg any]];
    
    [sut getRestaurantsForOutCode:outcode
        successBlock:^(NSArray *restaurantsArray) {
            XCTAssertTrue(restaurantsArray.count == 20, @"Array should have data");
        } failureBlock:^(NSError *error) {
           XCTAssertTrue(NO, @"Should not have an error");
    }];
        
}


- (void)testErrorIfOutCodeIsNil {
    
    XCTestExpectation *expectation = [self expectationWithDescription:@"Error should be raised"];
    
    [self.mgr getRestaurantsForOutCode:nil
                          successBlock:^(NSArray *restaurantsArray) {
                              XCTAssertTrue(NO, @"Should not have any restaurants");
                          } failureBlock:^(NSError *error) {
                              XCTAssertNotNil(error, @"Should have NSError object returned");
                              XCTAssertTrue(error.code == ErrorCodeInvalidOutcode, @"Should return invalid outcode error");
                              XCTAssertTrue([error.localizedDescription isEqualToString:@"Invalid Outcode"], @"Should return invalid outcode error");
                              [expectation fulfill];
                          }];
    
    [self waitForExpectationsWithTimeout:5.0 handler:^(NSError * _Nullable error) {
        if (error) {
            NSLog(@"Error occured: %@", error.localizedDescription);
        }
    }];


}

- (void)testNoRestaurantsReturned {
    
    id sut = [OCMockObject mockForClass:[RestaurantManager class]];
    NSString *outcode = @"se19";
    
    [[[sut stub] andDo:^(NSInvocation *invocation) {

        failureBlock blockToExecute = nil;
        
        [invocation getArgument:&blockToExecute atIndex:4];
        
        NSError *error = [NSError errorWithDomain:@"com.justeat" code:ErrorCodeNoRestaurantsFound userInfo:nil];
        
        blockToExecute(error);
    }] getRestaurantsForOutCode:[OCMArg any] successBlock:[OCMArg any] failureBlock:[OCMArg any]];
    
    [sut getRestaurantsForOutCode:outcode
        successBlock:^(NSArray *restaurantsArray) {
            XCTAssertTrue(NO, @"Should not have an error");
        } failureBlock:^(NSError *error) {
            XCTAssertNotNil(error, @"Should pass back error if no records found");
            
    }];

}

@end
