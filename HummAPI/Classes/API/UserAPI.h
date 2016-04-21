//
//  UserAPI.h
//  wrapper
//
//  Created by Jose Alonso García on 30/11/15.
//  Copyright © 2015 humm. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "HummAPI.h"
#import "LoginInfo.h"
#import "User.h"
#import "Playlist.h"
#import "Artist.h"
#import "Song.h"

@interface UserAPI : HummAPI

//+ (id)sharedManager;

- (void) doLoginWithUsername: (NSString *) username
                 andPassword: (NSString *) password
                     success:(void (^) (LoginInfo *response)) success
                       error:(void (^) (NSError *error)) error;

- (void) doSignupWithUsername: (NSString *) username
                     password: (NSString *) password
                        email: (NSString *) email
                    firstName: (NSString *) firstName
                     lastName:(NSString *) lastName
                      success:(void (^) (LoginInfo *response)) success
                        error:(void (^) (NSError *error)) error;

- (void) refreshToken:(void (^) (LoginInfo *response)) success
                error:(void (^) (NSError *error)) error;

-(void) me:(void (^) (User *response)) success
     error:(void (^) (NSError *error)) error;

-(void) discoverReleasesWithLimit:(NSInteger) limit
                           offset:(NSInteger) offset
                          success:(void (^) (NSArray<Playlist *> * response)) success
                            error:(void (^) (NSError *error)) error;

-(void) discoverArtistsWithLimit:(NSInteger) limit
                          offset:(NSInteger) offset
                         success:(void (^) (NSArray<Artist *> *response)) success
                           error:(void (^) (NSError *error)) error;

-(void) discoverPlaylistsWithLimit:(NSInteger) limit
                            offset:(NSInteger) offset
                           success:(void (^) (NSArray<Playlist *> *response)) success
                             error:(void (^) (NSError *error)) error;

-(void) addFavourites:(NSString *) idSong
              success:(void (^) (Song *response)) success
                error:(void (^) (NSError *error)) error;

-(void) addFollows:(NSString *) idUser
             success:(void (^) (User *response)) success
               error:(void (^) (NSError *error)) error;

-(void) removeFollows:(NSString *) idUser
                success:(void (^) (User *response)) success
                  error:(void (^) (NSError *error)) error;

-(void) get:(NSString *) idUser
    success:(void (^) (User *response)) success
      error:(void (^) (NSError *error)) error;

-(void) getFavourites:(NSString *) idUser
                limit:(NSInteger) limit
               offset:(NSInteger) offset
              success:(void (^) (NSArray<Song *> *response)) success
                error:(void (^) (NSError *error)) error;

-(void) getFollows:(NSString *) idUser
               limit:(NSInteger) limit
              offset:(NSInteger) offset
             success:(void (^) (NSArray<User *> *response)) success
               error:(void (^) (NSError *error)) error;

-(void) getPlaylists:(NSString *) idUser
               limit:(NSInteger) limit
              offset:(NSInteger) offset
             success:(void (^) (NSArray<Playlist *> *response)) success
               error:(void (^) (NSError *error)) error;

@end
