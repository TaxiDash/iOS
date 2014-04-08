//
//  TAXDestinationViewController.m
//  Taxi Rating
//
//  Created by Seth Friedman on 4/8/14.
//  Copyright (c) 2014 Nashville Public Works. All rights reserved.
//

#import "TAXDestinationViewController.h"

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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
