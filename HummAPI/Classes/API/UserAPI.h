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
#import "HummSettings.h"
#import "Subscription.h"

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
                      referal:(NSString *) referal
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
             success:(void (^) (NSArray<Artist *> *response)) success
               error:(void (^) (NSError *error)) error;

-(void) getPlaylists:(NSString *) idUser
               limit:(NSInteger) limit
              offset:(NSInteger) offset
             success:(void (^) (NSArray<Playlist *> *response)) success
               error:(void (^) (NSError *error)) error;

-(void) getSubscriptions:(NSString *) idUser
                 success:(void (^) (NSArray<Subscription *> *response)) success
                   error:(void (^) (NSError *error)) error;


-(void) resetPassword: (NSString *) email
              success:(void (^) (BOOL response)) success
                error:(void (^) (NSError *error)) error;

-(void) checkUsername: (NSString *) username
              success:(void (^) (BOOL response)) success
                error:(void (^) (NSError *error)) error;

-(void) checkEmail: (NSString *) email
           success:(void (^) (BOOL response)) success
             error:(void (^) (NSError *error)) error;

-(void) loginWithService:(NSString *) userId
          onLoginSuccess:(void (^) (LoginInfo *loginInfo)) loginSuccess
            onLoginError:(void (^) (NSError *error)) loginError;

-(void) addServiceWithServiceName:(NSString *) serviceName
                         seviceId:(NSString *) serviceId
                            token:(NSString *) serviceToken
                  serviceUsername:(NSString *) serviceUsername
                           secret:(NSString *) secret
                          success:(void (^) (HummSettings * response)) success
                            error:(void (^) (NSError *error)) error;

-(void) removeService:(NSString *) serviceName
            serviceId:(NSString *) serviceId
              success:(void (^) (LoginInfo * response)) success
                error:(void (^) (NSError *error)) error;


-(void) putGenres:(NSArray *) likes
         dislikes: (NSArray *) dislikes
          success:(void (^) (LoginInfo * response)) success
            error:(void (^) (NSError *error)) error;

-(void) putLang:(NSString *) lang
        success:(void (^) (LoginInfo * response)) success
          error:(void (^) (NSError *error)) error;

@end
