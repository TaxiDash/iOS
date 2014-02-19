//
//  TAXClient.m
//  Taxi Rating
//
//  Created by Seth Friedman on 2/5/14.
//  Copyright (c) 2014 Nashville Public Works. All rights reserved.
//

#import "TAXClient.h"

static NSString * const kTAXBaseURLString = @"http://taxi-rating-server.herokuapp.com/";

@implementation TAXClient

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

- (NSURLSessionDataTask *)fetchDriverWithID:(NSString *)driverID andCompletionBlock:(void (^)(BOOL success, TAXDriver *driver))completionBlock {
    NSString *path = [@"drivers" stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.json", driverID]];
    
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

@end
