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

@property (nonatomic, copy) NSString *companyName;
@property (strong, nonatomic) CLBeacon *beacon;

- (instancetype)initWithCompanyName:(NSString *)companyName andBeacon:(CLBeacon *)beacon;

+ (instancetype)cabWithCompanyName:(NSString *)companyName andBeacon:(CLBeacon *)beacon;

@end
