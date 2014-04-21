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
#import <AFNetworking/UIImageView+AFNetworking.h>

@import CoreLocation;

static NSString * const kDriverImageURLString = @"http://taxi-rating-server.herokuapp.com/mobile/images/drivers/";

@interface TAXDriverViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *ratingLabel;
@property (weak, nonatomic) IBOutlet UILabel *validLabel;

// TODO - This is an absolutely terrible property and terrible way of getting the user
// back to the list of cabs after rating. However, I'm pressed for time at the moment.
// This should be removed in the future.
@property (nonatomic, assign) BOOL userDidRate;

@end

@implementation TAXDriverViewController

#pragma mark - View Controller Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.userDidRate = NO;
    
    self.navigationController.navigationBar.barTintColor = [UIColor darkGrayColor];
    
    if (self.driver) {
        NSURL *imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@.json", self.driver.beacon.minor]
                                 relativeToURL:[NSURL URLWithString:kDriverImageURLString]];
        
        [self.imageView setImageWithURL:imageURL
                       placeholderImage:nil];
        
        self.title = [NSString stringWithFormat:@"%@ %@", self.driver.firstName, self.driver.lastName];
        self.ratingLabel.text = [NSString stringWithFormat:@"%.1f", self.driver.averageRating];
        self.validLabel.text = self.driver.isValid ? @"Valid License" : @"Invalid License";
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    if (self.userDidRate) {
        [self.navigationController popViewControllerAnimated:YES];
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

// Unwind segue
- (IBAction)userDidCancelRating:(UIStoryboardSegue *)segue {}

// Unwind segue
- (IBAction)userDidCancelRide:(UIStoryboardSegue *)segue {}

// Unwind segue
- (IBAction)userDidRate:(UIStoryboardSegue *)segue {
    self.userDidRate = YES;
}

@end
