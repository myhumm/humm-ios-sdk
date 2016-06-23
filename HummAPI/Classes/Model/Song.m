//
//  Song.m
//  wrapper
//
//  Created by Jose Alonso García on 1/12/15.
//  Copyright © 2015 humm. All rights reserved.
//

#import "Song.h"

@implementation Song

+(BOOL)propertyIsOptional:(NSString*)propertyName
{
    return YES;
}


-(NSString *) getYoutubeId {
    if (self.foreign_ids)
    {
        return self.foreign_ids[@"youtube"];
    }
    
    return nil;
}

-(NSString *) getYoutubeURL {
    if (self.urls)
    {
        return self.urls[@"youtube"];
    }
    
    return nil;
}

-(NSString *) getPopularity {
    if (self.stats)
    {
        return self.stats[@"popularity"];
    }
    return nil;
}

-(NSString *) getPlaylists {
    if (self.stats)
    {
        return self.stats[@"playlists"];
    }
    return nil;
    
}

-(NSString *) getArtistName {
    if (self.artists && [self.artists firstObject])
    {
        return [self.artists firstObject][@"name"];
    }
    return nil;
    
}

-(NSString *) getArtistId{
    if (self.artists && [self.artists firstObject])
    {
        return [self.artists firstObject][@"uid"];
    }
    return nil;
    
}


-(NSString *) getYoutubeVideoImage
{
    return [NSString stringWithFormat:@"http://img.youtube.com/vi/%@/0.jpg", self.getYoutubeId];
}

#define PLAYLIST_ENDPOINT @"http://wave.livingindietv.com/images/playlist?id=%@&size=thumb"


-(NSString *) getPlaylistCover
{
    if (self.playlists)
    {
        NSString *idPlaylist = [self.playlists firstObject][@"pid"];
        return [NSString stringWithFormat:@"http://wave.livingindietv.com/images/playlist?id=%@&size=thumb", idPlaylist];
    }
    return nil;
}

@end
