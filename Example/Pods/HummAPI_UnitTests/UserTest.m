//
//  UserTest.m
//  wrapper
//
//  Created by Jose Alonso García on 30/11/15.
//  Copyright © 2015 humm. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "UserAPI.h"
#import "HummAPI.h"

@interface UserTest : XCTestCase

@property (nonatomic) HummAPI *humm;

@end

@implementation UserTest

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

-(void) testLogin {
    NSString *username = @"jose100";
    NSString *password = @"jose1000";
    
    XCTestExpectation *expectation = [self expectationWithDescription:@"Testing Async Method Works!"];
    
    UserAPI *userAPI = [self.humm users];
    //    [api doLoginWithUsername:username password:password];
    //    [self.humm.users doLoginWithUsername:username password:password];
    
    [userAPI doLoginWithUsername:username andPassword:password success:^(LoginInfo * response) {
        [expectation fulfill];
    } error:^(NSError *error) {
        NSLog(@"error = %@" , [error localizedDescription]);
        XCTAssertFalse(YES);
    }];
    
    [self waitForExpectationsWithTimeout:10.0 handler:^(NSError * _Nullable error) {
        if(error)
        {
            XCTFail(@"Expectation Failed with error: %@", error);
        }
        
    }];
}
-(void) testSignup {
    NSString *username = @"deletemeIos3";
    NSString *password = @"deletemeIos3";
    NSString *email = @"deletemeIos2@ios3.com";
    NSString *firstName = @"delete";
    NSString *lastName = @"me";
    NSString *referal = @"referal";
    
    XCTestExpectation *expectation = [self expectationWithDescription:@"Testing Async Method Works!"];
    
    UserAPI *userAPI = [self.humm users];
    self.humm.MODE_DEBUG = YES;

    
    [userAPI doSignupWithUsername:username
                         password:password
                            email:email
                        firstName:firstName
                         lastName:lastName
                          referal:referal
                          success:^(LoginInfo *response) {
                              [expectation fulfill];
                          } error:^(NSError *error) {
                              XCTAssertFalse(YES);
                          }];
    
    [self waitForExpectationsWithTimeout:10.0 handler:^(NSError * _Nullable error) {
        if(error)
        {
            XCTFail(@"Expectation Failed with error: %@", error);
        }
        
    }];
}

-(void) testMe {
    
    
    NSString *username = @"deleteme100";
    NSString *password = @"deleteme100";
    
    XCTestExpectation *expectation = [self expectationWithDescription:@"Testing Async Method Works!"];
    
    [self.humm loginWithUsername:username password:password onLoginSuccess:^{
        UserAPI *userAPI = [self.humm users];
        
        [userAPI me:^(User *response) {
            
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

-(void) testDiscoverReleases {
    
    NSString *username = @"deleteme100";
    NSString *password = @"deleteme100";
    
    XCTestExpectation *expectation = [self expectationWithDescription:@"Testing Async Method Works!"];
    
    [self.humm loginWithUsername:username password:password onLoginSuccess:^{
        UserAPI *usersApi = [self.humm users];
        
        
        NSInteger limit = 5;
        NSInteger offset = 0;
        
        [usersApi discoverReleasesWithLimit:limit offset:offset
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

-(void) testDiscoverArtists {
    
    NSString *username = @"deleteme100";
    NSString *password = @"deleteme100";
    
    XCTestExpectation *expectation = [self expectationWithDescription:@"Testing Async Method Works!"];
    
    [self.humm loginWithUsername:username password:password onLoginSuccess:^{
        UserAPI *usersApi = [self.humm users];
        
        
        NSInteger limit = 5;
        NSInteger offset = 0;
        
        [usersApi discoverArtistsWithLimit:limit offset:offset
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

-(void) testDiscoverPlaylists {
    
    NSString *username = @"deleteme100";
    NSString *password = @"deleteme100";
    
    XCTestExpectation *expectation = [self expectationWithDescription:@"Testing Async Method Works!"];
    
    [self.humm loginWithUsername:username password:password onLoginSuccess:^{
        UserAPI *usersApi = [self.humm users];
        
        
        NSInteger limit = 5;
        NSInteger offset = 0;
        
        [usersApi discoverPlaylistsWithLimit:limit offset:offset
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

-(void) testAddFavourite {
    
    NSString *username = @"deleteme100";
    NSString *password = @"deleteme100";
    
    XCTestExpectation *expectation = [self expectationWithDescription:@"Testing Async Method Works!"];
    
    [self.humm loginWithUsername:username password:password onLoginSuccess:^{
        UserAPI *usersApi = [self.humm users];
        
        
        NSString *idSong =@"557ecbf86a64fc1b8bed533f";
        
        [usersApi addFavourites:idSong
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


-(void) testAddFollows {
    
    NSString *username = @"deleteme100";
    NSString *password = @"deleteme100";
    
    XCTestExpectation *expectation = [self expectationWithDescription:@"Testing Async Method Works!"];
    
    [self.humm loginWithUsername:username password:password onLoginSuccess:^{
        UserAPI *usersApi = [self.humm users];
        
        NSString *idUser =@"565f15eeae8c506937ebf1f6"; //user1
        
        [usersApi addFollows:idUser
                     success:^(User *response) {
                         
                         XCTAssertEqualObjects(@"deleteme100", response.getUsername);
                         
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

-(void) testRemoveFollows {
    
    NSString *username = @"deleteme100";
    NSString *password = @"deleteme100";
    
    XCTestExpectation *expectation = [self expectationWithDescription:@"Testing Async Method Works!"];
    
    [self.humm loginWithUsername:username password:password onLoginSuccess:^{
        UserAPI *usersApi = [self.humm users];
        
        NSString *idUser =@"565f15eeae8c506937ebf1f6"; //user1
        
        [usersApi removeFollows:idUser
                        success:^(User *response) {
                            
                            XCTAssertEqualObjects(@"deleteme100", response.getUsername);
                            
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

-(void) testGetUser {
    
    NSString *username = @"deleteme100";
    NSString *password = @"deleteme100";
    
    XCTestExpectation *expectation = [self expectationWithDescription:@"Testing Async Method Works!"];
    
    [self.humm loginWithUsername:username password:password onLoginSuccess:^{
        UserAPI *usersApi = [self.humm users];
        
        
        NSString *idUser =@"5649c572ae8c502824a46a99"; //user1
        
        [usersApi get:idUser
              success:^(User *response) {
                  
                  XCTAssertEqualObjects(@"user1", response.getUsername);
                  
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

//-(void) testGetFavourites {
//
//    NSString *username = @"deleteme100";
//    NSString *password = @"deleteme100";
//
//    XCTestExpectation *expectation = [self expectationWithDescription:@"Testing Async Method Works!"];
//
//    [self.humm loginWithUsername:username password:password onLoginSuccess:^{
//        UserAPI *usersApi = [self.humm users];
//
//        [self.humm updateUserToken];
//
//        NSString *idUser =@"5649c572ae8c502824a46a99"; //user1
//        NSInteger limit = 5;
//        NSInteger offset = 0;
//        [usersApi getFavourites:idUser limit:limit offset:offset
//              success:^(NSArray<Song *> *response) {
//
//                  XCTAssertTrue(response.count == limit);
//
//                  [expectation fulfill];
//              }
//                error:^(NSError *error) {
//                    NSLog(@"error = %@", [error localizedDescription]);
//                    XCTAssertFalse(YES);
//                }];
//
//    } onLoginError:^(NSError *error) {
//        XCTAssertFalse(YES);
//    }];
//
//    [self waitForExpectationsWithTimeout:15.0 handler:^(NSError * _Nullable error) {
//        if(error)
//        {
//            XCTFail(@"Expectation Failed with error: %@", error);
//        }
//
//    }];
//
//
//}

-(void) testGetFollows {
    
    NSString *username = @"deleteme100";
    NSString *password = @"deleteme100";
    
    XCTestExpectation *expectation = [self expectationWithDescription:@"Testing Async Method Works!"];
    
    [self.humm loginWithUsername:username password:password onLoginSuccess:^{
        UserAPI *usersApi = [self.humm users];
        
        
        NSString *idUser =@"5649c572ae8c502824a46a99"; //user1
        NSInteger limit = 1;
        NSInteger offset = 0;
        [usersApi getFollows:idUser limit:limit offset:offset
                     success:^(NSArray<User *> *response) {
                         
                         XCTAssertTrue(response.count == limit);
                         
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
    
    NSString *username = @"deleteme100";
    NSString *password = @"deleteme100";
    
    XCTestExpectation *expectation = [self expectationWithDescription:@"Testing Async Method Works!"];
    
    [self.humm loginWithUsername:username password:password onLoginSuccess:^{
        UserAPI *usersApi = [self.humm users];
        
        
        NSString *idUser =@"565f15eeae8c506937ebf1f6"; //user1
        NSInteger limit = 5;
        NSInteger offset = 0;
        [usersApi getPlaylists:idUser limit:limit offset:offset
                       success:^(NSArray<Playlist *> *response) {
                           
                           
                           XCTAssertTrue(response.count == limit);
                           
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

-(void) testResetPassword {
    NSString *email = @"jose@neteleven.es";
    
    XCTestExpectation *expectation = [self expectationWithDescription:@"Testing Async Method Works!"];
    
    self.humm.MODE_DEBUG = YES;
    UserAPI *userAPI = [self.humm users];
    
    [userAPI resetPassword:email success:^(BOOL response) {
        XCTAssertTrue (response);
        [expectation fulfill];
    } error:^(NSError *error) {
        NSLog(@"error = %@", [error localizedDescription]);
        XCTAssertFalse(YES);
    }];
    
    [self waitForExpectationsWithTimeout:15.0 handler:^(NSError * _Nullable error) {
        if(error)
        {
            XCTFail(@"Expectation Failed with error: %@", error);
        }
        
    }];
    
}

-(void) testCheckEmail {
    NSString *email = @"jose@neteleven.es";
    
    XCTestExpectation *expectation = [self expectationWithDescription:@"Testing Async Method Works!"];
    
    self.humm.MODE_DEBUG = YES;
    UserAPI *userAPI = [self.humm users];
    
    [userAPI checkEmail:email success:^(BOOL response) {
        XCTAssertTrue (response);
        [expectation fulfill];
    } error:^(NSError *error) {
        NSLog(@"error = %@", [error localizedDescription]);
        XCTAssertFalse(YES);
    }];
    
    [self waitForExpectationsWithTimeout:15.0 handler:^(NSError * _Nullable error) {
        if(error)
        {
            XCTFail(@"Expectation Failed with error: %@", error);
        }
        
    }];
    
}

-(void) testCheckUsername {
    NSString *username = @"josealonso";
    
    XCTestExpectation *expectation = [self expectationWithDescription:@"Testing Async Method Works!"];
    
    self.humm.MODE_DEBUG = YES;
    UserAPI *userAPI = [self.humm users];
    
    [userAPI checkUsername:username success:^(BOOL response) {
        XCTAssertTrue (response);
        [expectation fulfill];
    } error:^(NSError *error) {
        NSLog(@"error = %@", [error localizedDescription]);
        XCTAssertFalse(YES);
    }];
    
    [self waitForExpectationsWithTimeout:15.0 handler:^(NSError * _Nullable error) {
        if(error)
        {
            XCTFail(@"Expectation Failed with error: %@", error);
        }
        
    }];
    
}

-(void) testRemoveService {
    NSString *service = @"facebook";
    NSString *userId = @"180331315688964";
    
    XCTestExpectation *expectation = [self expectationWithDescription:@"Testing Async Method Works!"];
    
    self.humm.MODE_DEBUG = YES;
    UserAPI *userAPI = [self.humm users];
    
    [userAPI removeService:service serviceId:userId
                   success:^(LoginInfo * response) {
        XCTAssertTrue (YES);
        [expectation fulfill];
    } error:^(NSError *error) {
        NSLog(@"error = %@", [error localizedDescription]);
        XCTAssertFalse(YES);
    }];
    
    [self waitForExpectationsWithTimeout:15.0 handler:^(NSError * _Nullable error) {
        if(error)
        {
            XCTFail(@"Expectation Failed with error: %@", error);
        }
        
    }];
    
}

-(void) testPutGenres {
    NSArray *likes = @[@"pop", @"rock"];
    NSArray *dislikes = @[@"samba"];
    
    self.humm.MODE_DEBUG = YES;

    XCTestExpectation *expectation = [self expectationWithDescription:@"Testing Async Method Works!"];

    [self.humm loginWithUsername:@"jose100" password:@"jose1000" onLoginSuccess:^{
        
        UserAPI *userAPI = [self.humm users];
        
        [userAPI putGenres:likes dislikes:dislikes success:^(LoginInfo *response) {
            XCTAssertTrue (YES);
            [expectation fulfill];
            
        } error:^(NSError *error) {
            NSLog(@"error = %@", [error localizedDescription]);
            XCTAssertFalse(YES);
            
        }];
        
    } onLoginError:^(NSError *error) {
        XCTFail(@"Expectation Failed with error: %@", error);

    }];
    
    [self waitForExpectationsWithTimeout:15.0 handler:^(NSError * _Nullable error) {
        if(error)
        {
            XCTFail(@"Expectation Failed with error: %@", error);
        }
        
    }];

    

}

-(void) testTwitterService
{
    NSString *user = @"jose100";
    NSString *password = @"jose1000";
    
    self.humm.MODE_DEBUG = YES;
    
    XCTestExpectation *expectation = [self expectationWithDescription:@"Testing Async Method Works!"];
    
    [self.humm loginWithUsername:user password:password onLoginSuccess:^{
        
        UserAPI *userAPI = [self.humm users];
        
        [userAPI me:^(User *response) {
            XCTAssertTrue ([response getTwitterService] != nil);
            [expectation fulfill];

        } error:^(NSError *error) {
            NSLog(@"error = %@", [error localizedDescription]);
            XCTAssertFalse(YES);

        }];
        
    } onLoginError:^(NSError *error) {
        XCTFail(@"Expectation Failed with error: %@", error);
        
    }];
    
    [self waitForExpectationsWithTimeout:15.0 handler:^(NSError * _Nullable error) {
        if(error)
        {
            XCTFail(@"Expectation Failed with error: %@", error);
        }
        
    }];

}

-(void) testFacebookService
{
    NSString *user = @"jose100";
    NSString *password = @"jose1000";
    
    self.humm.MODE_DEBUG = YES;
    
    XCTestExpectation *expectation = [self expectationWithDescription:@"Testing Async Method Works!"];
    
    [self.humm loginWithUsername:user password:password onLoginSuccess:^{
        
        UserAPI *userAPI = [self.humm users];
        
        [userAPI me:^(User *response) {
            XCTAssertTrue ([response getFacebookService] != nil);
            [expectation fulfill];
            
        } error:^(NSError *error) {
            NSLog(@"error = %@", [error localizedDescription]);
            XCTAssertFalse(YES);
            
        }];
        
    } onLoginError:^(NSError *error) {
        XCTFail(@"Expectation Failed with error: %@", error);
        
    }];
    
    [self waitForExpectationsWithTimeout:15.0 handler:^(NSError * _Nullable error) {
        if(error)
        {
            XCTFail(@"Expectation Failed with error: %@", error);
        }
        
    }];
    
}

-(void) testLoginWithService
{
//    NSString *service = @"facebook";
    NSString *userId = @"180331315688964";
    
    self.humm.MODE_DEBUG = YES;
    
    XCTestExpectation *expectation = [self expectationWithDescription:@"Testing Async Method Works!"];
    
    [[self.humm users]loginWithService:userId onLoginSuccess:^(LoginInfo *loginInfo) {
        XCTAssertTrue (loginInfo != nil);
        [expectation fulfill];
    } onLoginError:^(NSError *error) {
        NSLog(@"error = %@", [error localizedDescription]);
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
