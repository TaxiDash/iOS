//
//  TAXCabsTVCSpec.m
//  Taxi Rating
//
//  Created by Seth Friedman on 3/13/14.
//  Copyright (c) 2014 Nashville Public Works. All rights reserved.
//

#import <Specta/Specta.h>
#define EXP_SHORTHAND
#import <Expecta/Expecta.h>
#import <OCMock/OCMock.h>
#import "TAXCabsTableViewController.h"
#import "TAXLocationManagerDelegate.h"

@import CoreLocation;

SpecBegin(TAXCabsTVCTests)

describe(@"TAXCabsTableViewController", ^{
    __block TAXCabsTableViewController *vc;
    
    beforeEach(^{
        UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main"
                                                                 bundle:[NSBundle mainBundle]];
        UINavigationController *navController = [mainStoryboard instantiateInitialViewController];
        
        vc = (TAXCabsTableViewController *) navController.visibleViewController;
        
        UIView *view = vc.view;
        expect(view).toNot.beNil();
    });
    
    it(@"should be instantiated from the storyboard", ^{
        expect(vc).toNot.beNil();
        expect(vc).to.beInstanceOf([TAXCabsTableViewController class]);
        
        expect(vc.locationManager).toNot.beNil();
        expect(vc.locationManagerDelegate).toNot.beNil();
    });
    
    /*it(@"should have its cabs ordered by beacon proximity and then accuracy", ^{
        id mockBeacon1 = [OCMockObject mockForClass:[CLBeacon class]];
        [[[mockBeacon1 stub] andReturnValue:@(CLProximityImmediate)] proximity];
        [[[mockBeacon1 stub] andReturnValue:@(2.0)] valueForKeyPath:@"accuracy"];
        
        id mockBeacon2 = [OCMockObject mockForClass:[CLBeacon class]];
        [[[mockBeacon2 stub] andReturnValue:@(CLProximityImmediate)] proximity];
        [[[mockBeacon2 stub] andReturnValue:@(3.0)] valueForKeyPath:@"accuracy"];
        
        id mockBeacon3 = [OCMockObject mockForClass:[CLBeacon class]];
        [[[mockBeacon3 stub] andReturnValue:@(CLProximityNear)] proximity];
        [[[mockBeacon3 stub] andReturnValue:@(5.0)] valueForKeyPath:@"accuracy"];
        
        id mockBeacon4 = [OCMockObject mockForClass:[CLBeacon class]];
        [[[mockBeacon4 stub] andReturnValue:@(CLProximityNear)] proximity];
        [[[mockBeacon4 stub] andReturnValue:@(4.0)] valueForKeyPath:@"accuracy"];
        
        id mockBeacon5 = [OCMockObject mockForClass:[CLBeacon class]];
        [[[mockBeacon5 stub] andReturnValue:@(CLProximityFar)] proximity];
        [[[mockBeacon5 stub] andReturnValue:@(16.0)] valueForKeyPath:@"accuracy"];
        
        id mockBeacon6 = [OCMockObject mockForClass:[CLBeacon class]];
        [[[mockBeacon6 stub] andReturnValue:@(CLProximityFar)] proximity];
        [[[mockBeacon6 stub] andReturnValue:@(12.0)] valueForKeyPath:@"accuracy"];
        
        id mockBeacon7 = [OCMockObject mockForClass:[CLBeacon class]];
        [[[mockBeacon7 stub] andReturnValue:@(CLProximityFar)] proximity];
        [[[mockBeacon7 stub] andReturnValue:@(10.0)] valueForKeyPath:@"accuracy"];
        
        id mockBeacon8 = [OCMockObject mockForClass:[CLBeacon class]];
        [[[mockBeacon8 stub] andReturnValue:@(CLProximityUnknown)] proximity];
        [[[mockBeacon8 stub] andReturnValue:@(-1.0)] valueForKeyPath:@"accuracy"];
        
        NSArray *beacons = @[mockBeacon1, mockBeacon2, mockBeacon3, mockBeacon4, mockBeacon5, mockBeacon6, mockBeacon7, mockBeacon8];
        
        CLLocationManager *locationManager = [[CLLocationManager alloc] init];
        locationManager.delegate = vc.locationManagerDelegate;
        
        [locationManager.delegate locationManager:locationManager
                                  didRangeBeacons:beacons
                                         inRegion:nil];
        
        expect([vc.tableView numberOfRowsInSection:0]).to.equal(8);
        expect([vc.cabs count]).to.equal(8);
    });*/
});

SpecEnd
