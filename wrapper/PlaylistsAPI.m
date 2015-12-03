//
//  PlaylistsAPI.m
//  wrapper
//
//  Created by Jose Alonso García on 1/12/15.
//  Copyright © 2015 humm. All rights reserved.
//

#import "PlaylistsAPI.h"
#import "AFHTTPRequestOperationManager.h"


@interface PlaylistsAPI()

@property (nonatomic, strong) HummAPI *humm;

@end

@implementation PlaylistsAPI

-(id) init
{
    
    self = [super init];
    
    if (self) {
        self.humm = [HummAPI sharedManager];
    }
    
    return self;
}


-(void) create:(NSString *) description
       private:(BOOL) private
         title:(NSString *) title
       success:(void (^) (Playlist *response)) success
         error:(void (^) (NSError *error)) error
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer =[AFJSONResponseSerializer serializer];
    
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    
    if ((!description) || (!title))
    {
        error([NSError errorWithDomain:@"hummDomain" code:100 userInfo:nil]);
    }
    
    [parameters setObject:description forKey:@"description"];
    [parameters setObject:title forKey:@"title"];

    [parameters setObject:[NSNumber numberWithBool:private] forKey:@"private"];
    
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"%@", self.humm.token ]forHTTPHeaderField:@"Authorization"];
    
    [manager POST:[NSString stringWithFormat:@"%@/playlists", self.humm.endPoint]
       parameters:parameters
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              
              if ([@"ok" isEqualToString:responseObject[@"status_response"]])
              {
                  
                  NSError *err;
                  Playlist *playlist = [[Playlist alloc] initWithDictionary:responseObject[@"data_response"] error:&err];
                  
                  if (err)
                  {
                      error([NSError errorWithDomain:@"hummDomain" code:100 userInfo:nil]);
                  }
                  
                  success(playlist);
              }
              else {
                  error([NSError errorWithDomain:@"hummDomain" code:100 userInfo:responseObject[@"data_response"]]);
              }
              
          } failure:^(AFHTTPRequestOperation *operation, NSError *e) {
              NSLog(@"error = %@", [e localizedDescription]);
              error(e);
          }];
    
}

-(void) getFeaturedWithLimit:(NSInteger) limit
                      offset:(NSInteger) offset
                     success:(void (^) (NSArray<Playlist *> *response)) success
                       error:(void (^) (NSError *error)) error
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer =[AFJSONResponseSerializer serializer];
    
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    
    if (limit > 0)
    {
        [parameters setObject:[NSNumber numberWithInteger:limit] forKey:@"limit"];
    }
    
    if (offset > 0)
    {
        [parameters setObject:[NSNumber numberWithInteger:offset] forKey:@"offset"];
    }
    
    
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"%@", self.humm.token ]forHTTPHeaderField:@"Authorization"];
    
    [manager GET:[NSString stringWithFormat:@"%@/playlists/featured", self.humm.endPoint]
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
                 
                 NSArray<Playlist *> *playlists = [Playlist arrayOfModelsFromDictionaries:responseObject[@"data_response"] error:&err];
                 
                 if (err)
                 {
                     error([NSError errorWithDomain:@"hummDomain" code:100 userInfo:nil]);
                 }
                 
                 success(playlists);
             }
             else {
                 error([NSError errorWithDomain:@"hummDomain" code:100 userInfo:responseObject[@"data_response"]]);
             }
             
         } failure:^(AFHTTPRequestOperation *operation, NSError *e) {
             NSLog(@"error = %@", [e localizedDescription]);
             error(e);
         }];
    
}

-(void) get:(NSString *) idPlaylist
    success:(void (^) (Playlist *response)) success
      error:(void (^) (NSError *error)) error
{
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer =[AFJSONResponseSerializer serializer];
    
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    
    [self.humm updateUserToken];
    
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"%@", self.humm.token ]forHTTPHeaderField:@"Authorization"];
    
    if (!idPlaylist)
    {
        error([NSError errorWithDomain:@"hummDomain" code:100 userInfo:nil]);
    }
    
    
    [manager GET:[NSString stringWithFormat:@"%@/playlists/%@", self.humm.endPoint, idPlaylist]
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
                 
                 Playlist *playlist = [[Playlist alloc] initWithDictionary:responseObject[@"data_response"] error:&err];
                 
                 if (err)
                 {
                     error([NSError errorWithDomain:@"hummDomain" code:100 userInfo:nil]);
                 }
                 
                 success(playlist);
             }
             else {
                 error([NSError errorWithDomain:@"hummDomain" code:100 userInfo:responseObject[@"data_response"]]);
             }
             
         } failure:^(AFHTTPRequestOperation *operation, NSError *e) {
             NSLog(@"error = %@", [e localizedDescription]);
             error(e);
         }];
    
}


-(void) update:(NSString *) idPlaylist
   description:(NSString *) description
       private:(BOOL) private
         title:(NSString *) title
       success:(void (^) (Playlist *response)) success
         error:(void (^) (NSError *error)) error
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer =[AFJSONResponseSerializer serializer];
    
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    
    if ((!description) || (!title) || (!idPlaylist))
    {
        error([NSError errorWithDomain:@"hummDomain" code:100 userInfo:nil]);
    }
    
    
    [parameters setObject:description forKey:@"description"];
    [parameters setObject:title forKey:@"title"];
    [parameters setObject:[NSNumber numberWithBool:private] forKey:@"private"];
    
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"%@", self.humm.token ]forHTTPHeaderField:@"Authorization"];
    
    [manager PATCH:[NSString stringWithFormat:@"%@/playlists/%@", self.humm.endPoint, idPlaylist]
      parameters:parameters
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             
             if ([@"ok" isEqualToString:responseObject[@"status_response"]])
             {
                 
                 NSError *err;
                 Playlist *playlist = [[Playlist alloc] initWithDictionary:responseObject[@"data_response"] error:&err];
                 
                 if (err)
                 {
                     error([NSError errorWithDomain:@"hummDomain" code:100 userInfo:nil]);
                 }
                 
                 success(playlist);
             }
             else {
                 error([NSError errorWithDomain:@"hummDomain" code:100 userInfo:responseObject[@"data_response"]]);
             }
             
         } failure:^(AFHTTPRequestOperation *operation, NSError *e) {
             NSLog(@"error = %@", [e localizedDescription]);
             error(e);
         }];
    
}

-(void) order:(NSString *) idPlaylist
 songsOrdered: (NSArray *) songs
      success:(void (^) (Playlist *response)) success
        error:(void (^) (NSError *error)) error
{
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer =[AFJSONResponseSerializer serializer];
    
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    
    [self.humm updateUserToken];
    
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"%@", self.humm.token ]forHTTPHeaderField:@"Authorization"];
    
    if ((!idPlaylist) || (!songs))
    {
        error([NSError errorWithDomain:@"hummDomain" code:100 userInfo:nil]);
    }
    
    
    [parameters setObject:songs forKey:@"songs"];
    
    [manager PATCH:[NSString stringWithFormat:@"%@/playlists/%@/reorder", self.humm.endPoint, idPlaylist]
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
                 
                 Playlist *playlist = [[Playlist alloc] initWithDictionary:responseObject[@"data_response"] error:&err];
                 
                 if (err)
                 {
                     error([NSError errorWithDomain:@"hummDomain" code:100 userInfo:nil]);
                 }
                 
                 success(playlist);
             }
             else {
                 error([NSError errorWithDomain:@"hummDomain" code:100 userInfo:responseObject[@"data_response"]]);
             }
             
         } failure:^(AFHTTPRequestOperation *operation, NSError *e) {
             NSLog(@"error = %@", [e localizedDescription]);
             error(e);
         }];
    
}

-(void) getSongs:(NSString *) idPlaylist
           limit:(NSInteger) limit
          offset:(NSInteger) offset
         success:(void (^) (NSArray<Song *> *response)) success
           error:(void (^) (NSError *error)) error
{
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer =[AFJSONResponseSerializer serializer];
    
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    
    [self.humm updateUserToken];
    
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"%@", self.humm.token ]forHTTPHeaderField:@"Authorization"];
    
    if (!idPlaylist)
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
    
    
    [manager GET:[NSString stringWithFormat:@"%@/playlists/%@/songs", self.humm.endPoint, idPlaylist]
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
    
}

-(void) addSong:(NSString *) idPlaylist
       position:(NSInteger) position
         idSong:(NSString *) idSong
        success:(void (^) (Playlist *response)) success
          error:(void (^) (NSError *error)) error
{
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer =[AFJSONResponseSerializer serializer];
    
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    
    [self.humm updateUserToken];
    
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"%@", self.humm.token ]forHTTPHeaderField:@"Authorization"];
    
    if ((!idPlaylist) || (!idSong))
    {
        error([NSError errorWithDomain:@"hummDomain" code:100 userInfo:nil]);
    }
    
    [parameters setObject:idSong forKey:@"sid"];
    
    if (position >= 0)
    {
        [parameters setObject:[NSNumber numberWithInteger:position] forKey:@"offset"];
    }
    
    [manager POST:[NSString stringWithFormat:@"%@/playlists/%@/songs", self.humm.endPoint, idPlaylist]
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
                  
                  Playlist *playlist = [[Playlist alloc] initWithDictionary:responseObject[@"data_response"] error:&err];
                  
                  if (err)
                  {
                      error([NSError errorWithDomain:@"hummDomain" code:100 userInfo:nil]);
                  }
                  
                  success(playlist);
              }
              else {
                  error([NSError errorWithDomain:@"hummDomain" code:100 userInfo:responseObject[@"data_response"]]);
              }
              
          } failure:^(AFHTTPRequestOperation *operation, NSError *e) {
              NSLog(@"error = %@", [e localizedDescription]);
              error(e);
          }];
    
}

-(void) removeSong:(NSString *) idPlaylist
            idSong:(NSString *) idSong
           success:(void (^) (Playlist *response)) success
             error:(void (^) (NSError *error)) error
{
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer =[AFJSONResponseSerializer serializer];
    
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    
    [self.humm updateUserToken];
    
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"%@", self.humm.token ]forHTTPHeaderField:@"Authorization"];
    
    if ((!idPlaylist) || (!idSong))
    {
        error([NSError errorWithDomain:@"hummDomain" code:100 userInfo:nil]);
    }
    
    [parameters setObject:idSong forKey:@"sid"];
    
    [manager DELETE:[NSString stringWithFormat:@"%@/playlists/%@/songs", self.humm.endPoint, idPlaylist]
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
                    
                    Playlist *playlist = [[Playlist alloc] initWithDictionary:responseObject[@"data_response"] error:&err];
                    
                    if (err)
                    {
                        error([NSError errorWithDomain:@"hummDomain" code:100 userInfo:nil]);
                    }
                    
                    success(playlist);
                }
                else {
                    error([NSError errorWithDomain:@"hummDomain" code:100 userInfo:responseObject[@"data_response"]]);
                }
                
            } failure:^(AFHTTPRequestOperation *operation, NSError *e) {
                NSLog(@"error = %@", [e localizedDescription]);
                error(e);
            }];
    
}

-(void) addSubscriber:(NSString *) idPlaylist
        success:(void (^) (Playlist *response)) success
          error:(void (^) (NSError *error)) error
{
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer =[AFJSONResponseSerializer serializer];
    
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    
    [self.humm updateUserToken];
    
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"%@", self.humm.token ]forHTTPHeaderField:@"Authorization"];
    
    if (!idPlaylist)
    {
        error([NSError errorWithDomain:@"hummDomain" code:100 userInfo:nil]);
    }
    
    
    [manager POST:[NSString stringWithFormat:@"%@/playlists/%@/subscribers", self.humm.endPoint, idPlaylist]
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
                  
                  Playlist *playlist = [[Playlist alloc] initWithDictionary:responseObject[@"data_response"] error:&err];
                  
                  if (err)
                  {
                      error([NSError errorWithDomain:@"hummDomain" code:100 userInfo:nil]);
                  }
                  
                  success(playlist);
              }
              else {
                  error([NSError errorWithDomain:@"hummDomain" code:100 userInfo:responseObject[@"data_response"]]);
              }
              
          } failure:^(AFHTTPRequestOperation *operation, NSError *e) {
              NSLog(@"error = %@", [e localizedDescription]);
              error(e);
          }];
    
}

-(void) removeSubscriber:(NSString *) idPlaylist
           success:(void (^) (Playlist *response)) success
             error:(void (^) (NSError *error)) error
{
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer =[AFJSONResponseSerializer serializer];
    
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    
    [self.humm updateUserToken];
    
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"%@", self.humm.token ]forHTTPHeaderField:@"Authorization"];
    
    if (!idPlaylist)
    {
        error([NSError errorWithDomain:@"hummDomain" code:100 userInfo:nil]);
    }
        
    [manager DELETE:[NSString stringWithFormat:@"%@/playlists/%@/subscribers", self.humm.endPoint, idPlaylist]
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
                    
                    Playlist *playlist = [[Playlist alloc] initWithDictionary:responseObject[@"data_response"] error:&err];
                    
                    if (err)
                    {
                        error([NSError errorWithDomain:@"hummDomain" code:100 userInfo:nil]);
                    }
                    
                    success(playlist);
                }
                else {
                    error([NSError errorWithDomain:@"hummDomain" code:100 userInfo:responseObject[@"data_response"]]);
                }
                
            } failure:^(AFHTTPRequestOperation *operation, NSError *e) {
                NSLog(@"error = %@", [e localizedDescription]);
                error(e);
            }];
    
}

-(void) getPopularWithLimit:(NSInteger) limit
          offset:(NSInteger) offset
                  selection:(NSString *)selection
                     idUser:(NSString *) idUser
         success:(void (^) (NSArray<Playlist *> *response)) success
           error:(void (^) (NSError *error)) error
{
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer =[AFJSONResponseSerializer serializer];
    
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    
    [self.humm updateUserToken];
    
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"%@", self.humm.token ]forHTTPHeaderField:@"Authorization"];
    
    if (limit > 0)
    {
        [parameters setObject:[NSNumber numberWithInteger:limit] forKey:@"limit"];
    }
    
    if (offset > 0)
    {
        [parameters setObject:[NSNumber numberWithInteger:offset] forKey:@"offset"];
    }
    
    if (selection)
    {
        [parameters setObject:selection forKey:@"selection"];
    }
    
    if (idUser)
    {
        [parameters setObject:idUser forKey:@"uid"];
    }
    
    
    [manager GET:[NSString stringWithFormat:@"%@/playlists/popular", self.humm.endPoint]
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
                 
                 NSArray<Playlist *> *playlists = [Playlist arrayOfModelsFromDictionaries:responseObject[@"data_response"] error:&err];
                 
                 if (err)
                 {
                     error([NSError errorWithDomain:@"hummDomain" code:100 userInfo:nil]);
                 }
                 
                 success(playlists);
             }
             else {
                 error([NSError errorWithDomain:@"hummDomain" code:100 userInfo:responseObject[@"data_response"]]);
             }
             
         } failure:^(AFHTTPRequestOperation *operation, NSError *e) {
             NSLog(@"error = %@", [e localizedDescription]);
             error(e);
         }];
    
}

-(void) getRecentWithLimit:(NSInteger) limit
                     offset:(NSInteger) offset
                    success:(void (^) (NSArray<Playlist *> *response)) success
                      error:(void (^) (NSError *error)) error
{
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer =[AFJSONResponseSerializer serializer];
    
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    
    [self.humm updateUserToken];
    
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"%@", self.humm.token ]forHTTPHeaderField:@"Authorization"];
    
    if (limit > 0)
    {
        [parameters setObject:[NSNumber numberWithInteger:limit] forKey:@"limit"];
    }
    
    if (offset > 0)
    {
        [parameters setObject:[NSNumber numberWithInteger:offset] forKey:@"offset"];
    }
    
    
    [manager GET:[NSString stringWithFormat:@"%@/playlists/recent", self.humm.endPoint]
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
                 
                 NSArray<Playlist *> *playlists = [Playlist arrayOfModelsFromDictionaries:responseObject[@"data_response"] error:&err];
                 
                 if (err)
                 {
                     error([NSError errorWithDomain:@"hummDomain" code:100 userInfo:nil]);
                 }
                 
                 success(playlists);
             }
             else {
                 error([NSError errorWithDomain:@"hummDomain" code:100 userInfo:responseObject[@"data_response"]]);
             }
             
         } failure:^(AFHTTPRequestOperation *operation, NSError *e) {
             NSLog(@"error = %@", [e localizedDescription]);
             error(e);
         }];
    
}

-(void) searchWithKeyword:(NSString *) keyword
                    limit:(NSInteger) limit
                    offset:(NSInteger) offset
                    album:(BOOL) album
                   success:(void (^) (NSArray<Playlist *> *response)) success
                     error:(void (^) (NSError *error)) error
{
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer =[AFJSONResponseSerializer serializer];
    
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    
    [self.humm updateUserToken];
    
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
    
    [parameters setObject:[NSNumber numberWithBool:album] forKey:@"album"];

    [manager GET:[NSString stringWithFormat:@"%@/playlists", self.humm.endPoint]
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
                 
                 NSArray<Playlist *> *playlists = [Playlist arrayOfModelsFromDictionaries:responseObject[@"data_response"] error:&err];
                 
                 if (err)
                 {
                     error([NSError errorWithDomain:@"hummDomain" code:100 userInfo:nil]);
                 }
                 
                 success(playlists);
             }
             else {
                 error([NSError errorWithDomain:@"hummDomain" code:100 userInfo:responseObject[@"data_response"]]);
             }
             
         } failure:^(AFHTTPRequestOperation *operation, NSError *e) {
             NSLog(@"error = %@", [e localizedDescription]);
             error(e);
         }];
    
}

@end
