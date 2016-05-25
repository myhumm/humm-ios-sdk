//
//  Subscription.m
//  Pods
//
//  Created by Jose Alonso García on 25/5/16.
//
//

#import "Subscription.h"

@implementation Subscription

#define PLAYLIST_ENDPOINT @"http://wave.livingindietv.com/images/playlist?id=%@&size=thumb"

+(BOOL)propertyIsOptional:(NSString*)propertyName
{
    return YES;
}

- (NSString *) getCover
{
    return [NSString stringWithFormat:PLAYLIST_ENDPOINT, self._id ];
    
}

@end
