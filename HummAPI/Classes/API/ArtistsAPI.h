//
//  ArtistsAPI.h
//  wrapper
//
//  Created by Jose Alonso García on 30/11/15.
//  Copyright © 2015 humm. All rights reserved.
//

#import "HummAPI.h"
#import "Artist.h"
#import "Playlist.h"
#import "Song.h"

@interface ArtistsAPI : HummAPI

#define SONG_TYPE_COVER @"cover";
#define SONG_TYPE_TRACK @"track";
#define SONG_TYPE_VERSION @"version";
#define SONG_TYPE_VIDEO @"video";

-(void) get:(NSString *) idArtist
      limit:(NSInteger) limit
     offset:(NSInteger) offset
    success:(void (^) (Artist *response)) success
      error:(void (^) (NSError *error)) error;

-(void) addFollower:(NSString *) idArtist
            success:(void (^) (Artist *response)) success
              error:(void (^) (NSError *error)) error;

-(void) removeFollower:(NSString *) idArtist
               success:(void (^) (Artist *response)) success
                 error:(void (^) (NSError *error)) error;

-(void) getPlaylists:(NSString *) idArtist
               limit:(NSInteger) limit
              offset:(NSInteger) offset
             success:(void (^) (NSArray<Playlist *> *response)) success
               error:(void (^) (NSError *error)) error;

-(void) getRadio:(NSString *) idArtist
           limit:(NSInteger) limit
          offset:(NSInteger) offset
         success:(void (^) (NSArray<Song *> *response)) success
           error:(void (^) (NSError *error)) error;

-(void) getSimilar:(NSString *) idArtist
             limit:(NSInteger) limit
            offset:(NSInteger) offset
           success:(void (^) (NSArray<Artist *> *response)) success
             error:(void (^) (NSError *error)) error;

-(void) getTopSongs:(NSString *) idArtist
              limit:(NSInteger) limit
             offset:(NSInteger) offset
           songType:(NSString *) songType
               live:(BOOL) live
            success:(void (^) (NSArray<Song *> *response)) success
              error:(void (^) (NSError *error)) error;

-(void) getFeaturedWithLimit:(NSInteger) limit
                      offset:(NSInteger) offset
                       genre:(NSString *) genre
                     success:(void (^) (NSArray<Artist *> *response)) success
                       error:(void (^) (NSError *error)) error;

-(void) getPopularWithLimit:(NSInteger) limit
                     offset:(NSInteger) offset
                    success:(void (^) (NSArray<Artist *> *response)) success
                      error:(void (^) (NSError *error)) error;

-(void) getRecent:(NSInteger) limit
           offset:(NSInteger) offset
          success:(void (^) (NSArray<Artist *> *response)) success
            error:(void (^) (NSError *error)) error;

-(void) search:(NSString *) keyword
         limit:(NSInteger) limit
        offset:(NSInteger) offset
       success:(void (^) (NSArray<Artist *> *response)) success
         error:(void (^) (NSError *error)) error;

@end
