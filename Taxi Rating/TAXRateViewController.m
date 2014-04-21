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
#import <SAMTextView/SAMTextView.h>

@interface TAXRateViewController ()

@property (nonatomic) NSInteger rating;

@property (weak, nonatomic) IBOutlet UIButton *oneStarButton;
@property (weak, nonatomic) IBOutlet UIButton *twoStarButton;
@property (weak, nonatomic) IBOutlet UIButton *threeStarButton;
@property (weak, nonatomic) IBOutlet UIButton *fourStarButton;
@property (weak, nonatomic) IBOutlet UIButton *fiveStarButton;
@property (weak, nonatomic) IBOutlet SAMTextView *commentsTextView;
@property (weak, nonatomic) IBOutlet UITextField *actualFareTextField;
@property (weak, nonatomic) IBOutlet UITextField *estimatedFareTextField;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation TAXRateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.rating = 0;
    
    self.commentsTextView.placeholder = @"Comments";
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender {
    BOOL shouldPerformSegue = YES;
    
    if ([identifier isEqualToString:@"UnwindRateDone"]) {
        if (self.rating <= 0) {
            shouldPerformSegue = NO;
            [[[UIAlertView alloc] initWithTitle:@"Rating Required"
                                        message:@"Please rate the driver before submitting your rating."
                                       delegate:nil
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil] show];
        } else if ([self.commentsTextView.text length] > 250) {
            shouldPerformSegue = NO;
            [[[UIAlertView alloc] initWithTitle:@"Comments Too Long"
                                        message:@"Please keep your comments to a maximum of 250 characters."
                                       delegate:nil
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil] show];
        }
    }
    
    return shouldPerformSegue;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"UnwindRateDone"]) {
        [[TAXClient sharedClient] postRatingForDriverID:self.driver.identifier
                                             withRating:self.rating
                                               comments:self.commentsTextView.text
                                        startCoordinate:CLLocationCoordinate2DMake(0, 0)
                                          endCoordinate:CLLocationCoordinate2DMake(1, 2)
                                          estimatedFare:[self.estimatedFareTextField.text floatValue]
                                             actualFare:[self.actualFareTextField.text floatValue]
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

- (void)keyboardWasShown:(NSNotification *)notification {
    NSDictionary *userInfo = [notification userInfo];
    CGSize keyboardSize = [[userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, keyboardSize.height, 0.0);
    self.scrollView.contentInset = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;
}

// Called when the UIKeyboardWillHideNotification is sent
- (void)keyboardWillBeHidden:(NSNotification *)notification
{
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    self.scrollView.contentInset = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;
}

@end
