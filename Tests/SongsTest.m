//
//  SongsTest.m
//  wrapper
//
//  Created by Jose Alonso García on 1/12/15.
//  Copyright © 2015 humm. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "SongsAPI.h"

@interface SongsTest : XCTestCase

@property (nonatomic) HummAPI *humm;

@end

@implementation SongsTest

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

-(void) testFeatured {
    
    NSString *username = @"deleteme";
    NSString *password = @"deleteme";
    
    XCTestExpectation *expectation = [self expectationWithDescription:@"Testing Async Method Works!"];
    
    [self.humm loginWithUsername:username password:password onLoginSuccess:^{
        SongsAPI *songsAPI = [self.humm songs];
        
        [self.humm updateUserToken];
        
        NSInteger limit = 5;
        NSInteger offset = 0;
        NSString *genre = nil;
        
        [songsAPI featuredWithGenre:genre limit:limit offset:offset
                  success:^(NSArray<Song *> *response) {
                      
                      XCTAssertTrue(limit == response.count);
                      
                      [expectation fulfill];
                  }
                    error:^(NSError *error) {
                        NSLog(@"error = %@", [error localizedDescription]);
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

-(void) testPopular {
    
    NSString *username = @"deleteme";
    NSString *password = @"deleteme";
    
    XCTestExpectation *expectation = [self expectationWithDescription:@"Testing Async Method Works!"];
    
    [self.humm loginWithUsername:username password:password onLoginSuccess:^{
        SongsAPI *songsAPI = [self.humm songs];
        
        [self.humm updateUserToken];
        
        NSInteger limit = 5;
        NSInteger offset = 0;
        NSString *genre = nil;
        
        [songsAPI popularWithGenre:genre limit:limit offset:offset
                               success:^(NSArray<Song *> *response) {
                                   
                                   XCTAssertTrue(limit == response.count);
                                   
                                   [expectation fulfill];
                               }
                                 error:^(NSError *error) {
                                     NSLog(@"error = %@", [error localizedDescription]);
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


-(void) testRecent {
    
    NSString *username = @"deleteme";
    NSString *password = @"deleteme";
    
    XCTestExpectation *expectation = [self expectationWithDescription:@"Testing Async Method Works!"];
    
    [self.humm loginWithUsername:username password:password onLoginSuccess:^{
        SongsAPI *songsAPI = [self.humm songs];
        
        [self.humm updateUserToken];
        
        NSInteger limit = 5;
        NSInteger offset = 0;
        NSString *genre = nil;
        
        [songsAPI recentWithGenre:genre limit:limit offset:offset
                              success:^(NSArray<Song *> *response) {
                                  
                                  XCTAssertTrue(limit == response.count);
                                  
                                  [expectation fulfill];
                              }
                                error:^(NSError *error) {
                                    NSLog(@"error = %@", [error localizedDescription]);
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

-(void) testAppearsin {
    
    NSString *username = @"deleteme";
    NSString *password = @"deleteme";
    
    XCTestExpectation *expectation = [self expectationWithDescription:@"Testing Async Method Works!"];
    
    [self.humm loginWithUsername:username password:password onLoginSuccess:^{
        SongsAPI *songsAPI = [self.humm songs];
        
        [self.humm updateUserToken];
        
        NSInteger limit = 1;
        NSString *idSong = @"557ecbf86a64fc1b8bed533f"; //song2
        
        [songsAPI appearsIn:idSong limit:limit
                          success:^(NSArray<Playlist *> *response) {
                              
                              XCTAssertTrue(limit == response.count);
                              
                              [expectation fulfill];
                          }
                            error:^(NSError *error) {
                                NSLog(@"error = %@", [error localizedDescription]);
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

-(void) testGet {
    
    NSString *username = @"deleteme";
    NSString *password = @"deleteme";
    
    XCTestExpectation *expectation = [self expectationWithDescription:@"Testing Async Method Works!"];
    
    [self.humm loginWithUsername:username password:password onLoginSuccess:^{
        SongsAPI *songsAPI = [self.humm songs];
        
        [self.humm updateUserToken];
        
        NSString *idSong = @"557ecbf86a64fc1b8bed533f"; //song2
        
        [songsAPI get:idSong 
                    success:^(Song *response) {
                        
                        XCTAssertEqualObjects(@"Song 2", response.title);
                        
                        [expectation fulfill];
                    }
                      error:^(NSError *error) {
                          NSLog(@"error = %@", [error localizedDescription]);
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

-(void) testGetSimilar {
    
    NSString *username = @"deleteme";
    NSString *password = @"deleteme";
    
    XCTestExpectation *expectation = [self expectationWithDescription:@"Testing Async Method Works!"];
    
    [self.humm loginWithUsername:username password:password onLoginSuccess:^{
        SongsAPI *songsAPI = [self.humm songs];
        
        [self.humm updateUserToken];
        
        NSString *idSong = @"557ecbf86a64fc1b8bed533f"; //song2
        NSInteger limit = 5;
        NSInteger offset = 0;
        [songsAPI getSimilar:idSong limit:limit offset:offset
              success:^(NSArray<Song *> *response) {
                  
                  XCTAssertTrue(limit == response.count);
                  
                  [expectation fulfill];
              }
                error:^(NSError *error) {
                    NSLog(@"error = %@", [error localizedDescription]);
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
