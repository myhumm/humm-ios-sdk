//
//  UserAPI.m
//  wrapper
//
//  Created by Jose Alonso García on 30/11/15.
//  Copyright © 2015 humm. All rights reserved.
//

#import "UserAPI.h"
#import "AFHTTPRequestOperationManager.h"
#import "AFNetworkActivityLogger.h"

@interface UserAPI()

@property (nonatomic, strong) HummAPI *humm;

@end

@implementation UserAPI


-(id) init
{
    
    self = [super init];
    
    if (self) {
        self.humm = [HummAPI sharedManager];
    }
    
    return self;
    
}
- (void) doLoginWithUsername: (NSString *) username
                 andPassword: (NSString *) password
                     success:(void (^) (LoginInfo *response)) success
                       error:(void (^) (NSError *error)) error
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer =[AFJSONResponseSerializer serializer];
    
    NSDictionary *parameters = [[NSDictionary alloc]init];
    
    parameters = [[NSDictionary alloc]initWithObjectsAndKeys:
                  username, @"username",
                  password, @"password",
                  self.humm.grantType , @"grant_type",
                  self.humm.clientId, @"client_id",
                  nil];
    
    NSString *url = [NSString stringWithFormat:@"%@/token?username=%@&password=%@&grant_type=%@&client_id=%@", self.humm.endPoint, username, password, self.humm.grantType, self.humm.clientId];
    //    [manager POST:[NSString stringWithFormat:@"%@/token", self.humm.endPoint]
    [manager POST:url
       parameters:parameters
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              
              if ([@"ok" isEqualToString:responseObject[@"status_response"]])
              {
                  NSError* err = nil;
                  LoginInfo *login = [[LoginInfo alloc] initWithDictionary:responseObject[@"data_response"] error:&err];
                  success(login);
              }
              else {
                  error([NSError errorWithDomain:@"hummDomain" code:100 userInfo:responseObject[@"data_response"]]);
              }
              
          } failure:^(AFHTTPRequestOperation *operation, NSError *e) {
              NSLog(@"error = %@", [e localizedDescription]);
              
              error(e);
          }];
}

-(void) loginWithService:(NSString *) userId
          onLoginSuccess:(void (^) (LoginInfo *loginInfo)) loginSuccess
            onLoginError:(void (^) (NSError *error)) loginError
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer =[AFJSONResponseSerializer serializer];
    
    NSDictionary *parameters = [[NSDictionary alloc]init];
    
    parameters = [[NSDictionary alloc]initWithObjectsAndKeys:
                  userId, @"userId",
                  self.humm.grantType , @"grant_type",
                  self.humm.clientId, @"client_id",
                  nil];
    
    NSString *url = [NSString stringWithFormat:@"%@/loginWithService", self.humm.endPoint];
    //    [manager POST:[NSString stringWithFormat:@"%@/token", self.humm.endPoint]
    [manager POST:url
       parameters:parameters
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              
              if ([@"ok" isEqualToString:responseObject[@"status_response"]])
              {
                  NSError* err = nil;
                  LoginInfo *login = [[LoginInfo alloc] initWithDictionary:responseObject[@"data_response"] error:&err];
                  [self updateLoginDataWithLoginInfo:login];
                  loginSuccess(login);
              }
              else {
                  loginError([NSError errorWithDomain:@"hummDomain" code:100 userInfo:responseObject[@"data_response"]]);
              }
              
          } failure:^(AFHTTPRequestOperation *operation, NSError *e) {
              NSLog(@"error = %@", [e localizedDescription]);
              loginError(e);
          }];
}


- (void) doSignupWithUsername: (NSString *) username
                     password: (NSString *) password
                        email: (NSString *) email
                    firstName: (NSString *) firstName
                     lastName:(NSString *) lastName
                      referal:(NSString *) referal
                      success:(void (^) (LoginInfo *response)) success
                        error:(void (^) (NSError *error)) error
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer =[AFJSONResponseSerializer serializer];
    
    NSDictionary *parameters = [[NSDictionary alloc]init];
    
    parameters = [[NSDictionary alloc]initWithObjectsAndKeys:
                  self.humm.clientId, @"client_id",
                  username, @"username",
                  password, @"password",
                  email, @"email",
                  firstName, @"first_name",
                  lastName, @"last_name",
                  referal, @"referal",
                  nil];
    
    //    NSString *url = [NSString stringWithFormat:@"%@/users/signup?username=%@&password=%@&email=%@&firstname=%@&lastname=%@", self.humm.endPoint, username, password, email, firstName, lastName];
    
    NSString *url = [NSString stringWithFormat:@"%@/users/signup", self.humm.endPoint];
    
    [manager POST:[url stringByAddingPercentEncodingWithAllowedCharacters:NSCharacterSet.URLQueryAllowedCharacterSet]
     
     //    [manager POST:[NSString stringWithFormat:@"%@/users/signup", self.humm.endPoint]
       parameters:parameters
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              
              if ([@"ok" isEqualToString:responseObject[@"status_response"]])
              {
                  NSError* err = nil;
                  LoginInfo *login = [[LoginInfo alloc] initWithDictionary:responseObject[@"data_response"] error:&err];
                  success(login);
              }
              else {
                  error([NSError errorWithDomain:@"hummDomain" code:100 userInfo:responseObject[@"data_response"]]);
              }
              
          } failure:^(AFHTTPRequestOperation *operation, NSError *e) {
              NSLog(@"error = %@", [e localizedDescription]);
              
              error(e);
          }];
    
}

- (void) refreshToken:(void (^) (LoginInfo *response)) success
                error:(void (^) (NSError *error)) error
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer =[AFJSONResponseSerializer serializer];
    
    NSDictionary *parameters = [[NSDictionary alloc]init];
    
    parameters = [[NSDictionary alloc]initWithObjectsAndKeys:
                  self.humm.clientId, @"client_id",
                  self.humm.grantType, @"grant_type",
                  self.humm.refresh_token, @"refresh_token",
                  nil];
    
    if (self.MODE_DEBUG)
    {
        [AFNetworkActivityLogger sharedLogger].level = AFLoggerLevelDebug;
        [[AFNetworkActivityLogger sharedLogger] startLogging];
    }
    
    [AFNetworkActivityLogger sharedLogger].level = AFLoggerLevelDebug;
    [[AFNetworkActivityLogger sharedLogger] startLogging];
    
    
    AFHTTPRequestOperation *operation = [manager POST:[NSString stringWithFormat:@"%@/token", self.humm.endPoint]
                                           parameters:parameters
                                              success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                                  
                                                  if ([@"ok" isEqualToString:responseObject[@"status_response"]])
                                                  {
                                                      NSError* err = nil;
                                                      LoginInfo *login = [[LoginInfo alloc] initWithDictionary:responseObject[@"data_response"] error:&err];
                                                      success(login);
                                                  }
                                                  else {
                                                      error([NSError errorWithDomain:@"hummDomain" code:100 userInfo:responseObject[@"data_response"]]);
                                                  }
                                                  
                                              } failure:^(AFHTTPRequestOperation *operation, NSError *e) {
                                                  NSLog(@"error = %@", [e localizedDescription]);
                                                  
                                                  error(e);
                                              }];
    
    [operation waitUntilFinished];
}

-(void) me:(void (^) (User *response)) success
     error:(void (^) (NSError *error)) error
{
    
    [self.humm updateUserToken:^{
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        manager.responseSerializer =[AFJSONResponseSerializer serializer];
        
        [manager.requestSerializer setValue:[NSString stringWithFormat:@"%@", self.humm.token ]forHTTPHeaderField:@"Authorization"];
        
        [manager GET:[NSString stringWithFormat:@"%@/users/me", self.humm.endPoint]
          parameters:nil
             success:^(AFHTTPRequestOperation *operation, id responseObject) {
                 
                 NSLog(@"response %@", responseObject);
                 
                 if ([@"ok" isEqualToString:responseObject[@"status_response"]])
                 {
                     NSError* err = nil;
                     User *user = [[User alloc] initWithDictionary:responseObject[@"data_response"] error:&err];
                     success(user);
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
        
    }
     ];
    
}

-(void) discoverReleasesWithLimit:(NSInteger) limit
                           offset:(NSInteger) offset
                          success:(void (^) (NSArray<Playlist *> *response)) success
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
        
        [manager GET:[NSString stringWithFormat:@"%@/users/me/discover/releases", self.humm.endPoint]
          parameters:parameters
             success:^(AFHTTPRequestOperation *operation, id responseObject) {
                 
                 NSLog(@"response %@", responseObject);
                 
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
    
}

-(void) discoverArtistsWithLimit:(NSInteger) limit
                          offset:(NSInteger) offset
                         success:(void (^) (NSArray<Artist *> *response)) success
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
        
        [manager GET:[NSString stringWithFormat:@"%@/users/me/discover/artists", self.humm.endPoint]
          parameters:parameters
             success:^(AFHTTPRequestOperation *operation, id responseObject) {
                 
                 NSLog(@"response %@", responseObject);
                 
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
    
    
}

-(void) discoverPlaylistsWithLimit:(NSInteger) limit
                            offset:(NSInteger) offset
                           success:(void (^) (NSArray<Playlist *> *response)) success
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
        
        [manager GET:[NSString stringWithFormat:@"%@/users/me/discover/playlists", self.humm.endPoint]
          parameters:parameters
             success:^(AFHTTPRequestOperation *operation, id responseObject) {
                 
                 NSLog(@"response %@", responseObject);
                 
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
    
    
}

-(void) addFavourites:(NSString *) idSong
              success:(void (^) (Song *response)) success
                error:(void (^) (NSError *error)) error
{
    [self.humm updateUserToken:^{
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        manager.responseSerializer =[AFJSONResponseSerializer serializer];
        
        NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
        
        if (!idSong)
        {
            error([NSError errorWithDomain:@"hummDomain" code:100 userInfo:nil]);
        }
        
        [manager.requestSerializer setValue:[NSString stringWithFormat:@"%@", self.humm.token ]forHTTPHeaderField:@"Authorization"];
        
        [manager POST:[NSString stringWithFormat:@"%@/songs/%@/favourites", self.humm.endPoint, idSong]
           parameters:parameters
              success:^(AFHTTPRequestOperation *operation, id responseObject) {
                  
                  NSLog(@"response %@", responseObject);
                  
                  if ([@"ok" isEqualToString:responseObject[@"status_response"]])
                  {
                      
                      NSError *err;
                      Song *song = [[Song alloc] initWithDictionary:responseObject[@"data_response"] error:&err];
                      
                      if (err)
                      {
                          error([NSError errorWithDomain:@"hummDomain" code:100 userInfo:nil]);
                      }
                      
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
    
    
}


-(void) addFollows:(NSString *) idUser
           success:(void (^) (User *response)) success
             error:(void (^) (NSError *error)) error
{
    [self.humm updateUserToken:^{
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        manager.responseSerializer =[AFJSONResponseSerializer serializer];
        
        NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
        
        if (!idUser)
        {
            error([NSError errorWithDomain:@"hummDomain" code:100 userInfo:nil]);
        }
        
        [manager.requestSerializer setValue:[NSString stringWithFormat:@"%@", self.humm.token ]forHTTPHeaderField:@"Authorization"];
        
        [manager POST:[NSString stringWithFormat:@"%@/users/%@/follows", self.humm.endPoint, idUser]
           parameters:parameters
              success:^(AFHTTPRequestOperation *operation, id responseObject) {
                  
                  NSLog(@"response %@", responseObject);
                  
                  if ([@"ok" isEqualToString:responseObject[@"status_response"]])
                  {
                      
                      NSError *err;
                      User *user = [[User alloc] initWithDictionary:responseObject[@"data_response"] error:&err];
                      
                      if (err)
                      {
                          error([NSError errorWithDomain:@"hummDomain" code:100 userInfo:nil]);
                      }
                      
                      success(user);
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

-(void) removeFollows:(NSString *) idUser
              success:(void (^) (User *response)) success
                error:(void (^) (NSError *error)) error
{
    [self.humm updateUserToken:^{
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        manager.responseSerializer =[AFJSONResponseSerializer serializer];
        
        NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
        
        if (!idUser)
        {
            error([NSError errorWithDomain:@"hummDomain" code:100 userInfo:nil]);
        }
        
        [manager.requestSerializer setValue:[NSString stringWithFormat:@"%@", self.humm.token ]forHTTPHeaderField:@"Authorization"];
        
        [manager DELETE:[NSString stringWithFormat:@"%@/users/%@/follows", self.humm.endPoint, idUser]
             parameters:parameters
                success:^(AFHTTPRequestOperation *operation, id responseObject) {
                    
                    if ([@"ok" isEqualToString:responseObject[@"status_response"]])
                    {
                        
                        NSError *err;
                        User *user = [[User alloc] initWithDictionary:responseObject[@"data_response"] error:&err];
                        
                        if (err)
                        {
                            error([NSError errorWithDomain:@"hummDomain" code:100 userInfo:nil]);
                        }
                        
                        success(user);
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

-(void) get:(NSString *) idUser
    success:(void (^) (User *response)) success
      error:(void (^) (NSError *error)) error
{
    [self.humm updateUserToken:^{
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        manager.responseSerializer =[AFJSONResponseSerializer serializer];
        
        NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
        
        if (!idUser)
        {
            error([NSError errorWithDomain:@"hummDomain" code:100 userInfo:nil]);
        }
        
        [manager.requestSerializer setValue:[NSString stringWithFormat:@"%@", self.humm.token ]forHTTPHeaderField:@"Authorization"];
        
        [manager GET:[NSString stringWithFormat:@"%@/users/%@", self.humm.endPoint, idUser]
          parameters:parameters
             success:^(AFHTTPRequestOperation *operation, id responseObject) {
                 
                 if ([@"ok" isEqualToString:responseObject[@"status_response"]])
                 {
                     
                     NSError *err;
                     User *user = [[User alloc] initWithDictionary:responseObject[@"data_response"] error:&err];
                     
                     if (err)
                     {
                         error([NSError errorWithDomain:@"hummDomain" code:100 userInfo:nil]);
                     }
                     
                     success(user);
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

-(void) getFavourites:(NSString *) idUser
                limit:(NSInteger) limit
               offset:(NSInteger) offset
              success:(void (^) (NSArray<Song *> *response)) success
                error:(void (^) (NSError *error)) error
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer =[AFJSONResponseSerializer serializer];
    
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    
    if (!idUser)
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
    
    
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"%@", self.humm.token ]forHTTPHeaderField:@"Authorization"];
    
    [manager GET:[NSString stringWithFormat:@"%@/users/%@/favourites", self.humm.endPoint, idUser]
      parameters:parameters
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             
             if ([@"ok" isEqualToString:responseObject[@"status_response"]])
             {
                 
                 NSError *err;
                 NSArray<Song *> *songs = [Artist arrayOfModelsFromDictionaries:responseObject[@"data_response"] error:&err];
                 
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

-(void) getFollows:(NSString *) idUser
             limit:(NSInteger) limit
            offset:(NSInteger) offset
           success:(void (^) (NSArray<User *> *response)) success
             error:(void (^) (NSError *error)) error
{
    
    [self.humm updateUserToken:^{
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        manager.responseSerializer =[AFJSONResponseSerializer serializer];
        
        NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
        
        if (!idUser)
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
        
        
        [manager.requestSerializer setValue:[NSString stringWithFormat:@"%@", self.humm.token ]forHTTPHeaderField:@"Authorization"];
        
        [manager GET:[NSString stringWithFormat:@"%@/users/%@/follows", self.humm.endPoint, idUser]
          parameters:parameters
             success:^(AFHTTPRequestOperation *operation, id responseObject) {
                 
                 if ([@"ok" isEqualToString:responseObject[@"status_response"]])
                 {
                     
                     NSError *err;
                     NSArray<User *> *users = [User arrayOfModelsFromDictionaries:responseObject[@"data_response"] error:&err];
                     
                     if (err)
                     {
                         error([NSError errorWithDomain:@"hummDomain" code:100 userInfo:nil]);
                     }
                     
                     success(users);
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

-(void) getPlaylists:(NSString *) idUser
               limit:(NSInteger) limit
              offset:(NSInteger) offset
             success:(void (^) (NSArray<Playlist *> *response)) success
               error:(void (^) (NSError *error)) error
{
    [self.humm updateUserToken:^{
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        manager.responseSerializer =[AFJSONResponseSerializer serializer];
        
        NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
        
        if (!idUser)
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
        
        
        [manager.requestSerializer setValue:[NSString stringWithFormat:@"%@", self.humm.token ]forHTTPHeaderField:@"Authorization"];
        
        [manager GET:[NSString stringWithFormat:@"%@/users/%@/playlists", self.humm.endPoint, idUser]
          parameters:parameters
             success:^(AFHTTPRequestOperation *operation, id responseObject) {
                 
                 if (!responseObject) //no content
                 {
                     success(nil);
                     return;
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
        
    } onUpdatedError:^(NSError *e) {
        NSLog(@"error = %@", [e localizedDescription]);
        error(e);
    }];
    
    
}

#define RESPONSE_PASSWORD_CHANGED @"Password changed"
#define RESPONSE_USER_EXISTS @"User exists"

-(void) resetPassword: (NSString *) email
              success:(void (^) (BOOL response)) success
                error:(void (^) (NSError *error)) error
{
    
    [self.humm updateUserToken:^{
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        manager.responseSerializer =[AFJSONResponseSerializer serializer];
        
        NSDictionary *parameters = [[NSDictionary alloc]initWithObjectsAndKeys:
                                    email, @"email",
                                    nil];
        
        [manager.requestSerializer setValue:[NSString stringWithFormat:@"%@", self.humm.token]
                         forHTTPHeaderField:@"Authorization"];
        
        [manager POST:[NSString stringWithFormat:@"%@/users/reset", self.humm.endPoint]
           parameters:parameters
              success:^(AFHTTPRequestOperation *operation, id responseObject) {
                  
                  if ([@"ok" isEqualToString:responseObject[@"status_response"]])
                  {
                      if ([responseObject[@"data_response"] isEqualToString:RESPONSE_PASSWORD_CHANGED])
                      {
                          success(YES);
                      }
                      else {
                          success(NO);
                      }
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


-(void) checkEmail: (NSString *) email
           success:(void (^) (BOOL response)) success
             error:(void (^) (NSError *error)) error
{
    
    [self.humm updateUserToken:^{
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        manager.responseSerializer =[AFJSONResponseSerializer serializer];
        
        NSDictionary *parameters = [[NSDictionary alloc]initWithObjectsAndKeys:
                                    email, @"email",
                                    nil];
        
        [manager.requestSerializer setValue:[NSString stringWithFormat:@"%@", self.humm.token]
                         forHTTPHeaderField:@"Authorization"];
        
        [manager GET:[NSString stringWithFormat:@"%@/users/checkemail", self.humm.endPoint]
          parameters:parameters
             success:^(AFHTTPRequestOperation *operation, id responseObject) {
                 
                 if ([@"ok" isEqualToString:responseObject[@"status_response"]])
                 {
                     if ([responseObject[@"data_response"] isEqualToString:RESPONSE_USER_EXISTS])
                     {
                         success(YES);
                     }
                     else {
                         success(NO);
                     }
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

-(void) checkUsername: (NSString *) username
              success:(void (^) (BOOL response)) success
                error:(void (^) (NSError *error)) error
{
    
    [self.humm updateUserToken:^{
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        manager.responseSerializer =[AFJSONResponseSerializer serializer];
        
        NSDictionary *parameters = [[NSDictionary alloc]initWithObjectsAndKeys:
                                    username, @"uname",
                                    nil];
        
        [manager.requestSerializer setValue:[NSString stringWithFormat:@"%@", self.humm.token]
                         forHTTPHeaderField:@"Authorization"];
        
        [manager GET:[NSString stringWithFormat:@"%@/users/checkusername", self.humm.endPoint]
          parameters:parameters
             success:^(AFHTTPRequestOperation *operation, id responseObject) {
                 
                 if ([@"ok" isEqualToString:responseObject[@"status_response"]])
                 {
                     if ([responseObject[@"data_response"] isEqualToString:RESPONSE_USER_EXISTS])
                     {
                         success(YES);
                     }
                     else {
                         success(NO);
                     }
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

-(void) addServiceWithServiceName:(NSString *) serviceName
                         seviceId:(NSString *) serviceId
                            token:(NSString *) serviceToken
                  serviceUsername:(NSString *) serviceUsername
                           secret:(NSString *) secret
                          success:(void (^) (HummSettings * response)) success
                            error:(void (^) (NSError *error)) error
{
    
    [self.humm updateUserToken:^{
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        manager.responseSerializer =[AFJSONResponseSerializer serializer];
        
        NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
        
        if (!serviceName)
        {
            error([NSError errorWithDomain:@"hummDomain" code:100 userInfo:nil]);
        }
        if (!serviceId)
        {
            error([NSError errorWithDomain:@"hummDomain" code:100 userInfo:nil]);
        }
        if (!serviceToken)
        {
            error([NSError errorWithDomain:@"hummDomain" code:100 userInfo:nil]);
        }
        
        [parameters setObject:serviceName forKey:@"service"];
        [parameters setObject:serviceId forKey:@"sid"];
        [parameters setObject:serviceToken forKey:@"token"];
        [parameters setObject:serviceUsername forKey:@"uname"];
        [parameters setObject:serviceUsername forKey:@"secret"];
        
        [manager.requestSerializer setValue:[NSString stringWithFormat:@"%@", self.humm.token ]forHTTPHeaderField:@"Authorization"];
        
        [manager POST:[NSString stringWithFormat:@"%@/user/me/settings/services", self.humm.endPoint]
           parameters:parameters
              success:^(AFHTTPRequestOperation *operation, id responseObject) {
                  
                  if ([@"ok" isEqualToString:responseObject[@"status_response"]])
                  {
                      HummSettings * settings = responseObject[@"data_response"];
                      success(settings);
                      
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

-(void) removeService:(NSString *) serviceName
            serviceId:(NSString *) serviceId
              success:(void (^) (LoginInfo * response)) success
                error:(void (^) (NSError *error)) error
{
    
    
    [self.humm updateUserToken:^{
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        manager.responseSerializer =[AFJSONResponseSerializer serializer];
        
        NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
        
        if (!serviceName)
        {
            error([NSError errorWithDomain:@"ServiceName cant be null" code:100 userInfo:nil]);
        }
        if (!serviceId)
        {
            error([NSError errorWithDomain:@"serviceId cant be null" code:100 userInfo:nil]);
        }
        if (!self.humm.token)
        {
            error([NSError errorWithDomain:@"token cant be null" code:100 userInfo:nil]);
        }
        
        [parameters setObject:serviceName forKey:@"service"];
        [parameters setObject:serviceId forKey:@"sid"];
        
        [manager.requestSerializer setValue:[NSString stringWithFormat:@"%@", self.humm.token]
                         forHTTPHeaderField:@"Authorization"];

        
        [manager DELETE:[NSString stringWithFormat:@"%@/user/me/settings/services", self.humm.endPoint]
             parameters:parameters
                success:^(AFHTTPRequestOperation *operation, id responseObject) {
                    
                    if ([@"ok" isEqualToString:responseObject[@"status_response"]])
                    {
                        LoginInfo * settings = responseObject[@"data_response"];
                        success(settings);
                        
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
