//
//  SongsAPI.h
//  wrapper
//
//  Created by Jose Alonso García on 1/12/15.
//  Copyright © 2015 humm. All rights reserved.
//

#import "HummAPI.h"
#import "Song.h"
#import "Playlist.h"

@interface SongsAPI : HummAPI

-(void) featuredWithGenre:(NSString *) genre
                       limit:(NSInteger) limit
                      offset:(NSInteger) offset
                     success:(void (^) (NSArray<Song *> *response)) success
                       error:(void (^) (NSError *error)) error;

-(void) popularWithGenre:(NSString *) genre
                      limit:(NSInteger) limit
                     offset:(NSInteger) offset
                    success:(void (^) (NSArray<Song *> *response)) success
                      error:(void (^) (NSError *error)) error;

-(void) recentWithGenre:(NSString *) genre
                  limit:(NSInteger) limit
                 offset:(NSInteger) offset
                success:(void (^) (NSArray<Song *> *response)) success
                  error:(void (^) (NSError *error)) error;

-(void) appearsIn:(NSString *) idSong
            limit:(NSInteger) limit
          success:(void (^) (NSArray<Playlist *> *response)) success
            error:(void (^) (NSError *error)) error;

-(void) get:(NSString *) idSong
    success:(void (^) ( Song *response)) success
      error:(void (^) (NSError *error)) error;

-(void) getSimilar:(NSString *) idSong
             limit:(NSInteger) limit
            offset:(NSInteger) offset
           success:(void (^) ( NSArray<Song *>  *response)) success
             error:(void (^) (NSError *error)) error;

@end
