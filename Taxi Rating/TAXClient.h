//
//  TAXClient.h
//  Taxi Rating
//
//  Created by Seth Friedman on 2/5/14.
//  Copyright (c) 2014 Nashville Public Works. All rights reserved.
//

#import "AFHTTPSessionManager.h"

@interface TAXClient : AFHTTPSessionManager

+ (instancetype)sharedClient;

- (NSURLSessionDataTask *)fetchTestWithCompletionBlock:(void (^)(BOOL success, id responseObject))completionBlock;

@end