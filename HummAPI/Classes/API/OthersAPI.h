//
//  OthersAPI.h
//  wrapper
//
//  Created by Jose Alonso García on 2/12/15.
//  Copyright © 2015 humm. All rights reserved.
//

#import "HummAPI.h"
#import "Song.h"

@interface OthersAPI : HummAPI

-(void) radio:(NSArray *) genres
        moods:(NSArray *) moods
    discovery:(BOOL) discovery
        limit:(NSInteger) limit
          own:(BOOL) own
      success:(void (^) (NSArray<Song *> *response)) success
        error:(void (^) (NSError *error)) error;

-(void) weeklyPlaylist:(void (^) (NSArray<Song *> *response)) success
                 error:(void (^) (NSError *error)) error;

@end
