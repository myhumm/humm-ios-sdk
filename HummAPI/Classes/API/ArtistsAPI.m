//
//  ArtistsAPI.m
//  wrapper
//
//  Created by Jose Alonso García on 30/11/15.
//  Copyright © 2015 humm. All rights reserved.
//

#import "ArtistsAPI.h"
#import "AFHTTPRequestOperationManager.h"

@interface ArtistsAPI()

@property (nonatomic, strong) HummAPI *humm;


@end


@implementation ArtistsAPI


-(id) init
{
    
    self = [super init];
    
    if (self) {
        self.humm = [HummAPI sharedManager];
    }
    
    return self;
    
}


-(void) get:(NSString *) idArtist
      limit:(NSInteger) limit
     offset:(NSInteger) offset
    success:(void (^) (Artist *response)) success
      error:(void (^) (NSError *error)) error
{
    [self.humm updateUserToken:^{
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
        
        [manager GET:[NSString stringWithFormat:@"%@/artists/%@", self.humm.endPoint, idArtist]
          parameters:[parameters copy]
             success:^(AFHTTPRequestOperation *operation, id responseObject) {
                 
                 if ([@"ok" isEqualToString:responseObject[@"status_response"]])
                 {
                     NSError* err = nil;
                     Artist *artist = [[Artist alloc] initWithDictionary:responseObject[@"data_response"] error:&err];
                     success(artist);
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

-(void) addFollower:(NSString *) idArtist
            success:(void (^) (Artist *response)) success
              error:(void (^) (NSError *error)) error
{
    
    [self.humm updateUserToken:^{
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        manager.responseSerializer =[AFJSONResponseSerializer serializer];
        
        [manager.requestSerializer setValue:[NSString stringWithFormat:@"%@", self.humm.token ]forHTTPHeaderField:@"Authorization"];
        
        [manager POST:[NSString stringWithFormat:@"%@/artists/%@/followers", self.humm.endPoint, idArtist]
           parameters:nil
              success:^(AFHTTPRequestOperation *operation, id responseObject) {
                  
                  if ([@"ok" isEqualToString:responseObject[@"status_response"]])
                  {
                      NSError* err = nil;
                      Artist *artist = [[Artist alloc] initWithDictionary:responseObject[@"data_response"] error:&err];
                      success(artist);
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

-(void) removeFollower:(NSString *) idArtist
               success:(void (^) (Artist *response)) success
                 error:(void (^) (NSError *error)) error
{
    
    [self.humm updateUserToken:^{
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        manager.responseSerializer =[AFJSONResponseSerializer serializer];
        
        [manager.requestSerializer setValue:[NSString stringWithFormat:@"%@", self.humm.token ]forHTTPHeaderField:@"Authorization"];
        
        [manager DELETE:[NSString stringWithFormat:@"%@/artists/%@/followers", self.humm.endPoint, idArtist]
             parameters:nil
                success:^(AFHTTPRequestOperation *operation, id responseObject) {
                    
                    if ([@"ok" isEqualToString:responseObject[@"status_response"]])
                    {
                        NSError* err = nil;
                        Artist *artist = [[Artist alloc] initWithDictionary:responseObject[@"data_response"] error:&err];
                        success(artist);
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

-(void) getPlaylists:(NSString *) idArtist
               limit:(NSInteger) limit
              offset:(NSInteger) offset
             success:(void (^) (NSArray<Playlist *> *response)) success
               error:(void (^) (NSError *error)) error
{
    
    [self.humm updateUserToken:^{
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        manager.responseSerializer =[AFJSONResponseSerializer serializer];
        
        [manager.requestSerializer setValue:[NSString stringWithFormat:@"%@", self.humm.token ]forHTTPHeaderField:@"Authorization"];
        
        NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
        
        if (limit > 0)
        {
            [parameters setObject:[NSNumber numberWithInteger:limit] forKey:@"limit"];
        }
        
        if (offset > 0)
        {
            [parameters setObject:[NSNumber numberWithInteger:offset] forKey:@"offset"];
        }
        
        
        [manager GET:[NSString stringWithFormat:@"%@/artists/%@/playlists", self.humm.endPoint, idArtist]
          parameters:parameters
             success:^(AFHTTPRequestOperation *operation, id responseObject) {
                 
                 if ([@"ok" isEqualToString:responseObject[@"status_response"]])
                 {
                     NSError *error;
                     NSArray<Playlist *> *playlists = [Playlist arrayOfModelsFromDictionaries:responseObject[@"data_response"] error:&error];
                     
                     if (error)
                     {
                         NSLog(@"Error = %@", [error localizedDescription]);
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
        
    } onUpdatedError:^(NSError *e) {
        NSLog(@"error = %@", [e localizedDescription]);
        error(e);
        
    }];
    ;
    
    
}

-(void) getRadio:(NSString *) idArtist
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
        
        if (limit > 0)
        {
            [parameters setObject:[NSNumber numberWithInteger:limit] forKey:@"limit"];
        }
        
        if (offset > 0)
        {
            [parameters setObject:[NSNumber numberWithInteger:offset] forKey:@"offset"];
        }
        
        
        [manager GET:[NSString stringWithFormat:@"%@/artists/%@/radio", self.humm.endPoint, idArtist]
          parameters:parameters
             success:^(AFHTTPRequestOperation *operation, id responseObject) {
                 
                 if ([@"ok" isEqualToString:responseObject[@"status_response"]])
                 {
                     NSError *error;
                     
                     NSArray<Song *> *playlists = [Song arrayOfModelsFromDictionaries:responseObject[@"data_response"] error:&error];
                     
                     if (error)
                     {
                         NSLog(@"Error = %@", [error localizedDescription]);
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
        
    } onUpdatedError:^(NSError *e) {
        NSLog(@"error = %@", [e localizedDescription]);
        error(e);
        
    }];
    ;
    
    
}

-(void) getSimilar:(NSString *) idArtist
             limit:(NSInteger) limit
            offset:(NSInteger) offset
           success:(void (^) (NSArray<Artist *> *response)) success
             error:(void (^) (NSError *error)) error
{
    
    [self.humm updateUserToken:^{
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        manager.responseSerializer =[AFJSONResponseSerializer serializer];
        
        [manager.requestSerializer setValue:[NSString stringWithFormat:@"%@", self.humm.token ]forHTTPHeaderField:@"Authorization"];
        
        NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
        
        if (limit > 0)
        {
            [parameters setObject:[NSNumber numberWithInteger:limit] forKey:@"limit"];
        }
        
        if (offset > 0)
        {
            [parameters setObject:[NSNumber numberWithInteger:offset] forKey:@"offset"];
        }
        
        
        [manager GET:[NSString stringWithFormat:@"%@/artists/%@/similar", self.humm.endPoint, idArtist]
          parameters:parameters
             success:^(AFHTTPRequestOperation *operation, id responseObject) {
                 
                 if ([@"ok" isEqualToString:responseObject[@"status_response"]])
                 {
                     NSError *error;
                     NSArray<Artist *> *artists = [Artist arrayOfModelsFromDictionaries:responseObject[@"data_response"] error:&error];
                     
                     if (error)
                     {
                         NSLog(@"Error = %@", [error localizedDescription]);
                     }
                     
                     success(artists);
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

-(void) getTopSongs:(NSString *) idArtist
              limit:(NSInteger) limit
             offset:(NSInteger) offset
           songType:(NSString *) songType
           live:(BOOL) live
            success:(void (^) (NSArray<Song *> *response)) success
              error:(void (^) (NSError *error)) error
{
    
    [self.humm updateUserToken:^{
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        manager.responseSerializer =[AFJSONResponseSerializer serializer];
        
        [manager.requestSerializer setValue:[NSString stringWithFormat:@"%@", self.humm.token ]forHTTPHeaderField:@"Authorization"];
        
        NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
        
        if (limit > 0)
        {
            [parameters setObject:[NSNumber numberWithInteger:limit] forKey:@"limit"];
        }
        
        if (offset > 0)
        {
            [parameters setObject:[NSNumber numberWithInteger:offset] forKey:@"offset"];
        }
        
        if (songType)
        {
            [parameters setObject:songType forKey:@"songtype"];
        }
        
        [parameters setObject:[NSNumber numberWithBool:live] forKey:@"live"];
        
        
        [manager GET:[NSString stringWithFormat:@"%@/artists/%@/topsongs", self.humm.endPoint, idArtist]
          parameters:parameters
             success:^(AFHTTPRequestOperation *operation, id responseObject) {
                 
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
    ;
    
    
}

-(void) getFeaturedWithLimit:(NSInteger) limit
                      offset:(NSInteger) offset
                       genre:(NSString *) genre
                     success:(void (^) (NSArray<Artist *> *response)) success
                       error:(void (^) (NSError *error)) error
{
    
    [self.humm updateUserToken:^{
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        manager.responseSerializer =[AFJSONResponseSerializer serializer];
        
        [manager.requestSerializer setValue:[NSString stringWithFormat:@"%@", self.humm.token ]forHTTPHeaderField:@"Authorization"];
        
        NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
        
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
        
        
        [manager GET:[NSString stringWithFormat:@"%@/artists/featured", self.humm.endPoint]
          parameters:parameters
             success:^(AFHTTPRequestOperation *operation, id responseObject) {
                 
                 if ([@"ok" isEqualToString:responseObject[@"status_response"]])
                 {
                     NSError *error;
                     NSArray<Artist *> *artists = [Artist arrayOfModelsFromDictionaries:responseObject[@"data_response"] error:&error];
                     
                     if (error)
                     {
                         NSLog(@"Error = %@", [error localizedDescription]);
                     }
                     
                     success(artists);
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

-(void) getPopularWithLimit:(NSInteger) limit
                     offset:(NSInteger) offset
                    success:(void (^) (NSArray<Artist *> *response)) success
                      error:(void (^) (NSError *error)) error
{
    
    [self.humm updateUserToken:^{
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        manager.responseSerializer =[AFJSONResponseSerializer serializer];
        
        [manager.requestSerializer setValue:[NSString stringWithFormat:@"%@", self.humm.token ]forHTTPHeaderField:@"Authorization"];
        
        NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
        
        if (limit > 0)
        {
            [parameters setObject:[NSNumber numberWithInteger:limit] forKey:@"limit"];
        }
        
        if (offset > 0)
        {
            [parameters setObject:[NSNumber numberWithInteger:offset] forKey:@"offset"];
        }
        
        [manager GET:[NSString stringWithFormat:@"%@/artists/popular", self.humm.endPoint]
          parameters:parameters
             success:^(AFHTTPRequestOperation *operation, id responseObject) {
                 
                 if ([@"ok" isEqualToString:responseObject[@"status_response"]])
                 {
                     NSError *error;
                     NSArray<Artist *> *artists = [Artist arrayOfModelsFromDictionaries:responseObject[@"data_response"] error:&error];
                     
                     if (error)
                     {
                         NSLog(@"Error = %@", [error localizedDescription]);
                     }
                     
                     success(artists);
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

-(void) getRecent:(NSInteger) limit
           offset:(NSInteger) offset
          success:(void (^) (NSArray<Artist *> *response)) success
            error:(void (^) (NSError *error)) error
{
    
    [self.humm updateUserToken:^{
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        manager.responseSerializer =[AFJSONResponseSerializer serializer];
        
        [manager.requestSerializer setValue:[NSString stringWithFormat:@"%@", self.humm.token ]forHTTPHeaderField:@"Authorization"];
        
        NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
        
        if (limit > 0)
        {
            [parameters setObject:[NSNumber numberWithInteger:limit] forKey:@"limit"];
        }
        
        if (offset > 0)
        {
            [parameters setObject:[NSNumber numberWithInteger:offset] forKey:@"offset"];
        }
        
        [manager GET:[NSString stringWithFormat:@"%@/artists/recent", self.humm.endPoint]
          parameters:parameters
             success:^(AFHTTPRequestOperation *operation, id responseObject) {
                 
                 if ([@"ok" isEqualToString:responseObject[@"status_response"]])
                 {
                     NSError *error;
                     NSArray<Artist *> *artists = [Artist arrayOfModelsFromDictionaries:responseObject[@"data_response"] error:&error];
                     
                     if (error)
                     {
                         NSLog(@"Error = %@", [error localizedDescription]);
                     }
                     
                     success(artists);
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

-(void) search:(NSString *) keyword
         limit:(NSInteger) limit
        offset:(NSInteger) offset
       success:(void (^) (NSArray<Artist *> *response)) success
         error:(void (^) (NSError *error)) error
{
    
    [self.humm updateUserToken:^{
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        manager.responseSerializer =[AFJSONResponseSerializer serializer];
        
        [manager.requestSerializer setValue:[NSString stringWithFormat:@"%@", self.humm.token ]forHTTPHeaderField:@"Authorization"];
        
        NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
        
        if (!keyword)
        {
            error([NSError errorWithDomain:@"hummDomain" code:100 userInfo:nil]);
        }
        else
        {
            [parameters setObject:keyword forKey:@"keyword"];
        }
        
        if (limit > 0)
        {
            [parameters setObject:[NSNumber numberWithInteger:limit] forKey:@"limit"];
        }
        
        if (offset > 0)
        {
            [parameters setObject:[NSNumber numberWithInteger:offset] forKey:@"offset"];
        }
        
        [manager GET:[NSString stringWithFormat:@"%@/artists", self.humm.endPoint]
          parameters:parameters
             success:^(AFHTTPRequestOperation *operation, id responseObject) {
                 
                 if ([@"ok" isEqualToString:responseObject[@"status_response"]])
                 {
                     NSError *error;
                     NSArray<Artist *> *artists = [Artist arrayOfModelsFromDictionaries:responseObject[@"data_response"] error:&error];
                     
                     if (error)
                     {
                         NSLog(@"Error = %@", [error localizedDescription]);
                     }
                     
                     success(artists);
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


@end
