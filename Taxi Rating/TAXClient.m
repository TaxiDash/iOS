//
//  TAXClient.m
//  Taxi Rating
//
//  Created by Seth Friedman on 2/5/14.
//  Copyright (c) 2014 Nashville Public Works. All rights reserved.
//

#import "TAXClient.h"
#import "TAXResponseSerializer.h"
#import "TAXDriver.h"

@import CoreLocation;

static NSString * const kTAXBaseURLString = @"http://taxi-rating-server.herokuapp.com/";

@implementation TAXClient

#pragma mark - Designated Initializer

- (instancetype)initWithBaseURL:(NSURL *)url sessionConfiguration:(NSURLSessionConfiguration *)configuration {
    self = [super initWithBaseURL:url
             sessionConfiguration:configuration];
    
    if (self) {
        self.responseSerializer = [TAXResponseSerializer serializer];
    }
    
    return self;
}

#pragma mark - Singleton

+ (instancetype)sharedClient {
    static TAXClient *_sharedClient;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        
        NSURLCache *cache = [[NSURLCache alloc] initWithMemoryCapacity:10 * 1024 * 1024
                                                          diskCapacity:50 * 1024 * 1024
                                                              diskPath:nil];
        
        config.URLCache = cache;
        
        _sharedClient = [[self alloc] initWithBaseURL:[NSURL URLWithString:kTAXBaseURLString]
                                 sessionConfiguration:config];
    });
    
    return _sharedClient;
}

#pragma mark - Instance Methods

- (NSURLSessionDataTask *)fetchDriverWithBeaconID:(NSNumber *)beaconID withCompletionBlock:(void (^)(BOOL success, TAXDriver *driver))completionBlock {
    NSString *path = [@"mobile" stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.json", beaconID]];
    
    NSURLSessionDataTask *task = [self GET:path
                                parameters:nil
                                   success:^(NSURLSessionDataTask *task, id responseObject) {
                                       NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)task.response;
                                       
                                       if (httpResponse.statusCode == 200) {
                                           dispatch_async(dispatch_get_main_queue(), ^{
                                               completionBlock(YES, responseObject);
                                           });
                                       } else {
                                           dispatch_async(dispatch_get_main_queue(), ^{
                                               completionBlock(NO, nil);
                                           });
                                           
                                           NSLog(@"Received: %@", responseObject);
                                           NSLog(@"Received HTTP %ld", (long)httpResponse.statusCode);
                                       }
                                   } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                       dispatch_async(dispatch_get_main_queue(), ^{
                                           completionBlock(NO, nil);
                                       });
                                   }];
    
    return task;
}

- (void)fetchDriversWithBeacons:(NSArray *)beacons withCompletionBlock:(void (^)(BOOL success, NSArray *drivers))completionBlock {
    NSMutableArray *drivers = [NSMutableArray arrayWithCapacity:[beacons count]];
    
    dispatch_group_t group = dispatch_group_create();
    
    for (CLBeacon *beacon in beacons) {
        dispatch_group_enter(group);
        
        [self fetchDriverWithBeaconID:beacon.minor
                  withCompletionBlock:^(BOOL success, TAXDriver *driver) {
                      if (success) {
                          driver.beacon = beacon;
                          [drivers addObject:driver];
                      }
                      
                      dispatch_group_leave(group);
                  }];
    }
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        if ([drivers count]) {
            [drivers sortUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"beacon"
                                                                          ascending:YES
                                                                         comparator:^NSComparisonResult(id obj1, id obj2) {
                                                                             CLBeacon *beacon1 = obj1;
                                                                             CLBeacon *beacon2 = obj2;
                                                                             
                                                                             CLProximity proximity1 = beacon1.proximity;
                                                                             CLProximity proximity2 = beacon2.proximity;
                                                                             
                                                                             NSComparisonResult result;
                                                                             
                                                                             if (proximity1 == proximity2) {
                                                                                 result = NSOrderedSame;
                                                                             } else if (proximity1 == CLProximityUnknown || proximity1 > proximity2) {
                                                                                 result = NSOrderedDescending;
                                                                             } else {
                                                                                 result = NSOrderedAscending;
                                                                             }
                                                                             
                                                                             return result;
                                                                         }],
                                            [NSSortDescriptor sortDescriptorWithKey:@"beacon.accuracy"
                                                                          ascending:YES]]];
            
            completionBlock(YES, [drivers copy]);
        } else {
            completionBlock(NO, nil);
        }
    });
}

- (NSURLSessionDataTask *)postRatingForDriverID:(NSString *)driverID withRating:(NSInteger)rating comments:(NSString *)comments andCompletionBlock:(void (^)(BOOL))completionBlock {
    NSDictionary *params = @{@"rating": @{@"driver_id": driverID,
                                          @"rating": @(rating),
                                          @"comments": comments}};
    
    NSURLSessionDataTask *task = [self POST:@"ratings.json"
                                 parameters:params
                                    success:^(NSURLSessionDataTask *task, id responseObject) {
                                        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)task.response;
                                        
                                        if (httpResponse.statusCode == 201) {
                                            dispatch_async(dispatch_get_main_queue(), ^{
                                                completionBlock(YES);
                                            });
                                        } else {
                                            dispatch_async(dispatch_get_main_queue(), ^{
                                                completionBlock(NO);
                                            });
                                            
                                            NSLog(@"Received: %@", responseObject);
                                            NSLog(@"Received HTTP %ld", (long)httpResponse.statusCode);
                                        }
                                    } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                        dispatch_async(dispatch_get_main_queue(), ^{
                                            completionBlock(NO);
                                        });
                                    }];
    
    return task;
}

@end
