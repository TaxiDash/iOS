//
//  TAXCabsTableViewController.h
//  Taxi Rating
//
//  Created by Seth Friedman on 2/26/14.
//  Copyright (c) 2014 Nashville Public Works. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CLLocationManager;
@class TAXLocationManagerDelegate;

@interface TAXCabsTableViewController : UITableViewController

@property (nonatomic, copy, readonly) NSArray *cabs;

@property (strong, nonatomic, readonly) CLLocationManager *locationManager;

@property (strong, nonatomic, readonly) TAXLocationManagerDelegate *locationManagerDelegate;

@end
