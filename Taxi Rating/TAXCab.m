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

- (instancetype)initWithBeacon:(CLBeacon *)beacon {
    self = [super init];
    
    if (self) {
        _companyName = [self companyNameForBeacon:beacon];
        _beacon = beacon;
    }
    
    return self;
}

#pragma mark - Factory Method

+ (instancetype)cabWithBeacon:(CLBeacon *)beacon {
    return [[self alloc] initWithBeacon:beacon];
}

#pragma mark - NSObject Methods

- (BOOL)isEqual:(id)object {
    return (self == object) || ([object isKindOfClass:[self class]] && [self isEqualToCab:object]);
}

- (BOOL)isEqualToCab:(TAXCab *)cab {
    return [self.beacon isEqual:cab.beacon];
}

- (NSUInteger)hash {
    return [self.beacon hash];
}

- (NSString *)description {
    return [NSString stringWithFormat:@"Company Name: %@\nBeacon: %@", self.companyName, self.beacon];
}

#pragma mark - Helper Method

- (NSString *)companyNameForBeacon:(CLBeacon *)beacon {
    NSString *companyName;
    
    switch ([beacon.minor integerValue]) {
        case 1661:
            companyName = @"Music City Taxi Cab";
            break;
            
        case 1662:
            companyName = @"Allied Cab";
            break;
            
        default: // Checker Cab
            companyName = @"Nashville Checker Cab";
            break;
    }
    
    return companyName;
}

@end
