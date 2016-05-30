//
//  PlaylistOwnerInt.h
//  Pods
//
//  Created by Jose Alonso García on 25/5/16.
//
// Aux class to avoid owner field which is returned by server mixed of dictionaries and objects

#import "JSONModel.h"

@interface PlaylistOwnerInt : JSONModel

@property (nonatomic, strong) NSString *_id;

@property (nonatomic, strong) NSDictionary *stats;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSArray *contributors;
@property (nonatomic, strong) NSString *playlistDescription;
@property (nonatomic) BOOL playlistPrivate;


- (NSString *) getCover;


@end
