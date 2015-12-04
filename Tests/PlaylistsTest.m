//
//  PlaylistsTest.m
//  wrapper
//
//  Created by Jose Alonso García on 1/12/15.
//  Copyright © 2015 humm. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "HummAPI.h"
#import "PlaylistsAPI.h"
#import "UserAPI.h"

@interface PlaylistsTest : XCTestCase

@property (nonatomic) HummAPI *humm;

@end

@implementation PlaylistsTest

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
//

-(void) testCreate {
    
    NSString *username = @"deleteme100";
    NSString *password = @"deleteme100";
    
    XCTestExpectation *expectation = [self expectationWithDescription:@"Testing Async Method Works!"];
    
    [self.humm loginWithUsername:username password:password onLoginSuccess:^{
        PlaylistsAPI *playlistAPI = [self.humm playlists];
                
        NSString *title = @"playlist title";
        NSString *description = @"playlist description";
        BOOL private = NO;
        
        [playlistAPI create:description private:private title:title
                    success:^(Playlist *response) {
                        
                        XCTAssertEqualObjects(@"playlist title", response.title);
                        
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

-(void) testFeatured {
    
    NSString *username = @"deleteme100";
    NSString *password = @"deleteme100";
    
    XCTestExpectation *expectation = [self expectationWithDescription:@"Testing Async Method Works!"];
    
    
    [self.humm loginWithUsername:username password:password onLoginSuccess:^{
        PlaylistsAPI *playlistAPI = [self.humm playlists];
                
        NSInteger limit = 1;
        NSInteger offset = 0;
        [playlistAPI getFeaturedWithLimit:limit offset:offset
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
    
    NSString *username = @"deleteme100";
    NSString *password = @"deleteme100";
    
    XCTestExpectation *expectation = [self expectationWithDescription:@"Testing Async Method Works!"];
    
    [self.humm loginWithUsername:username password:password onLoginSuccess:^{
        PlaylistsAPI *playlistAPI = [self.humm playlists];
        
        
        NSString *idPlaylist = @"5645aed5b4653cdb631d5632";
        
        [playlistAPI get:idPlaylist
                 success:^(Playlist *response) {
                     
                     XCTAssertEqualObjects(@"Bustin' + Dronin'", response.title);
                     
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

-(void) testUpdate {
    
    NSString *username = @"deleteme100";
    NSString *password = @"deleteme100";
    
    XCTestExpectation *expectation = [self expectationWithDescription:@"Testing Async Method Works!"];
    
    [self.humm loginWithUsername:username password:password onLoginSuccess:^{
        PlaylistsAPI *playlistAPI = [self.humm playlists];
        
        
        NSString *idPlaylist = @"565f32f298cd5758490cc24d";
        NSString *title = @"title updated";
        NSString *description = @"description updated";
        BOOL private = NO;
        
        [playlistAPI update:idPlaylist description:description private:private title:title
                    success:^(Playlist *response) {
                        XCTAssertEqualObjects(@"title updated", response.title);
                        [expectation fulfill];
                    } error:^(NSError *error) {
                        //                        NSLog(@"error = %@", [error localizedDescription]);
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

-(void) testOrder {
    
    NSString *username = @"deleteme100";
    NSString *password = @"deleteme100";
    
    XCTestExpectation *expectation = [self expectationWithDescription:@"Testing Async Method Works!"];
    
    [self.humm loginWithUsername:username password:password onLoginSuccess:^{
        PlaylistsAPI *playlistAPI = [self.humm playlists];
        
        
        NSString *idPlaylist = @"5645aed5b4653cdb631d5632";
        
        NSMutableArray *songsOrdered = [[NSMutableArray alloc]init];
        
        NSDictionary *song1 = [[NSDictionary alloc]initWithObjectsAndKeys:@"54d2be65ae8c5003198baa38",@"sid", nil];
        [songsOrdered addObject:song1];
        
        NSDictionary *song2 = [[NSDictionary alloc]initWithObjectsAndKeys:@"54d2be65ae8c5003198baa3a",@"sid", nil];
        [songsOrdered addObject:song2];
        
        NSDictionary *song3 = [[NSDictionary alloc]initWithObjectsAndKeys:@"54d2be65ae8c5003198baa37",@"sid", nil];
        [songsOrdered addObject:song3];
        
        NSDictionary *song4 = [[NSDictionary alloc]initWithObjectsAndKeys:@"54d2be65ae8c5003198baa39",@"sid", nil];
        [songsOrdered addObject:song4];
        
        [playlistAPI order:idPlaylist songsOrdered:[songsOrdered copy]
                   success:^(Playlist *response) {
                       XCTAssertEqualObjects(@"Bustin' + Dronin'", response.title);
                       [expectation fulfill];
                   } error:^(NSError *error) {
                       //                        NSLog(@"error = %@", [error localizedDescription]);
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

-(void) testGetSongs {
    
    NSString *username = @"deleteme100";
    NSString *password = @"deleteme100";
    
    XCTestExpectation *expectation = [self expectationWithDescription:@"Testing Async Method Works!"];
    
    [self.humm loginWithUsername:username password:password onLoginSuccess:^{
        PlaylistsAPI *playlistAPI = [self.humm playlists];
        
        
        NSString *idPlaylist = @"5645aed5b4653cdb631d5632";
        NSInteger limit = 1;
        NSInteger offset = 0;
        [playlistAPI getSongs:idPlaylist limit:limit offset:offset
                      success:^(NSArray<Song *> *response) {
                          XCTAssertTrue(limit == response.count);
                          [expectation fulfill];
                      } error:^(NSError *error) {
                          //                        NSLog(@"error = %@", [error localizedDescription]);
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

-(void) testAddSong {
    
    NSString *username = @"deleteme100";
    NSString *password = @"deleteme100";
    
    XCTestExpectation *expectation = [self expectationWithDescription:@"Testing Async Method Works!"];
    
    [self.humm loginWithUsername:username password:password onLoginSuccess:^{
        PlaylistsAPI *playlistAPI = [self.humm playlists];
        
        
        NSString *idPlaylist = @"565f32f298cd5758490cc24d";
        NSInteger position = 1;
        NSString *idSong = @"56403fd834017507dba11880";
        [playlistAPI addSong:idPlaylist position:position idSong:idSong
                     success:^(Playlist *response) {
                         XCTAssertEqualObjects(@"Bustin' + Dronin'", response.title);
                         [expectation fulfill];
                     } error:^(NSError *error) {
                         //                        NSLog(@"error = %@", [error localizedDescription]);
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


-(void) testRemoveSong {
    
    NSString *username = @"deleteme100";
    NSString *password = @"deleteme100";
    
    XCTestExpectation *expectation = [self expectationWithDescription:@"Testing Async Method Works!"];
    
    [self.humm loginWithUsername:username password:password onLoginSuccess:^{
        PlaylistsAPI *playlistAPI = [self.humm playlists];
        
        
        NSString *idPlaylist = @"565f32f298cd5758490cc24d";
        
        NSString *idSong = @"56403fd834017507dba11880";
        [playlistAPI removeSong:idPlaylist idSong:idSong
                        success:^(Playlist *response) {
                            XCTAssertEqualObjects(@"Bustin' + Dronin'", response.title);
                            [expectation fulfill];
                        } error:^(NSError *error) {
                            //                        NSLog(@"error = %@", [error localizedDescription]);
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

-(void) testAddSubscriber {
    
    NSString *username = @"deleteme100";
    NSString *password = @"deleteme100";
    
    XCTestExpectation *expectation = [self expectationWithDescription:@"Testing Async Method Works!"];
    
    [self.humm loginWithUsername:username password:password onLoginSuccess:^{
        PlaylistsAPI *playlistAPI = [self.humm playlists];
        
        
        NSString *idPlaylist = @"5645aed5b4653cdb631d5632";
        
        [playlistAPI addSubscriber:idPlaylist
                           success:^(Playlist *response) {
                               XCTAssertEqualObjects(@"Bustin' + Dronin'", response.title);
                               [expectation fulfill];
                           } error:^(NSError *error) {
                               //                        NSLog(@"error = %@", [error localizedDescription]);
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

-(void) testRemoveSubscriber {
    
    NSString *username = @"deleteme100";
    NSString *password = @"deleteme100";
    
    XCTestExpectation *expectation = [self expectationWithDescription:@"Testing Async Method Works!"];
    
    [self.humm loginWithUsername:username password:password onLoginSuccess:^{
        PlaylistsAPI *playlistAPI = [self.humm playlists];
        
        
        NSString *idPlaylist = @"5645aed5b4653cdb631d5632";
        
        [playlistAPI removeSubscriber:idPlaylist
                              success:^(Playlist *response) {
                                  XCTAssertEqualObjects(@"Bustin' + Dronin'", response.title);
                                  [expectation fulfill];
                              } error:^(NSError *error) {
                                  //                        NSLog(@"error = %@", [error localizedDescription]);
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
    
    NSString *username = @"deleteme100";
    NSString *password = @"deleteme100";
    
    XCTestExpectation *expectation = [self expectationWithDescription:@"Testing Async Method Works!"];
    
    [self.humm loginWithUsername:username password:password onLoginSuccess:^{
        PlaylistsAPI *playlistAPI = [self.humm playlists];
        
        NSInteger limit = 1;
        NSInteger offset = 0;
        NSString *selection = nil;
        NSString *uid = nil;
        
        [playlistAPI getPopularWithLimit:limit offset:offset selection:selection idUser:uid
                                 success:^(NSArray<Playlist *> *response) {
                                     XCTAssertTrue(limit == response.count);
                                     [expectation fulfill];
                                 } error:^(NSError *error) {
                                     //                        NSLog(@"error = %@", [error localizedDescription]);
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
    
    NSString *username = @"deleteme100";
    NSString *password = @"deleteme100";
    
    XCTestExpectation *expectation = [self expectationWithDescription:@"Testing Async Method Works!"];
    
    [self.humm loginWithUsername:username password:password onLoginSuccess:^{
        PlaylistsAPI *playlistAPI = [self.humm playlists];
        
        NSInteger limit = 1;
        NSInteger offset = 0;
        
        [playlistAPI getRecentWithLimit:limit offset:offset
                                success:^(NSArray<Playlist *> *response) {
                                    XCTAssertTrue(limit == response.count);
                                    [expectation fulfill];
                                } error:^(NSError *error) {
                                    //                        NSLog(@"error = %@", [error localizedDescription]);
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
    
    NSString *username = @"deleteme100";
    NSString *password = @"deleteme100";
    
    XCTestExpectation *expectation = [self expectationWithDescription:@"Testing Async Method Works!"];
    
    [self.humm loginWithUsername:username password:password onLoginSuccess:^{
        PlaylistsAPI *playlistAPI = [self.humm playlists];
        
        NSInteger limit = 5;
        NSInteger offset = 0;
        BOOL album = NO;
        NSString *keyword = @"Thriller";
        
        [playlistAPI searchWithKeyword:keyword limit:limit offset:offset album:album
                               success:^(NSArray<Playlist *> *response) {
                                   XCTAssertTrue(limit == response.count);
                                   [expectation fulfill];
                               } error:^(NSError *error) {
                                   //                        NSLog(@"error = %@", [error localizedDescription]);
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
