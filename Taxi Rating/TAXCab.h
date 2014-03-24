//
//  TAXCab.h
//  Taxi Rating
//
//  Created by Seth Friedman on 2/26/14.
//  Copyright (c) 2014 Nashville Public Works. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CLBeacon;

@interface TAXCab : NSObject

@property (strong, nonatomic, readonly) NSString *companyName;
@property (strong, nonatomic, readonly) CLBeacon *beacon;

- (instancetype)initWithBeacon:(CLBeacon *)beacon;

+ (instancetype)cabWithBeacon:(CLBeacon *)beacon;

@end
