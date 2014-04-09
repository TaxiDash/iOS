//
//  TAXViewController.m
//  Taxi Rating
//
//  Created by Seth Friedman on 2/5/14.
//  Copyright (c) 2014 Nashville Public Works. All rights reserved.
//

#import "TAXDriverViewController.h"
#import "TAXClient.h"
#import "TAXDriver.h"
#import "TAXRateViewController.h"

@import CoreLocation;

@interface TAXDriverViewController ()

@property (strong, nonatomic) TAXDriver *driver;

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *ratingLabel;
@property (weak, nonatomic) IBOutlet UILabel *validLabel;
@property (weak, nonatomic) IBOutlet UIButton *rideButton;

@end

@implementation TAXDriverViewController

#pragma mark - Custom Setter

- (void)setDriver:(TAXDriver *)driver {
    if (![_driver isEqual:driver]) {
        _driver = driver;
        
        self.title = [NSString stringWithFormat:@"%@ %@", driver.firstName, driver.lastName];
        self.ratingLabel.text = [NSString stringWithFormat:@"%.1f", driver.averageRating];
        self.validLabel.text = driver.isValid ? @"Valid License" : @"Invalid License";
    }
}

#pragma mark - View Controller Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.beacon) {
        [[TAXClient sharedClient] fetchDriverWithBeaconID:self.beacon.minor
                                      withCompletionBlock:^(BOOL success, TAXDriver *driver) {
                                          if (success) {
                                              self.driver = driver;
                                          } else {
                                              [[[UIAlertView alloc] initWithTitle:@"Failure"
                                                                          message:@"Failed to connect to the server"
                                                                         delegate:nil
                                                                cancelButtonTitle:@"OK"
                                                                otherButtonTitles:nil] show];
                                          }
                                      }];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"PresentRate"]) {
        UINavigationController *navigationViewController = segue.destinationViewController;
        TAXRateViewController *rateViewController = navigationViewController.childViewControllers[0];
        
        rateViewController.driver = self.driver;
    }
}

#pragma mark - IB Actions

- (IBAction)rideTapped:(UIButton *)sender {
    /*if ([sender.titleLabel.text isEqualToString:@"Ride"]) {
        sender.enabled = NO;
        
        // TODO - Get rid of this timer, and end the ride only when the user
        // has traveled a sufficient distance.
        [NSTimer scheduledTimerWithTimeInterval:5.0
                                         target:self
                                       selector:@selector(endRide)
                                       userInfo:nil
                                        repeats:NO];
    } else if ([sender.titleLabel.text isEqualToString:@"Rate"]) {
        [self performSegueWithIdentifier:@"PresentRate"
                                  sender:sender];
    }*/
}

// Unwind segue
- (IBAction)userDidRate:(UIStoryboardSegue *)segue {
    [self.rideButton setTitle:@"Ride"
                     forState:UIControlStateNormal];
}

// Unwind segue
- (IBAction)userDidCancelRating:(UIStoryboardSegue *)segue {}

#pragma mark - Helper Method

- (void)endRide {
    [self.rideButton setTitle:@"Rate"
                     forState:UIControlStateNormal];
    self.rideButton.enabled = YES;
}

@end
