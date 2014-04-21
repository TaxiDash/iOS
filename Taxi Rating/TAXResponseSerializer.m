//
//  TAXResponseSerializer.m
//  Taxi Rating
//
//  Created by Seth Friedman on 2/18/14.
//  Copyright (c) 2014 Nashville Public Works. All rights reserved.
//

#import "TAXResponseSerializer.h"
#import "TAXDriver.h"

@implementation TAXResponseSerializer

- (id)responseObjectForResponse:(NSURLResponse *)response data:(NSData *)data error:(NSError *__autoreleasing *)error {
    id responseObject = [super responseObjectForResponse:response
                                                    data:data
                                                   error:error];
    
    NSString *secondPathComponent = response.URL.pathComponents[1];
    NSString *lastPathComponent = response.URL.lastPathComponent;
    
    if ([secondPathComponent isEqualToString:@"mobile"]) {
        if (![secondPathComponent isEqualToString:lastPathComponent]) {
            NSDictionary *driverResponseDictionary = responseObject;
            
            responseObject = [TAXDriver driverWithIdentifier:[driverResponseDictionary[@"id"] stringValue]
                                                   firstName:driverResponseDictionary[@"first_name"]
                                                  middleName:driverResponseDictionary[@"middle_name"]
                                                    lastName:driverResponseDictionary[@"last_name"]
                                                     license:driverResponseDictionary[@"license"]
                                      trainingCompletionDate:driverResponseDictionary[@"training_completion_date"]
                                        permitExpirationDate:driverResponseDictionary[@"permit_expiration_date"]
                                                permitNumber:[driverResponseDictionary[@"permit_number"] integerValue]
                                                      status:driverResponseDictionary[@"status"]
                                                 companyName:driverResponseDictionary[@"company"][@"name"]
                                      physicalExpirationDate:driverResponseDictionary[@"physical_expiration_date"]
                                                       valid:driverResponseDictionary[@"valid"]
                                                      beacon:nil
                                               averageRating:[self floatFromPotentiallyNullNumber:driverResponseDictionary[@"average_rating"]]
                                                totalRatings:[self integerFromPotentiallyNullNumber:driverResponseDictionary[@"total_ratings"]]];
        }
    }
    
    return responseObject;
}

#pragma mark - Helper Methods

// Returns 0 if NSNull
- (CGFloat)floatFromPotentiallyNullNumber:(NSNumber *)number {
    CGFloat floatValue = 0;
    
    if ((id)number != [NSNull null]) {
        floatValue = [number floatValue];
    }
    
    return floatValue;
}

// Returns 0 if NSNull
- (NSInteger)integerFromPotentiallyNullNumber:(NSNumber *)number {
    NSInteger integerValue = 0;
    
    if ((id)number != [NSNull null]) {
        integerValue = [number integerValue];
    }
    
    return integerValue;
}

@end
