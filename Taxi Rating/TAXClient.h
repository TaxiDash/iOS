//
//  TAXClient.h
//  Taxi Rating
//
//  Created by Seth Friedman on 2/5/14.
//  Copyright (c) 2014 Nashville Public Works. All rights reserved.
//

#import <AFNetworking/AFHTTPSessionManager.h>

@import CoreLocation;

@class TAXDriver;

@interface TAXClient : AFHTTPSessionManager

+ (instancetype)sharedClient;

- (NSURLSessionDataTask *)fetchDriverWithBeaconID:(NSNumber *)beaconID withCompletionBlock:(void (^)(BOOL success, TAXDriver *driver))completionBlock;

- (void)fetchDriversWithBeacons:(NSArray *)beacons withCompletionBlock:(void (^)(BOOL success, NSArray *drivers))completionBlock;

- (NSURLSessionDataTask *)postRatingForDriverID:(NSString *)driverID withRating:(NSInteger)rating comments:(NSString *)comments startCoordinate:(CLLocationCoordinate2D)startCoordinate endCoordinate:(CLLocationCoordinate2D)endCoordinate estimatedFare:(CGFloat)estimatedFare actualFare:(CGFloat)actualFare andCompletionBlock:(void (^)(BOOL))completionBlock;

- (NSURLSessionDataTask *)postRideWithStartCoordinate:(CLLocationCoordinate2D)startCoordinate endCoordinate:(CLLocationCoordinate2D)endCoordinate driverID:(NSString *)driverID ratingID:(NSString *)ratingID estimatedFare:(CGFloat)estimatedFare actualFare:(CGFloat)actualFare andCompletionBlock:(void (^)(BOOL success))completionBlock;

@end
