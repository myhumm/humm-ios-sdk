//
//  OthersTests.m
//  wrapper
//
//  Created by Jose Alonso García on 2/12/15.
//  Copyright © 2015 humm. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "HummAPI.h"

@interface OthersTests : XCTestCase

@property (nonatomic) HummAPI *humm;

@end

@implementation OthersTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    self.humm = (HummAPI *)[HummAPI sharedManager];

}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

//- (void)testExample {
//    // This is an example of a functional test case.
//    // Use XCTAssert and related functions to verify your tests produce the correct results.
//}
//
//- (void)testPerformanceExample {
//    // This is an example of a performance test case.
//    [self measureBlock:^{
//        // Put the code you want to measure the time of here.
//    }];
//}

-(void) testRadio {
    
    NSString *username = @"deleteme100";
    NSString *password = @"deleteme100";
    
    XCTestExpectation *expectation = [self expectationWithDescription:@"Testing Async Method Works!"];
    
    [self.humm loginWithUsername:username password:password onLoginSuccess:^{
        
        NSInteger limit = 5;
        BOOL discovery = NO;
        BOOL own = NO;
        NSArray *genres = nil;
        NSArray *moods = nil;
        
        [self.humm radio:genres moods:moods discovery:discovery limit:limit own:own success:^(NSArray<Song *> *response) {
            XCTAssertTrue(limit == response.count);
            [expectation fulfill];

        } error:^(NSError *err) {
            XCTAssertFalse(YES);
        }];
        
    } onLoginError:^(NSError *error) {
        XCTAssertFalse(YES);
    }];
    
    [self waitForExpectationsWithTimeout:15.0 handler:^(NSError * _Nullable error) {
        if(error)
        {
            XCTFail(@"Expectation Failed with error: %@", error);
        }
        
    }];
    
}

-(void) testWeeklyPlaylist {
    
    NSString *username = @"deleteme100";
    NSString *password = @"deleteme100";
    
    XCTestExpectation *expectation = [self expectationWithDescription:@"Testing Async Method Works!"];
    
    [self.humm loginWithUsername:username password:password onLoginSuccess:^{
        
        [self.humm weeklyPlaylist:^(NSArray<Song *> *response) {
            [expectation fulfill];
        } error:^(NSError *err) {
            XCTAssertFalse(YES);
        }];
        
    } onLoginError:^(NSError *error) {
        XCTAssertFalse(YES);
    }];
    
    [self waitForExpectationsWithTimeout:15.0 handler:^(NSError * _Nullable error) {
        if(error)
        {
            XCTFail(@"Expectation Failed with error: %@", error);
        }
        
    }];
    
}


@end
