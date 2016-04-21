//
//  LoginInfo.h
//  wrapper
//
//  Created by Jose Alonso García on 30/11/15.
//  Copyright © 2015 humm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"

@interface LoginInfo : JSONModel

@property (nonatomic, strong) NSString *access_token;
@property (nonatomic, strong) NSString *token_type;
@property (nonatomic, strong) NSString *refresh_token;
@property (nonatomic, strong) NSString *scope;
@property (nonatomic) NSInteger expires_in;

@end
