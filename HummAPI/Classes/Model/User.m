//
//  User.m
//  wrapper
//
//  Created by Jose Alonso García on 1/12/15.
//  Copyright © 2015 humm. All rights reserved.
//

#import "User.h"

@implementation User

+(BOOL)propertyIsOptional:(NSString*)propertyName
{
    return YES;
}


-(NSString *) getUserAvatar {
    if (self.account && self.account[@"uavatar"]) {
        return self.account[@"uavatar"];
    }
    return nil;
    
}

-(NSString *) getUsername {
    return self.account[@"uname"];
}

-(NSArray *) getFavouritesIds {
    NSMutableArray *result = [[NSMutableArray alloc] init];
    
    for (NSDictionary *dictionary in self.favourites)
    {
        [result addObject:dictionary[@"id"]];
    }
    
    return [result copy];
}

-(NSArray *) getFollowingIds {
    NSMutableArray *result = [[NSMutableArray alloc] init];
    
    for (NSDictionary *dictionary in self.following)
    {
        [result addObject:dictionary[@"uid"]];
    }
    
    return [result copy];
}

-(NSArray *) getSubscriptionsIds {
    NSMutableArray *result = [[NSMutableArray alloc] init];
    
    for (NSDictionary *dictionary in self.subscriptions)
    {
        [result addObject:dictionary[@"pid"]];
    }
    
    return [result copy];
}

-(NSString *) getFirstName {
    if (self.account && self.account[@"name"])
    {
        return self.account[@"name"][@"first"];
    }
    return nil;
}

-(NSString *) getLastName {
    if (self.account && self.account[@"name"])
    {
        return self.account[@"name"][@"last"];
    }
    return nil;
}


-(NSString *) getEmail {
    if (self.account && self.account[@"email"])
    {
        return self.account[@"email"];
    }
    return nil;
    
}

-(NSArray *) getPreferencesLike {
    if (self.preferences && self.preferences[@"like"])
    {
        return self.preferences[@"like"];
    }
    return nil;
    
}

-(NSArray *) getPreferencesDislike {
    if (self.preferences && self.preferences[@"dislike"])
    {
        return self.preferences[@"dislike"];
    }
    return nil;
    
}

-(NSDictionary *) getTwitterService {
    
    if (!self.services)
    {
        return nil;
    }
    
    for (NSDictionary* service in self.services) {
        if (service[@"twitter"])
        {
            return service[@"twitter"];
        }
    }
    return nil;
    
}
-(NSDictionary *) getFacebookService {
    
    if (!self.services)
    {
        return nil;
    }
    
    for (NSDictionary* service in self.services) {
        if (service[@"facebook"])
        {
            return service[@"facebook"];
        }
    }

}



@end
