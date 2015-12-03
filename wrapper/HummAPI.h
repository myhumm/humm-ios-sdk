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
#import "Song.h"

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


-(void) loginWithUsername:(NSString *) username
                 password:(NSString *) password
           onLoginSuccess:(void (^) (void)) loginSuccess
             onLoginError:(void (^) (NSError *error)) loginError;

-(void) radio:(NSArray *) genres
        moods:(NSArray *) moods
    discovery:(BOOL) discovery
        limit:(NSInteger) limit
          own:(BOOL) own
      success:(void (^) (NSArray<Song *> *response)) success
        error:(void (^) (NSError *err)) error;


+ (id)sharedManager;
-(void) updateUserToken;

@end
