//
//  HummAPI.h
//  wrapper
//
//  Created by Jose Alonso García on 30/11/15.
//  Copyright © 2015 humm. All rights reserved.
//

#import <Foundation/Foundation.h>
@class UserAPI;
@class ArtistsAPI;
@class SongsAPI;
@class PlaylistsAPI;
@class Song;
@class LoginInfo;

//#import "Song.h"ff

@interface HummAPI : NSObject

@property (nonatomic, strong) NSString *endPoint;
@property (nonatomic, strong) NSString *grantType;
@property (nonatomic, strong) NSString *clientId;
@property (nonatomic, strong) NSString *refresh_token;
@property (nonatomic, strong) NSString *token;
@property (nonatomic) NSInteger token_expires;

@property (nonatomic, strong) UserAPI *users;
@property (nonatomic, strong) ArtistsAPI *artists;
@property (nonatomic, strong) SongsAPI *songs;
@property (nonatomic, strong) PlaylistsAPI *playlists;

@property (nonatomic, assign, getter=isDebug) BOOL MODE_DEBUG;

-(void) loginWithUsername:(NSString *) username
                 password:(NSString *) password
           onLoginSuccess:(void (^) (void)) loginSuccess
             onLoginError:(void (^) (NSError *error)) loginError;

-(void) signupWithUsername:(NSString *) username
                  password:(NSString *) password
                     email: (NSString *) email
                 firstName: (NSString *) firstName
                  lastName:(NSString *) lastName
                   referal:(NSString *) referal
            onLoginSuccess:(void (^) (void)) loginSuccess
              onLoginError:(void (^) (NSError *error)) loginError;

-(void) radio:(NSArray *) genres
        moods:(NSArray *) moods
    discovery:(BOOL) discovery
        limit:(NSInteger) limit
          own:(BOOL) own
      success:(void (^) (NSArray<Song *> *response)) success
        error:(void (^) (NSError *err)) error;


-(void) weeklyPlaylist:(void (^) (NSArray<Song *> *response)) success
                 error:(void (^) (NSError *err)) error;

+ (id)sharedManager;

-(void) updateUserToken:(void (^) (void)) updatedSuccess
         onUpdatedError:(void (^) (NSError *error)) updatedError;

-(void) updateLoginDataWithLoginInfo:(LoginInfo *) loginInfo;
-(NSString *) getToken;

@end
