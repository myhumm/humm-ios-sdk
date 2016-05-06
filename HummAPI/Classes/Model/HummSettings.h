//
//  Settings.h
//  Pods
//
//  Created by Jose Alonso García on 5/5/16.
//
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"

@interface HummSettings : JSONModel
@property (nonatomic, strong) NSDictionary *stats;
@property (nonatomic, strong) NSDictionary *account;
@property (nonatomic, strong) NSArray *services;

@end
