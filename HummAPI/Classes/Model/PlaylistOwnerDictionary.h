//
//  PlaylistOwnerDictionary.h
//  Pods
//
//  Created by Jose Alonso García on 18/5/16.
//
//

#import <HummAPI/HummAPI.h>
#import "Playlist.h"

@interface PlaylistOwnerDictionary : Playlist

@property (nonatomic, strong) NSDictionary* owner;

-(NSString *) getOwnerName;
-(NSString *) getOwnerAvatar;
-(NSString *) getOwnerUid;

@end
