//
//  TAXDriver.m
//  Taxi Rating
//
//  Created by Seth Friedman on 2/18/14.
//  Copyright (c) 2014 Nashville Public Works. All rights reserved.
//

#import "TAXDriver.h"

@implementation TAXDriver

#pragma mark - Designated Initializer

- (instancetype)initWithIdentifier:(NSString *)identifier
                         firstName:(NSString *)firstName
                        middleName:(NSString *)middleName
                          lastName:(NSString *)lastName
                           license:(NSString *)license
            trainingCompletionDate:(NSString *)trainingCompletionDate
              permitExpirationDate:(NSString *)permitExpirationDate
                      permitNumber:(NSUInteger)permitNumber
                            status:(NSString *)status
                       companyName:(NSString *)companyName
            physicalExpirationDate:(NSString *)physicalExpirationDate
                             valid:(BOOL)valid
                            beacon:(CLBeacon *)beacon
                     averageRating:(CGFloat)averageRating
                      totalRatings:(NSUInteger)totalRatings; {
    self = [super init];
    
    if (self) {
        _identifier = identifier;
        _firstName = firstName;
        _middleName = middleName;
        _lastName = lastName;
        
        _license = license;
        _trainingCompletionDate = trainingCompletionDate;
        _permitExpirationDate = permitExpirationDate;
        _permitNumber = permitNumber;
        _status = status;
        _companyName = companyName;
        _physicalExpirationDate = physicalExpirationDate;
        _valid = valid;
        _beacon = beacon;
        _averageRating = averageRating;
        _totalRatings = totalRatings;
    }
    
    return self;
}

#pragma mark - Factory Method

+ (instancetype)driverWithIdentifier:(NSString *)identifier
                           firstName:(NSString *)firstName
                          middleName:(NSString *)middleName
                            lastName:(NSString *)lastName
                             license:(NSString *)license
              trainingCompletionDate:(NSString *)trainingCompletionDate
                permitExpirationDate:(NSString *)permitExpirationDate
                        permitNumber:(NSUInteger)permitNumber
                              status:(NSString *)status
                         companyName:(NSString *)companyName
              physicalExpirationDate:(NSString *)physicalExpirationDate
                               valid:(BOOL)valid
                              beacon:(CLBeacon *)beacon
                       averageRating:(CGFloat)averageRating
                        totalRatings:(NSUInteger)totalRatings; {
    
    return [[self alloc] initWithIdentifier:identifier
                                  firstName:firstName
                                 middleName:middleName
                                   lastName:lastName
                                    license:license
                     trainingCompletionDate:trainingCompletionDate
                       permitExpirationDate:permitExpirationDate
                               permitNumber:permitNumber
                                     status:status
                                companyName:companyName
                     physicalExpirationDate:physicalExpirationDate
                                      valid:valid
                                     beacon:beacon
                              averageRating:averageRating
                               totalRatings:totalRatings];
}

#pragma mark - NSObject

- (BOOL)isEqual:(id)object {
    return (self == object) || ([object isKindOfClass:[self class]] && [self isEqualToDriver:object]);
}

- (NSUInteger)hash {
    return [self.firstName hash] ^ [self.lastName hash];
}

#pragma mark - Helper Method

- (BOOL)isEqualToDriver:(TAXDriver *)driver {
    return [self.firstName isEqualToString:driver.firstName] && [self.lastName isEqualToString:driver.lastName];
}

@end
