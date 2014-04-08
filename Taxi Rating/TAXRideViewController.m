//
//  TAXRideViewController.m
//  Taxi Rating
//
//  Created by Seth Friedman on 4/8/14.
//  Copyright (c) 2014 Nashville Public Works. All rights reserved.
//

#import "TAXRideViewController.h"

@import MapKit;

@interface TAXRideViewController ()

@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@end

@implementation TAXRideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.hidesBackButton = YES;
    
    MKMapItem *startItem = [MKMapItem mapItemForCurrentLocation];
    
    MKLocalSearchRequest *localSearchRequest = [[MKLocalSearchRequest alloc] init];
    localSearchRequest.naturalLanguageQuery = self.destination;
    // TODO - See what the radius is of Nashville in meters
    localSearchRequest.region = MKCoordinateRegionMakeWithDistance(self.mapView.userLocation.coordinate, 5000, 5000);
    
    MKLocalSearch *localSearch = [[MKLocalSearch alloc] initWithRequest:localSearchRequest];
    
    [localSearch startWithCompletionHandler:^(MKLocalSearchResponse *response, NSError *error) {
        if (!error) {
            NSMutableArray *placemarks = [NSMutableArray arrayWithCapacity:[response.mapItems count]];
            
            for (MKMapItem *item in response.mapItems) {
                [placemarks addObject:item.placemark];
                
                [self.mapView removeAnnotations:self.mapView.annotations];
                [self.mapView showAnnotations:placemarks
                                     animated:YES];
            }
        }
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IB Action

- (IBAction)endTapped:(UIBarButtonItem *)sender {
    [self.presentingViewController dismissViewControllerAnimated:YES
                                                      completion:nil];
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
