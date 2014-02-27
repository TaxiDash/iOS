//
//  TAXLocationManagerDelegate.h
//  Taxi Rating
//
//  Created by Seth Friedman on 2/27/14.
//  Copyright (c) 2014 Nashville Public Works. All rights reserved.
//

#import <Foundation/Foundation.h>

@import CoreLocation;

@interface TAXLocationManagerDelegate : NSObject <CLLocationManagerDelegate>

- (instancetype)initWithDidRangeBeaconsBlock:(void (^)(NSArray *beacons))didRangeBeaconsBlock andRangingBeaconsDidFailBlock:(void (^)(void))rangingBeaconsDidFailBlock;

+ (instancetype)locationManagerDelegateWithDidRangeBeaconsBlock:(void (^)(NSArray *beacons))didRangeBeaconsBlock andRangingBeaconsDidFailBlock:(void (^)(void))rangingBeaconsDidFailBlock;

@end
