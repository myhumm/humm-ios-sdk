//
//  Artist.m
//  wrapper
//
//  Created by Jose Alonso García on 30/11/15.
//  Copyright © 2015 humm. All rights reserved.
//

#import "Artist.h"

@implementation Artist


+(BOOL)propertyIsOptional:(NSString*)propertyName
{
    return YES;
}


-(NSString *) getName
{
    if ((self.account) && (self.account[@"name"]))
    {
        NSDictionary *artistName = self.account[@"name"];
        return artistName[@"first"];
    }
    
    return nil;
}

-(NSString *) getHashtag
{
    if ((self.account) && (self.account[@"name"]))
    {
        NSDictionary *artistName = self.account[@"name"];
        return artistName[@"hashtag"];
    }
    
    return nil;
}

-(NSString *) getAvatar
{
    if ((self.account) && (self.account[@"avatar"]))
    {
        return self.account[@"avatar"];
    }
    
    return nil;
}

-(NSString *) getBio
{
    if ((self.account) && (self.account[@"bio"]))
    {
        return self.account[@"bio"];
    }
    
    return nil;
}
-(NSString *) getYoutubeURL
{
    if ((self.account) && (self.urls[@"youtube"]))
    {
        return self.urls[@"youtube"];
    }
    
    return nil;
}

-(NSString *) getSpotifyURL
{
    if ((self.account) && (self.urls[@"spotify_url"]))
    {
        return self.urls[@"spotify_url"];
    }
    
    return nil;
}

-(NSString *) getPopularity
{
    if ((self.account) && (self.stats[@"popularity"]))
    {
        return self.stats[@"popularity"];
    }
    
    return nil;
}

-(NSString *) getPlaylists
{
    if ((self.account) && (self.stats[@"playlists"]))
    {
        return self.stats[@"playlists"];
    }
    
    return nil;
}

- (BOOL)isEqual:(id)other {
    
    Artist *otherArtist = (Artist *) other;
    
    return [self._id isEqualToString:otherArtist._id];
}


@end
