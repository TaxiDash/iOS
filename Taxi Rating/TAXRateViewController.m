//
//  TAXRateViewController.m
//  Taxi Rating
//
//  Created by Seth Friedman on 2/19/14.
//  Copyright (c) 2014 Nashville Public Works. All rights reserved.
//

#import "TAXRateViewController.h"
#import "TAXClient.h"
#import "TAXDriver.h"

@interface TAXRateViewController ()

@property (nonatomic) NSInteger rating;

@property (weak, nonatomic) IBOutlet UIButton *oneStarButton;
@property (weak, nonatomic) IBOutlet UIButton *twoStarButton;
@property (weak, nonatomic) IBOutlet UIButton *threeStarButton;
@property (weak, nonatomic) IBOutlet UIButton *fourStarButton;
@property (weak, nonatomic) IBOutlet UIButton *fiveStarButton;
@property (weak, nonatomic) IBOutlet UITextView *commentsTextView;

@end

@implementation TAXRateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.rating = 0;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender {
    BOOL shouldPerformSegue = YES;
    
    if ([identifier isEqualToString:@"UnwindRateDone"] && self.rating <= 0) {
        shouldPerformSegue = NO;
        [[[UIAlertView alloc] initWithTitle:@"Rating Required"
                                   message:@"Please rate the driver before submitting your rating."
                                  delegate:nil
                         cancelButtonTitle:@"OK"
                          otherButtonTitles:nil] show];
    }
    
    return shouldPerformSegue;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"UnwindRateDone"]) {
        [[TAXClient sharedClient] postRatingForDriverID:self.driver.identifier
                                             withRating:self.rating
                                               comments:self.commentsTextView.text
                                     andCompletionBlock:^(BOOL success) {
                                         if (success) {
                                             [[[UIAlertView alloc] initWithTitle:@"Success"
                                                                        message:@"Successfully posted rating!"
                                                                       delegate:nil
                                                              cancelButtonTitle:@"OK"
                                                               otherButtonTitles:nil] show];
                                         } else {
                                             [[[UIAlertView alloc] initWithTitle:@"Failure"
                                                                         message:@"The rating was not posted."
                                                                        delegate:nil
                                                               cancelButtonTitle:@"OK"
                                                               otherButtonTitles:nil] show];
                                         }
                                     }];
    }
}

#pragma mark - IB Actions

- (IBAction)tappedRating:(UIButton *)sender {
    if (sender == self.oneStarButton) {
        self.rating = 1;
    } else if (sender == self.twoStarButton) {
        self.rating = 2;
    } else if (sender == self.threeStarButton) {
        self.rating = 3;
    } else if (sender == self.fourStarButton) {
        self.rating = 4;
    } else {
        self.rating = 5;
    }
}

@end
