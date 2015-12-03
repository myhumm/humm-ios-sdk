//
//  Artist.h
//  wrapper
//
//  Created by Jose Alonso García on 30/11/15.
//  Copyright © 2015 humm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"

@interface Artist : JSONModel

@property (nonatomic, strong) NSArray *moods;
@property (nonatomic, strong) NSArray *similar;
@property (nonatomic, strong) NSDictionary *account;
@property (nonatomic, strong) NSDictionary *urls;
//FIXME: API returns two kind of images: array and dictionary.
//@property (nonatomic, strong) NSArray *images;
@property (nonatomic, strong) NSArray *following;
@property (nonatomic, strong) NSDictionary *stats;

-(NSString *) getName;
-(NSString *) getHashtag;
-(NSString *) getYoutubeURL;
-(NSString *) getSpotifyURL;
-(NSString *) getPopularity;
-(NSString *) getPlaylists;
-(NSString *) getAvatar;
-(NSString *) getBio;

@end
