//
//  User.h
//  wrapper
//
//  Created by Jose Alonso García on 1/12/15.
//  Copyright © 2015 humm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"

@interface User : JSONModel

#define SERVICE_TWITTER @"twitter";
#define SERVICE_FACEBOOK @"facebook";

@property (nonatomic, strong) NSString *_id;

@property (nonatomic, strong) NSDictionary *account;
@property (nonatomic, strong) NSDictionary *preferences;
@property (nonatomic, strong) NSDictionary *services;
@property (nonatomic, strong) NSString *signup;
@property (nonatomic, strong) NSString *last_visit;
@property (nonatomic) BOOL featured;

@property (nonatomic, strong) NSArray *played;
@property (nonatomic, strong) NSArray *genres;
@property (nonatomic, strong) NSArray *favourites;
@property (nonatomic, strong) NSArray *following;
@property (nonatomic, strong) NSArray *subscriptions;
@property (nonatomic, strong) NSArray *similar;

-(NSString *) getUserAvatar;
-(NSString *) getUsername;
-(NSArray *) getFavouritesIds;
-(NSString *) getEmail;
-(NSString *) getLastName;
-(NSString *) getFirstName;
-(NSArray *) getSubscriptionsIds;
-(NSArray *) getFollowingIds;

-(NSArray *) getPreferencesDislike;
-(NSArray *) getPreferencesLike;

-(NSDictionary *) getTwitterService;
-(NSDictionary *) getFacebookService;

@end
