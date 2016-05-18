//
//  PlaylistOwnerArray.m
//  Pods
//
//  Created by Jose Alonso García on 18/5/16.
//
//

#import "PlaylistOwnerArray.h"


@implementation PlaylistOwnerArray

-(NSString *) getOwnerName
{
    if ([self.owner isKindOfClass:[NSArray class]])
    {
        if ([self.owner firstObject] && [self.owner firstObject][@"name"])
        {
            return [self.owner firstObject][@"name"];
        }
    }
    
    return nil;
}

-(NSString *) getOwnerAvatar
{
    if ([self.owner isKindOfClass:[NSArray class]])
    {
        if ([self.owner firstObject] && [self.owner firstObject][@"avatar"])
        {
            return [self.owner firstObject][@"avatar"];
        }
    }
    
    return nil;
}

-(NSString *) getOwnerUid
{
    if ([self.owner isKindOfClass:[NSArray class]])
    {
        if ([self.owner firstObject] && [self.owner firstObject][@"uid"])
        {
            return [self.owner firstObject][@"uid"];
        }
    }
    
    return nil;
}

@end
