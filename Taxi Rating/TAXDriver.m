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

- (instancetype)initWithFirstName:(NSString *)firstName
                       middleName:(NSString *)middleName
                         lastName:(NSString *)lastName
                      dateOfBirth:(NSString *)dateOfBirth
                             race:(NSString *)race
                              sex:(NSString *)sex
                           height:(NSUInteger)height
                           weight:(NSUInteger)weight
                          license:(NSUInteger)license
                      phoneNumber:(NSUInteger)phoneNumber
           trainingCompletionDate:(NSString *)trainingCompletionDate
             permitExpirationDate:(NSString *)permitExpirationDate
                     permitNumber:(NSUInteger)permitNumber
                           status:(NSString *)status
                            owner:(NSString *)owner
                      companyName:(NSString *)companyName
           physicalExpirationDate:(NSString *)physicalExpirationDate
                            valid:(BOOL)valid
                    averageRating:(CGFloat)averageRating
                     totalRatings:(NSUInteger)totalRatings {
    self = [super init];
    
    if (self) {
        _firstName = firstName;
        _middleName = middleName;
        _lastName = lastName;
        _dateOfBirth = dateOfBirth;
        _race = race;
        _sex = sex;
        _height = height;
        _weight = weight;
        
        _license = license;
        _phoneNumber = phoneNumber;
        _trainingCompletionDate = trainingCompletionDate;
        _permitExpirationDate = permitExpirationDate;
        _permitNumber = permitNumber;
        _status = status;
        _owner = owner;
        _companyName = companyName;
        _physicalExpirationDate = physicalExpirationDate;
        _valid = valid;
        _averageRating = averageRating;
        _totalRatings = totalRatings;
    }
    
    return self;
}

#pragma mark - Factory Method

+ (instancetype)driverWithFirstName:(NSString *)firstName
                         middleName:(NSString *)middleName
                           lastName:(NSString *)lastName
                        dateOfBirth:(NSString *)dateOfBirth
                               race:(NSString *)race
                                sex:(NSString *)sex
                             height:(NSUInteger)height
                             weight:(NSUInteger)weight
                            license:(NSUInteger)license
                        phoneNumber:(NSUInteger)phoneNumber
             trainingCompletionDate:(NSString *)trainingCompletionDate
               permitExpirationDate:(NSString *)permitExpirationDate
                       permitNumber:(NSUInteger)permitNumber
                             status:(NSString *)status
                              owner:(NSString *)owner
                        companyName:(NSString *)companyName
             physicalExpirationDate:(NSString *)physicalExpirationDate
                              valid:(BOOL)valid
                      averageRating:(CGFloat)averageRating
                       totalRatings:(NSUInteger)totalRatings {
    
    return [[self alloc] initWithFirstName:(NSString *)firstName
                                middleName:(NSString *)middleName
                                  lastName:(NSString *)lastName
                               dateOfBirth:(NSString *)dateOfBirth
                                      race:(NSString *)race
                                       sex:(NSString *)sex
                                    height:(NSUInteger)height
                                    weight:(NSUInteger)weight
                                   license:(NSUInteger)license
                               phoneNumber:(NSUInteger)phoneNumber
                    trainingCompletionDate:(NSString *)trainingCompletionDate
                      permitExpirationDate:(NSString *)permitExpirationDate
                              permitNumber:(NSUInteger)permitNumber
                                    status:(NSString *)status
                                     owner:(NSString *)owner
                               companyName:(NSString *)companyName
                    physicalExpirationDate:(NSString *)physicalExpirationDate
                                     valid:(BOOL)valid
                             averageRating:(CGFloat)averageRating
                              totalRatings:(NSUInteger)totalRatings];
}

@end
