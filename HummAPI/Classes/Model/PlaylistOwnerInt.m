//
//  PlaylistOwnerInt.m
//  Pods
//
//  Created by Jose Alonso García on 25/5/16.
//
//

#import "PlaylistOwnerInt.h"

@implementation PlaylistOwnerInt


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
    
    PlaylistOwnerInt *otherPlaylist = (PlaylistOwnerInt *) other;
    
    return [self._id isEqualToString:otherPlaylist._id];
}

@end
