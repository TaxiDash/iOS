//
//  TAXClient.h
//  Taxi Rating
//
//  Created by Seth Friedman on 2/5/14.
//  Copyright (c) 2014 Nashville Public Works. All rights reserved.
//

#import "AFHTTPSessionManager.h"

@class TAXDriver;

@interface TAXClient : AFHTTPSessionManager

+ (instancetype)sharedClient;

- (NSURLSessionDataTask *)fetchDriverWithID:(NSString *)driverID andCompletionBlock:(void (^)(BOOL success, TAXDriver *driver))completionBlock;

@end
