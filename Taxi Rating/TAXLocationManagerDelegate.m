//
//  TAXLocationManagerDelegate.m
//  Taxi Rating
//
//  Created by Seth Friedman on 2/27/14.
//  Copyright (c) 2014 Nashville Public Works. All rights reserved.
//

#import "TAXLocationManagerDelegate.h"

@interface TAXLocationManagerDelegate ()

@property (nonatomic, copy) void (^didRangeBeaconsBlock)(NSArray *beacons);
@property (nonatomic, copy) void (^rangingBeaconsDidFailBlock)(void);

@end

@implementation TAXLocationManagerDelegate

#pragma mark - Designated Initializer

- (instancetype)initWithDidRangeBeaconsBlock:(void (^)(NSArray *))didRangeBeaconsBlock andRangingBeaconsDidFailBlock:(void (^)(void))rangingBeaconsDidFailBlock {
    self = [super init];
    
    if (self) {
        _didRangeBeaconsBlock = didRangeBeaconsBlock;
        _rangingBeaconsDidFailBlock = rangingBeaconsDidFailBlock;
    }
    
    return self;
}

#pragma mark - Factory Method

+ (instancetype)locationManagerDelegateWithDidRangeBeaconsBlock:(void (^)(NSArray *))didRangeBeaconsBlock andRangingBeaconsDidFailBlock:(void (^)(void))rangingBeaconsDidFailBlock {
    return [[self alloc] initWithDidRangeBeaconsBlock:didRangeBeaconsBlock
                        andRangingBeaconsDidFailBlock:rangingBeaconsDidFailBlock];
}

#pragma mark - Location Manager Delegate

- (void)locationManager:(CLLocationManager *)manager didRangeBeacons:(NSArray *)beacons inRegion:(CLBeaconRegion *)region {
    NSLog(@"Beacons ranged");
    
    if ([beacons count]) {
        self.didRangeBeaconsBlock(beacons);
        
        [manager stopRangingBeaconsInRegion:region];
    }
}

- (void)locationManager:(CLLocationManager *)manager rangingBeaconsDidFailForRegion:(CLBeaconRegion *)region withError:(NSError *)error {
    self.rangingBeaconsDidFailBlock();
    
    switch (error.code) {
        case 16:
            [[[UIAlertView alloc] initWithTitle:@"Bluetooth Failed"
                                        message:@"Unfortunately, something's wrong with your Bluetooth, and the only solution is to turn your device off and back on again. We're sorry for the inconvenience, and we hope Apple corrects this bug soon!"
                                       delegate:nil
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil] show];
            break;
            
        default:
            [[[UIAlertView alloc] initWithTitle:@"Bluetooth Disabled"
                                        message:@"Your Bluetooth may be disabled. Please turn this back on, or the app will not be able to locate nearby cabs for you."
                                       delegate:nil
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil] show];
            break;
    }
}

@end
