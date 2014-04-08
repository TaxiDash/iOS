//
//  TAXDestinationViewController.m
//  Taxi Rating
//
//  Created by Seth Friedman on 4/8/14.
//  Copyright (c) 2014 Nashville Public Works. All rights reserved.
//

#import "TAXDestinationViewController.h"
#import "TAXRideViewController.h"

@interface TAXDestinationViewController ()

@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation TAXDestinationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.textView.translatesAutoresizingMaskIntoConstraints = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"PushRide"]) {
        [segue.destinationViewController setDestination:self.textView.text];
    }
}

@end
