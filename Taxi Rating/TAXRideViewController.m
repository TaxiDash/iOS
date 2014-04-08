//
//  TAXRideViewController.m
//  Taxi Rating
//
//  Created by Seth Friedman on 4/8/14.
//  Copyright (c) 2014 Nashville Public Works. All rights reserved.
//

#import "TAXRideViewController.h"

@import MapKit;

@interface TAXRideViewController () <MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *actionBarButtonItem;

@property (nonatomic) BOOL mapHasLoaded;

@end

@implementation TAXRideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.hidesBackButton = YES;
    
    self.mapHasLoaded = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IB Action

- (IBAction)actionButtonTapped:(UIBarButtonItem *)sender {
    if ([sender.title isEqualToString:@"Route"]) {
        sender.title = @"End";
        
        MKDirectionsRequest *directionsRequest = [[MKDirectionsRequest alloc] init];
        directionsRequest.source = [MKMapItem mapItemForCurrentLocation];
        directionsRequest.destination = [[MKMapItem alloc] initWithPlacemark:[self.mapView.selectedAnnotations firstObject]];
        
        MKDirections *directions = [[MKDirections alloc] initWithRequest:directionsRequest];
        
        [directions calculateDirectionsWithCompletionHandler:^(MKDirectionsResponse *response, NSError *error) {
            if (!error) {
                MKRoute *route = [response.routes firstObject];
                
                [self.mapView addOverlay:route.polyline
                                   level:MKOverlayLevelAboveRoads];
                [self.mapView setVisibleMapRect:route.polyline.boundingMapRect
                                    edgePadding:UIEdgeInsetsMake(10.0, 10.0, 10.0, 10.0)
                                       animated:YES];
                
                // Do something with estimated time and distance and calculate fare
            } else {
                NSLog(@"Directions Error: %@", error);
            }
        }];
    } else { // End
        [self.presentingViewController dismissViewControllerAnimated:YES
                                                          completion:nil];
    }
}

#pragma mark - Map View Delegate

- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view {
    self.actionBarButtonItem.enabled = YES;
}

- (void)mapView:(MKMapView *)mapView didDeselectAnnotationView:(MKAnnotationView *)view {
    if ([self.actionBarButtonItem.title isEqualToString:@"Route"]) {
        self.actionBarButtonItem.enabled = NO;
    }
}

- (MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay {
    MKPolylineRenderer *renderer = [[MKPolylineRenderer alloc] initWithOverlay:overlay];
    renderer.strokeColor = [UIColor blueColor];
    renderer.lineWidth = 5.0;
    
    return renderer;
}

- (void)mapView:(MKMapView *)mapView didAddAnnotationViews:(NSArray *)views {
    if ([views count] == 1) {
        MKAnnotationView *annotationView = [views firstObject];
        
        if (![annotationView.annotation isEqual:self.mapView.userLocation]) {
            [mapView selectAnnotation:annotationView.annotation
                             animated:YES];
        }
    }
}

- (void)mapViewDidFinishLoadingMap:(MKMapView *)mapView {
    if (!self.mapHasLoaded) {
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
                }
                
                [self.mapView removeAnnotations:self.mapView.annotations];
                [self.mapView showAnnotations:placemarks
                                     animated:YES];
                
                self.mapHasLoaded = YES;
            }
        }];
    }
}

@end
