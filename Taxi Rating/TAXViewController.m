//
//  TAXViewController.m
//  Taxi Rating
//
//  Created by Seth Friedman on 2/5/14.
//  Copyright (c) 2014 Nashville Public Works. All rights reserved.
//

#import "TAXViewController.h"
#import "TAXClient.h"

@interface TAXViewController ()

@end

@implementation TAXViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IB Action

- (IBAction)submitRequestTapped:(UIButton *)sender {
    [[TAXClient sharedClient] fetchTestWithCompletionBlock:^(BOOL success, id responseObject) {
        if (success) {
            [[[UIAlertView alloc] initWithTitle:@"Success"
                                       message:[NSString stringWithFormat:@"Successfully connected to the server.\nName: %@\nID: %@", responseObject[@"name"], responseObject[@"id"]]
                                      delegate:nil
                             cancelButtonTitle:@"OK"
                             otherButtonTitles:nil] show];
        } else {
            [[[UIAlertView alloc] initWithTitle:@"Failure"
                                       message:@"Failed to connect to the server"
                                      delegate:nil
                             cancelButtonTitle:@"OK"
                              otherButtonTitles:nil] show];
        }
    }];
}

@end
