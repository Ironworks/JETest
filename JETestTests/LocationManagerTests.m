//
//  LocationManagerTests.m
//  JETest
//
//  Created by Trevor Doodes on 13/04/2016.
//  Copyright © 2016 Trevor Doodes. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>
#import "LocationServicesManager.h"

@interface LocationManagerTests : XCTestCase
@property (nonatomic, strong) LocationServicesManager *locationServicesManager;
@end

@implementation LocationManagerTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    self.locationServicesManager = [[LocationServicesManager alloc] init];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    self.locationServicesManager = nil;
    [super tearDown];
}

- (void)testCanCreateLocationManager {
    
    XCTAssertNotNil(self.locationServicesManager, @"Should be able to create location services manager");
}

- (void)testCanGetOutcode {
    
    id sut = [OCMockObject mockForClass:[LocationServicesManager class]];
    [[[sut stub] andDo:^(NSInvocation *invocation) {
        NSString *outcode = @"se19";
        success blockToExecute = nil;
        
        [invocation getArgument:&blockToExecute atIndex:2];
        
        blockToExecute(outcode);
    }] outCodeForLocationWithSuccess:[OCMArg any]
                             failure:[OCMArg any]];
    
    [sut outCodeForLocationWithSuccess:^(NSString *outCode) {
        XCTAssertEqualObjects(@"se19", outCode, @"Should get correct outcode returned");
    } failure:^(NSError *error) {
        //Should not have an error
        XCTAssertTrue(NO, @"Should not have an error");
    }];
    
}

- (void)testErrorReturnedIfOutcodeNotFound {
    
    id sut = [OCMockObject mockForClass:[LocationServicesManager class]];
    [[[sut stub] andDo:^(NSInvocation *invocation) {

        failure blockToExecute = nil;
        
        [invocation getArgument:&blockToExecute atIndex:3];
        
        NSError *error = [NSError errorWithDomain:@"com.justeat" code:1003 userInfo:@{NSLocalizedDescriptionKey: @"Outcode not found"}];
        blockToExecute(error);
    }] outCodeForLocationWithSuccess:[OCMArg any]
     failure:[OCMArg any]];
    
    [sut outCodeForLocationWithSuccess:^(NSString *outCode) {
        XCTAssertTrue(NO, @"Should not have an outcode");
    } failure:^(NSError *error) {
        XCTAssertNotNil(error, @"Should return an error object");
        XCTAssertTrue(error.code == 1003, @"Should return error code 1003");
        XCTAssertEqualObjects(error.localizedDescription, @"Outcode not found", @"Should return correct error message");

    }];

    
}





@end
