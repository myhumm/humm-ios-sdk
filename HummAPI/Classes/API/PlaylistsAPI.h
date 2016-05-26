//
//  PlaylistsAPI.h
//  wrapper
//
//  Created by Jose Alonso García on 1/12/15.
//  Copyright © 2015 humm. All rights reserved.
//

#import "HummAPI.h"
#import "Playlist.h"
#import "Song.h"
#import "PlaylistOwnerInt.h"

@interface PlaylistsAPI : HummAPI

-(void) create:(NSString *) description
       private:(BOOL) private
    title:(NSString *) title
    success:(void (^) (PlaylistOwnerInt *response)) success
    error:(void (^) (NSError *error)) error;

-(void) getFeaturedWithLimit:(NSInteger) limit
                      offset:(NSInteger) offset
                     success:(void (^) (NSArray<Playlist *> *response)) success
                       error:(void (^) (NSError *error)) error;

-(void) get:(NSString *) idPlaylist
    success:(void (^) (Playlist *response)) success
      error:(void (^) (NSError *error)) error;

-(void) update:(NSString *) idPlaylist
   description:(NSString *) description
       private:(BOOL) private
title:(NSString *) title
success:(void (^) (Playlist *response)) success
error:(void (^) (NSError *error)) error;

-(void) order:(NSString *) idPlaylist
 songsOrdered: (NSArray *) songs
      success:(void (^) (Playlist *response)) success
        error:(void (^) (NSError *error)) error;

-(void) getSongs:(NSString *) idPlaylist
           limit:(NSInteger) limit
          offset:(NSInteger) offset
         success:(void (^) (NSArray<Song *> *response)) success
           error:(void (^) (NSError *error)) error;

-(void) addSong:(NSString *) idPlaylist
       position:(NSInteger) position
         idSong:(NSString *) idSong
        success:(void (^) (Playlist *response)) success
          error:(void (^) (NSError *error)) error;

-(void) removeSong:(NSString *) idPlaylist
            idSong:(NSString *) idSong
           success:(void (^) (Playlist *response)) success
             error:(void (^) (NSError *error)) error;

-(void) addSubscriber:(NSString *) idPlaylist
              success:(void (^) (Playlist *response)) success
                error:(void (^) (NSError *error)) error;


-(void) removeSubscriber:(NSString *) idPlaylist
                 success:(void (^) (Playlist *response)) success
                   error:(void (^) (NSError *error)) error;

-(void) getPopularWithLimit:(NSInteger) limit
                     offset:(NSInteger) offset
                  selection:(NSString *)selection
                     idUser:(NSString *) idUser
                    success:(void (^) (NSArray<Playlist *> *response)) success
                      error:(void (^) (NSError *error)) error;

-(void) getRecentWithLimit:(NSInteger) limit
                    offset:(NSInteger) offset
                   success:(void (^) (NSArray<Playlist *> *response)) success
                     error:(void (^) (NSError *error)) error;

-(void) searchWithKeyword:(NSString *) keyword
                    limit:(NSInteger) limit
                   offset:(NSInteger) offset
                    album:(BOOL) album
                  success:(void (^) (NSArray<Playlist *> *response)) success
                    error:(void (^) (NSError *error)) error;

-(void) getStaffPicksWithlimit:(NSInteger) limit
                        offset:(NSInteger) offset
                       success:(void (^) (NSArray<Playlist *> *response)) success
                         error:(void (^) (NSError *error)) error;

@end
