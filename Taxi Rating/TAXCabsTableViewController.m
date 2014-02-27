//
//  TAXCabsTableViewController.m
//  Taxi Rating
//
//  Created by Seth Friedman on 2/26/14.
//  Copyright (c) 2014 Nashville Public Works. All rights reserved.
//

#import "TAXCabsTableViewController.h"
#import "TAXCab.h"
#import "TAXDriverViewController.h"

@import CoreLocation;

@interface TAXCabsTableViewController () <CLLocationManagerDelegate>

@property (nonatomic, copy) NSArray *cabs;

@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) CLBeaconRegion *beaconRegion;

@end

@implementation TAXCabsTableViewController

#pragma mark - Custom Getter

- (CLBeaconRegion *)beaconRegion {
    if (!_beaconRegion) {
        _beaconRegion = [[CLBeaconRegion alloc] initWithProximityUUID:[[NSUUID alloc] initWithUUIDString:@"8DEEFBB9-F738-4297-8040-96668BB44281"]
                                                           identifier:@"cabs"];
    }
    
    return _beaconRegion;
}

#pragma mark - Custom Setter

- (void)setCabs:(NSArray *)cabs {
    if (![_cabs isEqualToArray:cabs]) {
        _cabs = cabs;
        
        [self.tableView reloadData];
    }
}

#pragma mark - View Controller Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    
    [self refresh];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table View Data Source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.cabs count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"CabCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    TAXCab *cab = self.cabs[indexPath.row];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@ - %@", cab.companyName, cab.beacon.minor];
    
    return cell;
}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"PushDriver"]) {
        if ([segue.destinationViewController isKindOfClass:[TAXDriverViewController class]]) {
            TAXDriverViewController *driverViewController = segue.destinationViewController;
            
            if ([sender isKindOfClass:[UITableViewCell class]]) {
                UITableViewCell *cell = sender;
                NSIndexPath *cellIndexPath = [self.tableView indexPathForCell:cell];
                
                TAXCab *cab = self.cabs[cellIndexPath.row];
                driverViewController.beacon = cab.beacon;
            }
        }
    }
}

#pragma mark - IB Action

- (IBAction)userDidRefresh:(UIRefreshControl *)sender {
    [self refresh];
}

#pragma mark - Core Location Delegate

/*- (void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region {
    if ([region isKindOfClass:[CLBeaconRegion class]]) {
        NSLog(@"Region entered");
        
        [manager startRangingBeaconsInRegion:(CLBeaconRegion *)region];
    }
}

- (void)locationManager:(CLLocationManager *)manager didExitRegion:(CLRegion *)region {
    if ([region isKindOfClass:[CLBeaconRegion class]]) {
        NSLog(@"Region exited");
    }
}

- (void)locationManager:(CLLocationManager *)manager monitoringDidFailForRegion:(CLRegion *)region withError:(NSError *)error {
    NSLog(@"Monitoring Error: %@", error);
}*/

- (void)locationManager:(CLLocationManager *)manager didRangeBeacons:(NSArray *)beacons inRegion:(CLBeaconRegion *)region {
    NSLog(@"Beacons ranged");
    
    if ([beacons count]) {
        [self.refreshControl endRefreshing];
        
        NSMutableArray *cabs = [NSMutableArray arrayWithCapacity:[beacons count]];
        
        for (CLBeacon *beacon in beacons) {
            [cabs addObject:[TAXCab cabWithCompanyName:@"Allied"
                                             andBeacon:beacon]];
        }
        
        self.cabs = [cabs copy];
        
        [manager stopRangingBeaconsInRegion:region];
    }
}

- (void)locationManager:(CLLocationManager *)manager rangingBeaconsDidFailForRegion:(CLBeaconRegion *)region withError:(NSError *)error {
    [self.refreshControl endRefreshing];
    
    [[[UIAlertView alloc] initWithTitle:@"Bluetooth Disabled"
                                message:@"Your Bluetooth may be disabled. Please turn this back on, or the app will not be able to locate nearby cabs for you."
                               delegate:nil
                      cancelButtonTitle:@"OK"
                      otherButtonTitles:nil] show];
}

#pragma mark - Helper Method

- (void)refresh {
    // If Location Services have been disabled, warn the user. Otherwise, start searching for beacons.
    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied) {
        NSString *appName = [[NSBundle mainBundle] infoDictionary][(NSString *)kCFBundleNameKey];
        
        [[[UIAlertView alloc] initWithTitle:@"Location Services Disabled"
                                    message:[NSString stringWithFormat:@"It looks like you have disabled Location Services for %@. Please go to Settings > Privacy > Location Services and turn these back on, or the app will not be able to locate nearby cabs for you.", appName]
                                   delegate:nil
                          cancelButtonTitle:@"OK"
                          otherButtonTitles:nil] show];
    } else {
        [self.locationManager startRangingBeaconsInRegion:self.beaconRegion];
    }
}

@end
