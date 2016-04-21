//
//  Playlist.h
//  wrapper
//
//  Created by Jose Alonso García on 1/12/15.
//  Copyright © 2015 humm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"

@interface Playlist : JSONModel

@property (nonatomic, strong) NSString *_id;

@property (nonatomic, strong) NSDictionary *stats;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSArray *contributors;
//owner can be array or dictionary
//@property (nonatomic, strong) NSArray *owner;

@end
