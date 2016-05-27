//
//  SongsAPI.m
//  wrapper
//
//  Created by Jose Alonso García on 1/12/15.
//  Copyright © 2015 humm. All rights reserved.
//

#import "SongsAPI.h"
#import "AFHTTPRequestOperationManager.h"

@interface SongsAPI()

@property (nonatomic, strong) HummAPI *humm;


@end


@implementation SongsAPI

-(id) init
{
    
    self = [super init];
    
    if (self) {
        self.humm = [HummAPI sharedManager];
    }
    
    return self;
    
}


-(void) featuredWithGenre:(NSString *) genre
                    limit:(NSInteger) limit
                   offset:(NSInteger) offset
                  success:(void (^) (NSArray<Song *> *response)) success
                    error:(void (^) (NSError *error)) error
{
    [self.humm updateUserToken:^{
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        manager.responseSerializer =[AFJSONResponseSerializer serializer];
        
        [manager.requestSerializer setValue:[NSString stringWithFormat:@"%@", self.humm.token ]forHTTPHeaderField:@"Authorization"];
        
        NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
        
        
        if (genre)
        {
            [parameters setObject:genre forKey:@"genre"];
        }
        
        
        if (limit > 0)
        {
            [parameters setObject:[NSNumber numberWithInteger:limit] forKey:@"limit"];
        }
        
        if (offset > 0)
        {
            [parameters setObject:[NSNumber numberWithInteger:offset] forKey:@"offset"];
        }
        
        [manager GET:[NSString stringWithFormat:@"%@/songs/featured", self.humm.endPoint]
          parameters:parameters
             success:^(AFHTTPRequestOperation *operation, id responseObject) {
                 
                 if (!responseObject)
                 {
                     success(nil);
                     return ;
                 }
                 if ([@"ok" isEqualToString:responseObject[@"status_response"]])
                 {
                     NSError *error;
                     NSArray<Song *> *songs = [Song arrayOfModelsFromDictionaries:responseObject[@"data_response"] error:&error];
                     
                     if (error)
                     {
                         NSLog(@"Error = %@", [error localizedDescription]);
                     }
                     
                     
                     success(songs);
                 }
                 else {
                     error([NSError errorWithDomain:@"hummDomain" code:100 userInfo:responseObject[@"data_response"]]);
                 }
                 
             } failure:^(AFHTTPRequestOperation *operation, NSError *e) {
                 NSLog(@"error = %@", [e localizedDescription]);
                 error(e);
             }];
        
    } onUpdatedError:^(NSError *e) {
        NSLog(@"error = %@", [e localizedDescription]);
        error(e);
        
    }];
    
    
}

-(void) popularWithGenre:(NSString *) genre
                   limit:(NSInteger) limit
                  offset:(NSInteger) offset
                 success:(void (^) (NSArray<Song *> *response)) success
                   error:(void (^) (NSError *error)) error
{
    [self.humm updateUserToken:^{
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        manager.responseSerializer =[AFJSONResponseSerializer serializer];
        
        [manager.requestSerializer setValue:[NSString stringWithFormat:@"%@", self.humm.token ]forHTTPHeaderField:@"Authorization"];
        
        NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
        
        
        if (genre)
        {
            [parameters setObject:genre forKey:@"genre"];
        }
        
        
        if (limit > 0)
        {
            [parameters setObject:[NSNumber numberWithInteger:limit] forKey:@"limit"];
        }
        
        if (offset > 0)
        {
            [parameters setObject:[NSNumber numberWithInteger:offset] forKey:@"offset"];
        }
        
        [manager GET:[NSString stringWithFormat:@"%@/songs/popular", self.humm.endPoint]
          parameters:parameters
             success:^(AFHTTPRequestOperation *operation, id responseObject) {
                 
                 if (!responseObject)
                 {
                     success(nil);
                     return ;
                 }
                 if ([@"ok" isEqualToString:responseObject[@"status_response"]])
                 {
                     NSError *error;
                     NSArray<Song *> *songs = [Song arrayOfModelsFromDictionaries:responseObject[@"data_response"] error:&error];
                     
                     if (error)
                     {
                         NSLog(@"Error = %@", [error localizedDescription]);
                     }
                     
                     success(songs);
                 }
                 else {
                     error([NSError errorWithDomain:@"hummDomain" code:100 userInfo:responseObject[@"data_response"]]);
                 }
                 
             } failure:^(AFHTTPRequestOperation *operation, NSError *e) {
                 NSLog(@"error = %@", [e localizedDescription]);
                 error(e);
             }];
        
    } onUpdatedError:^(NSError *e) {
        NSLog(@"error = %@", [e localizedDescription]);
        error(e);
    }];
    
    
}

-(void) recentWithGenre:(NSString *) genre
                  limit:(NSInteger) limit
                 offset:(NSInteger) offset
                success:(void (^) (NSArray<Song *> *response)) success
                  error:(void (^) (NSError *error)) error
{
    [self.humm updateUserToken:^{
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        manager.responseSerializer =[AFJSONResponseSerializer serializer];
        
        [manager.requestSerializer setValue:[NSString stringWithFormat:@"%@", self.humm.token ]forHTTPHeaderField:@"Authorization"];
        
        NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
        
        
        if (genre)
        {
            [parameters setObject:genre forKey:@"genre"];
        }
        
        
        if (limit > 0)
        {
            [parameters setObject:[NSNumber numberWithInteger:limit] forKey:@"limit"];
        }
        
        if (offset > 0)
        {
            [parameters setObject:[NSNumber numberWithInteger:offset] forKey:@"offset"];
        }
        
        [manager GET:[NSString stringWithFormat:@"%@/songs/recent", self.humm.endPoint]
          parameters:parameters
             success:^(AFHTTPRequestOperation *operation, id responseObject) {
                 
                 if (!responseObject)
                 {
                     success(nil);
                     return ;
                 }
                 if ([@"ok" isEqualToString:responseObject[@"status_response"]])
                 {
                     NSError *error;
                     NSArray<Song *> *songs = [Song arrayOfModelsFromDictionaries:responseObject[@"data_response"] error:&error];
                     
                     if (error)
                     {
                         NSLog(@"Error = %@", [error localizedDescription]);
                     }
                     
                     success(songs);
                 }
                 else {
                     error([NSError errorWithDomain:@"hummDomain" code:100 userInfo:responseObject[@"data_response"]]);
                 }
                 
             } failure:^(AFHTTPRequestOperation *operation, NSError *e) {
                 NSLog(@"error = %@", [e localizedDescription]);
                 error(e);
             }];
        
    } onUpdatedError:^(NSError *e) {
        NSLog(@"error = %@", [e localizedDescription]);
        error(e);
        
    }];
    
    
}

-(void) appearsIn:(NSString *) idSong
            limit:(NSInteger) limit
          success:(void (^) (NSArray<Playlist *> *response)) success
            error:(void (^) (NSError *error)) error
{
    [self.humm updateUserToken:^{
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        manager.responseSerializer =[AFJSONResponseSerializer serializer];
        
        [manager.requestSerializer setValue:[NSString stringWithFormat:@"%@", self.humm.token ]forHTTPHeaderField:@"Authorization"];
        
        NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
        
        
        if (!idSong)
        {
            error([NSError errorWithDomain:@"hummDomain" code:100 userInfo:nil]);
        }
        
        
        if (limit > 0)
        {
            [parameters setObject:[NSNumber numberWithInteger:limit] forKey:@"limit"];
        }
        
        
        [manager GET:[NSString stringWithFormat:@"%@/songs/%@/appearsin", self.humm.endPoint, idSong]
          parameters:parameters
             success:^(AFHTTPRequestOperation *operation, id responseObject) {
                 
                 if (!responseObject)
                 {
                     success(nil);
                     return ;
                 }
                 if ([@"ok" isEqualToString:responseObject[@"status_response"]])
                 {
                     NSError *error;
                     NSArray<Playlist *> *songs = [Playlist arrayOfModelsFromDictionaries:responseObject[@"data_response"] error:&error];
                     
                     if (error)
                     {
                         NSLog(@"Error = %@", [error localizedDescription]);
                     }
                     
                     success(songs);
                 }
                 else {
                     error([NSError errorWithDomain:@"hummDomain" code:100 userInfo:responseObject[@"data_response"]]);
                 }
                 
             } failure:^(AFHTTPRequestOperation *operation, NSError *e) {
                 NSLog(@"error = %@", [e localizedDescription]);
                 error(e);
             }];
        
    } onUpdatedError:^(NSError *e) {
        NSLog(@"error = %@", [e localizedDescription]);
        error(e);
    }];
    
    
    
}

-(void) get:(NSString *) idSong
    success:(void (^) ( Song *response)) success
      error:(void (^) (NSError *error)) error
{
    [self.humm updateUserToken:^{
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        manager.responseSerializer =[AFJSONResponseSerializer serializer];
        
        [manager.requestSerializer setValue:[NSString stringWithFormat:@"%@", self.humm.token ]forHTTPHeaderField:@"Authorization"];
        
        NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
        
        
        if (!idSong)
        {
            error([NSError errorWithDomain:@"hummDomain" code:100 userInfo:nil]);
        }
        
        
        
        [manager GET:[NSString stringWithFormat:@"%@/songs/%@", self.humm.endPoint, idSong]
          parameters:parameters
             success:^(AFHTTPRequestOperation *operation, id responseObject) {
                 
                 if (!responseObject)
                 {
                     success(nil);
                     return ;
                 }
                 if ([@"ok" isEqualToString:responseObject[@"status_response"]])
                 {
                     NSError *error;
                     Song *song = [[Song alloc] initWithDictionary:responseObject[@"data_response"] error:&error];
                     success(song);
                 }
                 else {
                     error([NSError errorWithDomain:@"hummDomain" code:100 userInfo:responseObject[@"data_response"]]);
                 }
                 
             } failure:^(AFHTTPRequestOperation *operation, NSError *e) {
                 NSLog(@"error = %@", [e localizedDescription]);
                 error(e);
             }];
        
    } onUpdatedError:^(NSError *e) {
        NSLog(@"error = %@", [e localizedDescription]);
        error(e);
    }];
    ;
    
    
}

-(void) getSimilar:(NSString *) idSong
             limit:(NSInteger) limit
            offset:(NSInteger) offset
           success:(void (^) ( NSArray<Song *>  *response)) success
             error:(void (^) (NSError *error)) error
{
    [self.humm updateUserToken:^{
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        manager.responseSerializer =[AFJSONResponseSerializer serializer];
        
        [manager.requestSerializer setValue:[NSString stringWithFormat:@"%@", self.humm.token ]forHTTPHeaderField:@"Authorization"];
        
        NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
        
        
        if (!idSong)
        {
            error([NSError errorWithDomain:@"hummDomain" code:100 userInfo:nil]);
        }
        
        if (limit > 0)
        {
            [parameters setObject:[NSNumber numberWithInteger:limit] forKey:@"limit"];
        }
        
        if (offset > 0)
        {
            [parameters setObject:[NSNumber numberWithInteger:offset] forKey:@"offset"];
        }
        
        
        [manager GET:[NSString stringWithFormat:@"%@/songs/%@/similar", self.humm.endPoint, idSong]
          parameters:parameters
             success:^(AFHTTPRequestOperation *operation, id responseObject) {
                 
                 if (!responseObject)
                 {
                     success(nil);
                     return ;
                 }
                 if ([@"ok" isEqualToString:responseObject[@"status_response"]])
                 {
                     NSError *error;
                     NSArray<Song *> *songs = [Song arrayOfModelsFromDictionaries:responseObject[@"data_response"] error:&error];
                     success(songs);
                 }
                 else {
                     error([NSError errorWithDomain:@"hummDomain" code:100 userInfo:responseObject[@"data_response"]]);
                 }
                 
             } failure:^(AFHTTPRequestOperation *operation, NSError *e) {
                 NSLog(@"error = %@", [e localizedDescription]);
                 error(e);
             }];
        
    } onUpdatedError:^(NSError *e) {
        NSLog(@"error = %@", [e localizedDescription]);
        error(e);
    }];
    ;
    
    
}



-(void) searchWithKeyword:(NSString *) keyword
                    limit:(NSInteger) limit
                   offset:(NSInteger) offset
                    genre:(NSString *) genre
                  success:(void (^) (NSArray<Song *> *response)) success
                    error:(void (^) (NSError *error)) error
{
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer =[AFJSONResponseSerializer serializer];
    
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    
    [self.humm updateUserToken:^{
        [manager.requestSerializer setValue:[NSString stringWithFormat:@"%@", self.humm.token ]forHTTPHeaderField:@"Authorization"];
        
        if (!keyword)
        {
            error([NSError errorWithDomain:@"hummDomain" code:100 userInfo:nil]);
        }
        
        [parameters setObject:keyword forKey:@"keyword"];
        
        if (limit > 0)
        {
            [parameters setObject:[NSNumber numberWithInteger:limit] forKey:@"limit"];
        }
        
        if (offset > 0)
        {
            [parameters setObject:[NSNumber numberWithInteger:offset] forKey:@"offset"];
        }
        
        if (genre)
        {
            [parameters setObject:genre forKey:@"genre"];

        }
        
        
        [manager GET:[NSString stringWithFormat:@"%@/songs", self.humm.endPoint]
          parameters:parameters
             success:^(AFHTTPRequestOperation *operation, id responseObject) {
                 
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
                 NSLog(@"error = %@", [e localizedDescription]);
                 error(e);
             }];
        
    } onUpdatedError:^(NSError *e) {
        NSLog(@"error = %@", [e localizedDescription]);
        error(e);
        
    }];
    
    
    
}


@end
