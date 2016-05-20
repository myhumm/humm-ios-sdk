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
        sharedMyManager.MODE_DEBUG = NO;
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
                   referal:(NSString *) referal
            onLoginSuccess:(void (^) (void)) loginSuccess
              onLoginError:(void (^) (NSError *error)) loginError
{
    [[self users] doSignupWithUsername:username password:password email:email firstName:firstName lastName:lastName referal:referal success:^(LoginInfo *response) {
        [self updateLoginDataWithLoginInfo:(response)];
        loginSuccess();
    } error:^(NSError *error) {
        loginError(error);
    }];
}

-(void) updateUserToken:(void (^) (void)) updatedSuccess
         onUpdatedError:(void (^) (NSError *error)) updatedError

{
    NSDate *date = [NSDate date];
    NSInteger seconds = [date timeIntervalSinceReferenceDate];
    
    if (self.MODE_DEBUG)
    {
        NSLog(@"seconds now = %ld", (long)seconds);
        NSLog(@"token expires = %ld", (long)self.token_expires);
        
    }
    if (seconds < self.token_expires) {
        //user is loged
        if (self.token) {
            updatedSuccess();
            return;
        }
    }
    
    
    [[self users] refreshToken:^(LoginInfo *response) {
        [self updateLoginDataWithLoginInfo:(response)];
        updatedSuccess();
    } error:^(NSError *error) {
        updatedError(error);
    }];
    
}

-(NSString *) getToken
{
    if (!self.token)
    {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSString *tokenStored = [defaults objectForKey:@"token"];
        
        self.token = tokenStored;
        self.token_expires = [defaults integerForKey:@"token_expires"];

        //TODO: check to renew
        return tokenStored;
        
    }
    else {
        return self.token;
    }
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

-(void) weeklyPlaylist:(void (^) (NSArray<Song *> *response)) success
                 error:(void (^) (NSError *err)) error
{
    [[self others]weeklyPlaylist:^(NSArray<Song *> *response) {
        success(response);
    } error:^(NSError *err) {
        error(err);
    }];
}


-(void) updateLoginDataWithLoginInfo:(LoginInfo *) loginInfo
{
    if (self.MODE_DEBUG)
    {
        NSLog(@"%@" , loginInfo);
    }
    
    self.token = loginInfo.access_token;
    self.refresh_token = loginInfo.refresh_token;
    
    NSDate *date = [NSDate date];
    NSInteger seconds = [date timeIntervalSinceReferenceDate];
    
    self.token_expires = seconds + loginInfo.expires_in;
    
    //save token and token_expires to user defaults
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:self.token forKey:@"token"];
    [defaults setInteger:self.token_expires forKey:@"token_expires"];
    [defaults synchronize];

}

- (UserAPI *) users {
    return [[UserAPI alloc] init];
}

- (ArtistsAPI *) artistAPI {
    return [[ArtistsAPI alloc] init];
}

- (SongsAPI *) songs {
    return [[SongsAPI alloc] init];
}

- (PlaylistsAPI *) playlistAPI
{
    return [[PlaylistsAPI alloc]init];
}

- (OthersAPI *)others
{
    return [[OthersAPI alloc]init];
}


@end
