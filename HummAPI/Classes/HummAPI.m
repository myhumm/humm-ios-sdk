//
//  HummAPI.m
//  wrapper
//
//  Created by Jose Alonso García on 30/11/15.
//  Copyright © 2015 humm. All rights reserved.
//

#import "HummAPI.h"
#import "UserAPI.h"
#import "ArtistsAPI.h"
#import "SongsAPI.h"
#import "PlaylistsAPI.h"
#import "OthersAPI.h"

@implementation HummAPI

+ (id)sharedManager {
    static HummAPI *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
        sharedMyManager.endPoint = @"http://api.myhumm.com/v2";
        sharedMyManager.grantType = @"password";
        sharedMyManager.clientId = @"5433be703acd3952a3e9ec28";
        sharedMyManager.token_expires = 0;
    });
    return sharedMyManager;
}

-(void) loginWithUsername:(NSString *) username
                 password:(NSString *) password
           onLoginSuccess:(void (^) (void)) loginSuccess
             onLoginError:(void (^) (NSError *error)) loginError
{
    [[self users] doLoginWithUsername:username andPassword:password success:^(LoginInfo *response) {
        [self updateLoginDataWithLoginInfo:(response)];
        loginSuccess();
    } error:^(NSError *error) {
        loginError(error);
    }];
}

-(void) signupWithUsername:(NSString *) username
                  password:(NSString *) password
                     email: (NSString *) email
                 firstName: (NSString *) firstName
                  lastName:(NSString *) lastName
            onLoginSuccess:(void (^) (void)) loginSuccess
              onLoginError:(void (^) (NSError *error)) loginError
{
    [[self users] doSignupWithUsername:username password:password email:email firstName:firstName lastName:lastName success:^(LoginInfo *response) {
        [self updateLoginDataWithLoginInfo:(response)];
        loginSuccess();
    } error:^(NSError *error) {
        loginError(error);
    }];
}

-(void) updateUserToken
{
    NSDate *date = [NSDate date];
    NSInteger seconds = [date timeIntervalSince1970];

//    NSLog(@"seconds = %ld", (long)seconds);
//    NSLog(@"self.token_expires = %ld", (long)self.token_expires);
    if (seconds < self.token_expires) {
        //user is loged
        if (self.token) {
            return;
        }
    }
    
    //TODO: test

    [[self users] refreshToken:^(LoginInfo *response) {
        [self updateLoginDataWithLoginInfo:(response)];
    } error:^(NSError *error) {
    }];


    
}

-(void) radio:(NSArray *) genres
        moods:(NSArray *) moods
    discovery:(BOOL) discovery
        limit:(NSInteger) limit
          own:(BOOL) own
      success:(void (^) (NSArray<Song *> *response)) success
        error:(void (^) (NSError *err)) error
{
    [[self others] radio:genres moods:moods discovery:discovery limit:limit own:own success:^(NSArray<Song *> *response) {
        success(response);
    } error:^(NSError *err) {
        error(err);
    }];
}


-(void) updateLoginDataWithLoginInfo:(LoginInfo *) loginInfo
{
    self.token = loginInfo.access_token;
    self.refresh_token = loginInfo.refresh_token;
    self.token_expires = loginInfo.expires_in;
}

- (UserAPI *) users {
    return [[UserAPI alloc] init];
}

- (ArtistsAPI *) artists {
    return [[ArtistsAPI alloc] init];
}

- (SongsAPI *) songs {
    return [[SongsAPI alloc] init];
}

- (PlaylistsAPI *)playlists
{
    return [[PlaylistsAPI alloc]init];
}

- (OthersAPI *)others
{
    return [[OthersAPI alloc]init];
}


@end
