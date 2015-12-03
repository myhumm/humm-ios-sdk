//
//  LoginInfo.m
//  wrapper
//
//  Created by Jose Alonso García on 30/11/15.
//  Copyright © 2015 humm. All rights reserved.
//

#import "LoginInfo.h"

@implementation LoginInfo


+(BOOL)propertyIsOptional:(NSString*)propertyName
{
    if([propertyName isEqualToString:@"scope"])
        return YES;
    
    return NO;
}

@end
