//
//  NetworkManagerTests.m
//  JETest
//
//  Created by Trevor Doodes on 12/04/2016.
//  Copyright © 2016 Trevor Doodes. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "OHHTTPStubs.h"
#import "OHPathHelpers.h"
#import "NetworkManager.h"

@interface NetworkManagerTests : XCTestCase

@property (nonatomic, strong) NetworkManager *sut;
@end

@implementation NetworkManagerTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    self.sut = [[NetworkManager alloc] init];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    self.sut = nil;
    [OHHTTPStubs removeAllStubs];
    [super tearDown];
}

- (void)testCanCreateNetworkManager {
 
    XCTAssertTrue(self.sut, @"Should be able to create a network manager");
}


- (void)testCanRetrieveRestaurantsForOutcode {
    
    [OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest *request) {
        return [request.URL.host isEqualToString:@"public.je-apis.com"];
    } withStubResponse:^OHHTTPStubsResponse*(NSURLRequest *request) {
        // Stub it with our "applications.json" stub file
        return [OHHTTPStubsResponse responseWithFileAtPath:OHPathForFile(@"Restaurants.json",self.class)
                                                statusCode:200 headers:@{@"Content-Type":@"application/json"}];
    }];
    
    
    
    XCTestExpectation *expectation = [self expectationWithDescription:@"Should download applications"];
    
    NSString *outcode = @"se19";
    
    [self.sut retrieveRestaurantsForOutcode:outcode
        success:^(NSArray *restaurantsArray) {
            XCTAssertTrue(restaurantsArray, @"Should contain an array of entries");
            [expectation fulfill];

      } failure:^(NSString *message, NSUInteger statusCode) {
          //Should not see this
          XCTAssertTrue(NO, @"Should not have an error");

    }];
    
    [self waitForExpectationsWithTimeout:10.0 handler:^(NSError * _Nullable error) {
        if (error) {
            NSLog(@"Error occured: %@", error.localizedDescription);
        }
    }];

}

- (void)testnetworkErrorRetrieveingApplications {
    
    [OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest *request) {
        return [request.URL.host isEqualToString:@"public.je-apis.com"];
    } withStubResponse:^OHHTTPStubsResponse*(NSURLRequest *request) {
        // Stub it with our "applications.json" stub file
        return [OHHTTPStubsResponse responseWithFileAtPath:OHPathForFile(@"Restaurants.json",self.class)
                                                statusCode:404 headers:@{@"Content-Type":@"application/json"}];
    }];
    
    
    
    XCTestExpectation *expectation = [self expectationWithDescription:@"Should download applications"];
    
    NSString *outcode = @"se19";
    
    [self.sut retrieveRestaurantsForOutcode:outcode
        success:^(NSArray *restaurantsArray) {
            XCTAssertTrue(restaurantsArray, @"Should contain an array of entries");
            [expectation fulfill];
                                        
    } failure:^(NSString *message, NSUInteger statusCode) {
            XCTAssertTrue(statusCode == (NSUInteger)404, @"Status code should be 404");
            XCTAssertEqualObjects(message, @"Request failed: not found (404)", @"Should receive 404 error");
            [expectation fulfill];
                                        
    }];
    
    [self waitForExpectationsWithTimeout:10.0 handler:^(NSError * _Nullable error) {
        if (error) {
            NSLog(@"Error occured: %@", error.localizedDescription);
        }
    }];

    
    
    
    
    
    
}


@end
