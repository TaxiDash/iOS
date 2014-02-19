//
//  TAXDriver.h
//  Taxi Rating
//
//  Created by Seth Friedman on 2/18/14.
//  Copyright (c) 2014 Nashville Public Works. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TAXDriver : NSObject

@property (nonatomic, copy) NSString *firstName;
@property (nonatomic, copy) NSString *middleName;
@property (nonatomic, copy) NSString *lastName;
@property (nonatomic, copy) NSString *dateOfBirth;
@property (nonatomic, copy) NSString *race;
@property (nonatomic, copy) NSString *sex;
@property (nonatomic) NSUInteger height;
@property (nonatomic) NSUInteger weight;

@property (nonatomic) NSUInteger license; // This should maybe be a string?
@property (nonatomic) NSUInteger phoneNumber; // This should be a string
@property (nonatomic, copy) NSString *trainingCompletionDate;
@property (nonatomic, copy) NSString *permitExpirationDate;
@property (nonatomic) NSUInteger permitNumber;
@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSString *owner;
@property (nonatomic, copy) NSString *companyName;
@property (nonatomic, copy) NSString *physicalExpirationDate;
@property (nonatomic, getter = isValid) BOOL valid;
@property (nonatomic) CGFloat averageRating;
@property (nonatomic) NSUInteger totalRatings;

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
                     totalRatings:(NSUInteger)totalRatings;

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
                       totalRatings:(NSUInteger)totalRatings;

@end
