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

+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"_id": @"_id",
                                                       @"stats": @"stats",
                                                       @"title": @"title",
                                                       @"description": @"playlistDescription",
                                                       @"private": @"playlistPrivate"
                                                       }];
}


- (NSString *) getCover
{
    return [NSString stringWithFormat:PLAYLIST_ENDPOINT, self._id ];
    
}

-(NSString *) getOwnerName
{
    if ([self.owner firstObject][@"name"])
    {
        return [self.owner firstObject][@"name"];
    }
    
    
    return nil;
}

-(NSString *) getOwnerAvatar
{
    if ([self.owner firstObject][@"avatar"])
    {
        return [self.owner firstObject][@"avatar"];
    }
    
    
    return nil;
}

-(NSString *) getOwnerUid
{
    if ([self.owner firstObject][@"uid"])
    {
        return [self.owner firstObject][@"uid"];
    }
    
    
    return nil;
}


- (BOOL)isEqual:(id)other {
    
    Playlist *otherPlaylist = (Playlist *) other;
    
    return [self._id isEqualToString:otherPlaylist._id];
}

@end
