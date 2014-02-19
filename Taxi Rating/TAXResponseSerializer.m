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
    
    if ([secondPathComponent isEqualToString:@"drivers"]) {
        if (![secondPathComponent isEqualToString:lastPathComponent]) {
            NSDictionary *driverResponseDictionary = responseObject;
            
            responseObject = [TAXDriver driverWithIdentifier:[driverResponseDictionary[@"id"] stringValue]
                                                   firstName:driverResponseDictionary[@"first_name"]
                                                  middleName:driverResponseDictionary[@"middle_name"]
                                                    lastName:driverResponseDictionary[@"last_name"]
                                                 dateOfBirth:driverResponseDictionary[@"dob"]
                                                        race:driverResponseDictionary[@"race"]
                                                         sex:driverResponseDictionary[@"sex"]
                                                      height:[driverResponseDictionary[@"height"] integerValue]
                                                      weight:[driverResponseDictionary[@"weight"] integerValue]
                                                     license:[driverResponseDictionary[@"license"] integerValue]
                                                 phoneNumber:[driverResponseDictionary[@"phone_number"] integerValue]
                                      trainingCompletionDate:driverResponseDictionary[@"training_completion_date"]
                                        permitExpirationDate:driverResponseDictionary[@"permit_expiration_date"]
                                                permitNumber:[driverResponseDictionary[@"permit_number"] integerValue]
                                                      status:driverResponseDictionary[@"status"]
                                                       owner:driverResponseDictionary[@"owner"]
                                                 companyName:driverResponseDictionary[@"company_name"]
                                      physicalExpirationDate:driverResponseDictionary[@"physical_expiration_date"]
                                                       valid:driverResponseDictionary[@"valid"]
                                               averageRating:[driverResponseDictionary[@"average_rating"] floatValue]
                                                totalRatings:[driverResponseDictionary[@"total_ratings"] integerValue]];
        }
    }
    
    return responseObject;
}

@end
