//
//  TAXDriver.h
//  Taxi Rating
//
//  Created by Seth Friedman on 2/18/14.
//  Copyright (c) 2014 Nashville Public Works. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TAXDriver : NSObject

@property (nonatomic, copy) NSString *identifier;
@property (nonatomic, copy) NSString *firstName;
@property (nonatomic, copy) NSString *middleName;
@property (nonatomic, copy) NSString *lastName;

@property (nonatomic, copy) NSString *license;
@property (nonatomic, copy) NSString *trainingCompletionDate;
@property (nonatomic, copy) NSString *permitExpirationDate;
@property (nonatomic) NSUInteger permitNumber;
@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSString *companyName;
@property (nonatomic, copy) NSString *physicalExpirationDate;
@property (nonatomic, getter = isValid) BOOL valid;
@property (nonatomic) CGFloat averageRating;
@property (nonatomic) NSUInteger totalRatings;

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
                    averageRating:(CGFloat)averageRating
                     totalRatings:(NSUInteger)totalRatings;

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
                       averageRating:(CGFloat)averageRating
                        totalRatings:(NSUInteger)totalRatings;

@end
