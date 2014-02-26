//
//  TAXCab.m
//  Taxi Rating
//
//  Created by Seth Friedman on 2/26/14.
//  Copyright (c) 2014 Nashville Public Works. All rights reserved.
//

#import "TAXCab.h"

@import CoreLocation;

@implementation TAXCab

#pragma mark - Designated Initializer

- (instancetype)initWithCompanyName:(NSString *)companyName andBeacon:(CLBeacon *)beacon {
    self = [super init];
    
    if (self) {
        _companyName = companyName;
        _beacon = beacon;
    }
    
    return self;
}

#pragma mark - Factory Method

+ (instancetype)cabWithCompanyName:(NSString *)companyName andBeacon:(CLBeacon *)beacon {
    return [[self alloc] initWithCompanyName:companyName
                                   andBeacon:beacon];
}

#pragma mark - NSObject Methods

- (BOOL)isEqual:(id)object {
    return (self == object) || ([object isKindOfClass:[self class]] && [self isEqualToCab:object]);
}

- (BOOL)isEqualToCab:(TAXCab *)cab {
    return [self.companyName isEqualToString:cab.companyName] && [self.beacon isEqual:cab.beacon];
}

- (NSUInteger)hash {
    return [self.companyName hash] ^ [self.beacon hash];
}

- (NSString *)description {
    return [NSString stringWithFormat:@"Company Name: %@\nBeacon: %@", self.companyName, self.beacon];
}

@end
