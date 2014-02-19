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

@interface TAXDriverViewController ()

@property (strong, nonatomic) TAXDriver *driver;

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *ratingLabel;
@property (weak, nonatomic) IBOutlet UILabel *validLabel;

@end

@implementation TAXDriverViewController

#pragma mark - Custom Setter

- (void)setDriver:(TAXDriver *)driver {
    if (![_driver isEqual:driver]) {
        _driver = driver;
        
        self.title = [NSString stringWithFormat:@"%@ %@", driver.firstName, driver.lastName];
        self.ratingLabel.text = [NSString stringWithFormat:@"%.1f", driver.averageRating];
        self.validLabel.text = driver.isValid ? @"Valid" : @"Not Valid";
    }
}

#pragma mark - View Controller Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[TAXClient sharedClient] fetchDriverWithID:@"1"
                             andCompletionBlock:^(BOOL success, TAXDriver *driver) {
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IB Actions

- (IBAction)userDidRate:(UIStoryboardSegue *)segue {}

- (IBAction)userDidCancelRating:(UIStoryboardSegue *)segue {}

@end
