//
//  PlaylistOwnerDictionary.m
//  Pods
//
//  Created by Jose Alonso García on 18/5/16.
//
//

#import "PlaylistOwnerDictionary.h"

@implementation PlaylistOwnerDictionary


-(NSString *) getOwnerName
{
    if (self.owner[@"name"])
    {
        return self.owner[@"name"];
    }
    
    
    return nil;
}

-(NSString *) getOwnerAvatar
{
    if (self.owner[@"avatar"])
    {
        return self.owner[@"avatar"];
    }
    
    
    return nil;
}

-(NSString *) getOwnerUid
{
    if (self.owner[@"uid"])
    {
        return self.owner[@"uid"];
    }
    
    
    return nil;
}

@end
