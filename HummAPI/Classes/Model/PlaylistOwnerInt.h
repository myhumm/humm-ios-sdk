//
//  PlaylistOwnerInt.h
//  Pods
//
//  Created by Jose Alonso García on 18/5/16.
//
//

#import <HummAPI/HummAPI.h>
#import "Playlist.h"

@interface PlaylistOwnerInt : Playlist

@property (nonatomic) NSInteger owner;

-(NSString *) getOwnerName;
-(NSString *) getOwnerAvatar;
-(NSString *) getOwnerUid;

@end
