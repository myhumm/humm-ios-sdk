//
//  Playlist.m
//  wrapper
//
//  Created by Jose Alonso García on 1/12/15.
//  Copyright © 2015 humm. All rights reserved.
//

#import "Playlist.h"

@implementation Playlist

#define PLAYLIST_ENDPOINT @"http://wave.livingindietv.com/images/playlist?id=%@&size=thumb"

+(BOOL)propertyIsOptional:(NSString*)propertyName
{
    return YES;
}

- (NSString *) getCover
{
    return [NSString stringWithFormat:PLAYLIST_ENDPOINT, self._id ];

}



- (BOOL)isEqual:(id)other {
    
    Playlist *otherPlaylist = (Playlist *) other;
    
    return [self._id isEqualToString:otherPlaylist._id];
}

@end
