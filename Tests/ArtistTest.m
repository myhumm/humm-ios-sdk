//
//  ArtistTest.m
//  wrapper
//
//  Created by Jose Alonso García on 30/11/15.
//  Copyright © 2015 humm. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "HummAPI.h"
#import "ArtistsAPI.h"

@interface ArtistTest : XCTestCase

@property (nonatomic) HummAPI *humm;

@end

@implementation ArtistTest

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

-(void) testGet {
    
    NSString *username = @"aasdaaqw12312312312s";
    NSString *password = @"asd1231231221asda";
    
    XCTestExpectation *expectation = [self expectationWithDescription:@"Testing Async Method Works!"];
    
    [self.humm loginWithUsername:username password:password onLoginSuccess:^{
        ArtistsAPI *artistAPI = [self.humm artists];
        
        NSString *idArtist = @"55116991f9c816a0d639ea75";
        NSInteger limit = 0;
        NSInteger offset = 0;
        
        [artistAPI get:idArtist limit:limit offset:offset success:^(Artist *response) {
            XCTAssertEqualObjects(@"Blur", response.getName);
            XCTAssertEqualObjects(@"#Blur", response.getHashtag);
            XCTAssertTrue(434882 == [response.getPopularity integerValue]);
            XCTAssertTrue(77 == [response.getPlaylists integerValue]);
            XCTAssertEqualObjects(@"UCI3EFb2lvZyBMykNd64JDhg", response.getYoutubeURL);
            
            [expectation fulfill];
        } error:^(NSError *error) {
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

-(void) testAddFollower {
    
    NSString *username = @"deleteme100";
    NSString *password = @"deleteme100";
    
    XCTestExpectation *expectation = [self expectationWithDescription:@"Testing Async Method Works!"];
    
    [self.humm loginWithUsername:username password:password onLoginSuccess:^{
        ArtistsAPI *artistAPI = [self.humm artists];
        
        NSString *idArtist = @"55116991f9c816a0d639ea75";
        
        [artistAPI addFollower:idArtist
                       success:^(Artist *response) {
                           XCTAssertEqualObjects(@"Blur", response.getName);
                           XCTAssertEqualObjects(@"#Blur", response.getHashtag);
                           XCTAssertTrue(434882 == [response.getPopularity integerValue]);
                           XCTAssertTrue(77 == [response.getPlaylists integerValue]);
                           XCTAssertEqualObjects(@"UCI3EFb2lvZyBMykNd64JDhg", response.getYoutubeURL);
                           
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

-(void) testRemoveFollower {
    
    NSString *username = @"deleteme100";
    NSString *password = @"deleteme100";
    
    XCTestExpectation *expectation = [self expectationWithDescription:@"Testing Async Method Works!"];
    
    [self.humm loginWithUsername:username password:password onLoginSuccess:^{
        ArtistsAPI *artistAPI = [self.humm artists];
        
        
        NSString *idArtist = @"55116991f9c816a0d639ea75";
        
        [artistAPI removeFollower:idArtist
                          success:^(Artist *response) {
                              XCTAssertEqualObjects(@"Blur", response.getName);
                              XCTAssertEqualObjects(@"#Blur", response.getHashtag);
                              XCTAssertTrue(434882 == [response.getPopularity integerValue]);
                              XCTAssertTrue(77 == [response.getPlaylists integerValue]);
                              XCTAssertEqualObjects(@"UCI3EFb2lvZyBMykNd64JDhg", response.getYoutubeURL);
                              
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

-(void) testGetPlaylists {
    
    NSString *username = @"deleteme";
    NSString *password = @"deleteme";
    
    XCTestExpectation *expectation = [self expectationWithDescription:@"Testing Async Method Works!"];
    
    [self.humm loginWithUsername:username password:password onLoginSuccess:^{
        ArtistsAPI *artistAPI = [self.humm artists];
        
        
        NSString *idArtist = @"55116991f9c816a0d639ea75";
        
        NSInteger limit = 5;
        NSInteger offset = 0;
        
        [artistAPI getPlaylists:idArtist limit:limit offset:offset
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

-(void) testGetRadio {
    
    NSString *username = @"deleteme";
    NSString *password = @"deleteme";
    
    XCTestExpectation *expectation = [self expectationWithDescription:@"Testing Async Method Works!"];
    
    [self.humm loginWithUsername:username password:password onLoginSuccess:^{
        ArtistsAPI *artistAPI = [self.humm artists];
        
        
        NSString *idArtist = @"55116991f9c816a0d639ea75";
        
        NSInteger limit = 5;
        NSInteger offset = 0;
        
        [artistAPI getRadio:idArtist limit:limit offset:offset
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

-(void) testGetSimilar {
    
    NSString *username = @"deleteme";
    NSString *password = @"deleteme";
    
    XCTestExpectation *expectation = [self expectationWithDescription:@"Testing Async Method Works!"];
    
    [self.humm loginWithUsername:username password:password onLoginSuccess:^{
        ArtistsAPI *artistAPI = [self.humm artists];
        
        
        NSString *idArtist = @"55116991f9c816a0d639ea75";
        
        NSInteger limit = 5;
        NSInteger offset = 0;
        
        [artistAPI getSimilar:idArtist limit:limit offset:offset
                      success:^(NSArray<Artist *> *response) {
                          
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

-(void) testTopSongs {
    
    NSString *username = @"deleteme";
    NSString *password = @"deleteme";
    
    XCTestExpectation *expectation = [self expectationWithDescription:@"Testing Async Method Works!"];
    
    [self.humm loginWithUsername:username password:password onLoginSuccess:^{
        ArtistsAPI *artistAPI = [self.humm artists];
        
        NSString *idArtist = @"55116991f9c816a0d639ea75";
        
        NSInteger limit = 5;
        NSInteger offset = 0;
        
        [artistAPI getTopSongs:idArtist limit:limit offset:offset songType:nil
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

-(void) testGetFeatured {
    
    NSString *username = @"deleteme";
    NSString *password = @"deleteme";
    
    XCTestExpectation *expectation = [self expectationWithDescription:@"Testing Async Method Works!"];
    
    [self.humm loginWithUsername:username password:password onLoginSuccess:^{
        ArtistsAPI *artistAPI = [self.humm artists];
        
        
        NSInteger limit = 5;
        NSInteger offset = 0;
        
        [artistAPI getFeaturedWithLimit:limit offset:offset genre:nil
                                success:^(NSArray<Artist *> *response) {
                                    
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

-(void) testGetPopular {
    
    NSString *username = @"deleteme";
    NSString *password = @"deleteme";
    
    XCTestExpectation *expectation = [self expectationWithDescription:@"Testing Async Method Works!"];
    
    [self.humm loginWithUsername:username password:password onLoginSuccess:^{
        ArtistsAPI *artistAPI = [self.humm artists];
        
        
        NSInteger limit = 5;
        NSInteger offset = 0;
        
        [artistAPI getPopularWithLimit:limit offset:offset
                               success:^(NSArray<Artist *> *response) {
                                   
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

-(void) testGetRecent {
    
    NSString *username = @"deleteme";
    NSString *password = @"deleteme";
    
    XCTestExpectation *expectation = [self expectationWithDescription:@"Testing Async Method Works!"];
    
    [self.humm loginWithUsername:username password:password onLoginSuccess:^{
        ArtistsAPI *artistAPI = [self.humm artists];
        
        
        NSInteger limit = 5;
        NSInteger offset = 0;
        
        [artistAPI getRecent:limit offset:offset
                     success:^(NSArray<Artist *> *response) {
                         
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

-(void) testSearch {
    
    NSString *username = @"deleteme";
    NSString *password = @"deleteme";
    
    XCTestExpectation *expectation = [self expectationWithDescription:@"Testing Async Method Works!"];
    
    [self.humm loginWithUsername:username password:password onLoginSuccess:^{
        ArtistsAPI *artistAPI = [self.humm artists];
        
        NSInteger limit = 5;
        NSInteger offset = 0;
        NSString *keyword = @"Beck";
        
        [artistAPI search:keyword limit:limit offset:offset
                  success:^(NSArray<Artist *> *response) {
                      
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
