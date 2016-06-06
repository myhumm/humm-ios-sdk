//
//  OthersAPI.m
//  wrapper
//
//  Created by Jose Alonso García on 2/12/15.
//  Copyright © 2015 humm. All rights reserved.
//

#import "OthersAPI.h"
#import "AFHTTPRequestOperationManager.h"

@interface OthersAPI()

@property (nonatomic, strong) HummAPI *humm;


@end
@implementation OthersAPI

-(id) init
{
    
    self = [super init];
    
    if (self) {
        self.humm = [HummAPI sharedManager];
    }
    
    return self;
}

-(void) radio:(NSArray *) genres
        moods:(NSArray *) moods
    discovery:(BOOL) discovery
        limit:(NSInteger) limit
          own:(BOOL) own
      success:(void (^) (NSArray<Song *> *response)) success
        error:(void (^) (NSError *error)) error

{
    [self setNetworkActivityIndicatorVisible:YES];
    [self.humm updateUserToken:^{
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        manager.responseSerializer =[AFJSONResponseSerializer serializer];
        
        NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
        
        [manager.requestSerializer setValue:[NSString stringWithFormat:@"%@", self.humm.token ]forHTTPHeaderField:@"Authorization"];
        
        
        if (limit > 0)
        {
            [parameters setObject:[NSNumber numberWithInteger:limit] forKey:@"limit"];
        }
        
        if (genres)
        {
            [parameters setObject:genres forKey:@"genres"];
        }
        
        if (moods)
        {
            [parameters setObject:moods forKey:@"moods"];
        }
        
        [parameters setObject:[NSNumber numberWithBool:discovery ] forKey:@"discovery"];
        [parameters setObject:[NSNumber numberWithBool:own ] forKey:@"own"];
        
        [manager GET:[NSString stringWithFormat:@"%@/radio", self.humm.endPoint]
          parameters:parameters
             success:^(AFHTTPRequestOperation *operation, id responseObject) {
                 [self setNetworkActivityIndicatorVisible:NO];
                 if (!responseObject)
                 {
                     success (nil);
                     return ;
                 }
                 
                 if ([@"ok" isEqualToString:responseObject[@"status_response"]])
                 {
                     
                     NSError *err;
                     
                     NSArray<Song *> *songs = [Song arrayOfModelsFromDictionaries:responseObject[@"data_response"] error:&err];
                     
                     if (err)
                     {
                         error([NSError errorWithDomain:@"hummDomain" code:100 userInfo:nil]);
                     }
                     
                     success(songs);
                 }
                 else {
                     error([NSError errorWithDomain:@"hummDomain" code:100 userInfo:responseObject[@"data_response"]]);
                 }
                 
             } failure:^(AFHTTPRequestOperation *operation, NSError *e) {
                 [self setNetworkActivityIndicatorVisible:NO];
                 NSLog(@"error = %@", [e localizedDescription]);
                 error(e);
             }];
        
        
    } onUpdatedError:^(NSError *e) {
        [self setNetworkActivityIndicatorVisible:NO];
        NSLog(@"error = %@", [e localizedDescription]);
        error(e);
    }];
    
    
}

-(void) weeklyPlaylist:(void (^) (NSArray<Song *> *response)) success
                 error:(void (^) (NSError *error)) error

{
    [self setNetworkActivityIndicatorVisible:YES];
    [self.humm updateUserToken:^{
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        manager.responseSerializer =[AFJSONResponseSerializer serializer];
        
        NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
        
        [manager.requestSerializer setValue:[NSString stringWithFormat:@"%@", self.humm.token ]forHTTPHeaderField:@"Authorization"];
        
        
        [parameters setObject:[NSNumber numberWithBool:YES ] forKey:@"weekly"];
        
        [manager GET:[NSString stringWithFormat:@"%@/radio", self.humm.endPoint]
          parameters:parameters
             success:^(AFHTTPRequestOperation *operation, id responseObject) {
                 [self setNetworkActivityIndicatorVisible:NO];
                 if (!responseObject)
                 {
                     success (nil);
                     return ;
                 }
                 
                 if ([@"ok" isEqualToString:responseObject[@"status_response"]])
                 {
                     
                     NSError *err;
                     
                     NSArray<Song *> *songs = [Song arrayOfModelsFromDictionaries:responseObject[@"data_response"] error:&err];
                     
                     if (err)
                     {
                         error([NSError errorWithDomain:@"hummDomain" code:100 userInfo:nil]);
                     }
                     
                     success(songs);
                 }
                 else {
                     error([NSError errorWithDomain:@"hummDomain" code:100 userInfo:responseObject[@"data_response"]]);
                 }
                 
             } failure:^(AFHTTPRequestOperation *operation, NSError *e) {
                 [self setNetworkActivityIndicatorVisible:NO];
                 NSLog(@"error = %@", [e localizedDescription]);
                 error(e);
             }];
        
        
    } onUpdatedError:^(NSError *e) {
        [self setNetworkActivityIndicatorVisible:NO];
        NSLog(@"error = %@", [e localizedDescription]);
        error(e);
    }];
    
    
}


@end
