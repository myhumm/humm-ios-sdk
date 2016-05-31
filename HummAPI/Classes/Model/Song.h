//
//  Song.h
//  wrapper
//
//  Created by Jose Alonso García on 1/12/15.
//  Copyright © 2015 humm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"

@interface Song : JSONModel

@property (nonatomic, strong) NSString *_id;

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *description;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *date;
@property (nonatomic, strong) NSDictionary *urls;
@property (nonatomic, strong) NSArray *artists;
@property (nonatomic, strong) NSArray *playlists;
@property (nonatomic, strong) NSDictionary *foreign_ids;
@property (nonatomic, strong) NSDictionary *stats;
@property (nonatomic, strong) NSArray *contributors;
@property (nonatomic, strong) NSArray *stories;
@property (nonatomic, strong) NSArray *genres;

-(NSString *) getPlaylists;
-(NSString *) getPopularity;
-(NSString *) getYoutubeURL;
-(NSString *) getYoutubeId;
-(NSString *) getArtistName;
-(NSString *) getYoutubeVideoImage;
-(NSString *) getPlaylistCover;

@end
