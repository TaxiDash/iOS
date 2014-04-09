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

@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;
@property (weak, nonatomic) IBOutlet UILabel *costLabel;

@property (nonatomic) BOOL mapHasLoaded;
@property (nonatomic) BOOL initialAnnotationSelected;

@property (nonatomic) CLLocationCoordinate2D downtownNorthwestCoordinate;
@property (nonatomic) CLLocationCoordinate2D downtownSoutheastCoordinate;

@property (nonatomic) CLLocationCoordinate2D oprylandNorthwestCoordinate;
@property (nonatomic) CLLocationCoordinate2D oprylandSoutheastCoordinate;

@property (nonatomic) CLLocationCoordinate2D airportNorthwestCoordinate;
@property (nonatomic) CLLocationCoordinate2D airportSoutheastCoordinate;

@end

@implementation TAXRideViewController

#pragma mark - Custom Getters

- (CLLocationCoordinate2D)downtownNorthwestCoordinate {
    if (_downtownNorthwestCoordinate.latitude == 0 && _downtownNorthwestCoordinate.longitude == 0) {
        _downtownNorthwestCoordinate = CLLocationCoordinate2DMake(36.181827, -86.799433);
    }
    
    return _downtownNorthwestCoordinate;
}

- (CLLocationCoordinate2D)downtownSoutheastCoordinate {
    if (_downtownSoutheastCoordinate.latitude == 0 && _downtownSoutheastCoordinate.longitude == 0) {
        _downtownSoutheastCoordinate = CLLocationCoordinate2DMake(36.154804, -86.762697);
    }
    
    return _downtownSoutheastCoordinate;
}

- (CLLocationCoordinate2D)oprylandNorthwestCoordinate {
    if (_oprylandNorthwestCoordinate.latitude == 0 && _oprylandNorthwestCoordinate.longitude == 0) {
        _oprylandNorthwestCoordinate = CLLocationCoordinate2DMake(36.223989, -86.699693);
    }
    
    return _oprylandNorthwestCoordinate;
}

- (CLLocationCoordinate2D)oprylandSoutheastCoordinate {
    if (_oprylandSoutheastCoordinate.latitude == 0 && _oprylandSoutheastCoordinate.longitude == 0) {
        _oprylandSoutheastCoordinate = CLLocationCoordinate2DMake(36.200236, -86.683815);
    }
    
    return _oprylandSoutheastCoordinate;
}

- (CLLocationCoordinate2D)airportNorthwestCoordinate {
    if (_airportNorthwestCoordinate.latitude == 0 && _airportNorthwestCoordinate.longitude == 0) {
        _airportNorthwestCoordinate = CLLocationCoordinate2DMake(36.135563, -86.672631);
    }
    
    return _airportNorthwestCoordinate;
}

- (CLLocationCoordinate2D)airportSoutheastCoordinate {
    if (_airportSoutheastCoordinate.latitude == 0 && _airportSoutheastCoordinate.longitude == 0) {
        _airportSoutheastCoordinate = CLLocationCoordinate2DMake(36.128146, -86.666365);
    }
    
    return _airportSoutheastCoordinate;
}

#pragma mark - View Controller Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.mapHasLoaded = NO;
    self.initialAnnotationSelected = NO;
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
                self.navigationItem.hidesBackButton = YES;
                
                MKRoute *route = [response.routes firstObject];
                
                [self.mapView addOverlay:route.polyline
                                   level:MKOverlayLevelAboveRoads];
                [self.mapView setVisibleMapRect:route.polyline.boundingMapRect
                                    edgePadding:UIEdgeInsetsMake(10.0, 10.0, 10.0, 10.0)
                                       animated:YES];
                
                // Do something with estimated time and distance and calculate fare
                CLLocationDistance distanceInMiles = [self distanceInMilesForMeters:route.distance];
                
                self.distanceLabel.hidden = NO;
                self.costLabel.hidden = NO;
                
                self.distanceLabel.text = [NSString stringWithFormat:@"%.2f mi", distanceInMiles];
                self.costLabel.text = [NSString stringWithFormat:@"$%.2f", [self fareForDirectionsResponse:response
                                                                                                 withRoute:route]];
            } else {
                NSLog(@"Directions Error: %@", error);
            }
        }];
    } else { // End
        [self.presentingViewController dismissViewControllerAnimated:YES
                                                          completion:nil];
    }
}

#pragma mark - Helper Methods

- (CGFloat)fareForDirectionsResponse:(MKDirectionsResponse *)directionsResponse withRoute:(MKRoute *)route {
    CGFloat fare;
    
    // If start is in loop, Opryland, or Airport and if destination is one of those three, return 25
    CLLocationCoordinate2D startCoordinate = directionsResponse.source.placemark.coordinate;
    CLLocationCoordinate2D endCoordinate = directionsResponse.destination.placemark.coordinate;
    
    if ([self coordinateIsInSpecialRegion:startCoordinate] && [self coordinateIsInSpecialRegion:endCoordinate]) {
        fare = 25.0;
    } else { // Calculate based on $3 + mileage ($2/mile)
        CLLocationDistance distanceInMiles = [self distanceInMilesForMeters:route.distance];
        
        fare = 3 + distanceInMiles * 2;
    }
    
    // Add on additional passengers at $1/additional passenger
    fare += self.numberOfAdditionalPassengers;
    
    return fare;
}

- (BOOL)coordinateIsInSpecialRegion:(CLLocationCoordinate2D)coordinate {
    return ([self coordinate:coordinate isInRegionWithNorthwestCoordinate:self.downtownNorthwestCoordinate andSoutheastCoordinate:self.downtownSoutheastCoordinate] ||
            [self coordinate:coordinate isInRegionWithNorthwestCoordinate:self.oprylandNorthwestCoordinate andSoutheastCoordinate:self.oprylandSoutheastCoordinate] ||
            [self coordinate:coordinate isInRegionWithNorthwestCoordinate:self.airportNorthwestCoordinate andSoutheastCoordinate:self.airportSoutheastCoordinate]);
}

- (BOOL)coordinate:(CLLocationCoordinate2D)coordinate isInRegionWithNorthwestCoordinate:(CLLocationCoordinate2D)northwestCoordinate andSoutheastCoordinate:(CLLocationCoordinate2D)southeastCoordinate {
    return (coordinate.latitude >= northwestCoordinate.latitude &&
            coordinate.latitude <= southeastCoordinate.latitude &&
            coordinate.longitude >= northwestCoordinate.longitude &&
            coordinate.longitude <= southeastCoordinate.longitude);
}

- (CLLocationDistance)distanceInMilesForMeters:(CLLocationDistance)distanceInMeters {
    return distanceInMeters / 1609.34;
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
    if (!self.initialAnnotationSelected && [views count] == 1) {
        MKAnnotationView *annotationView = [views firstObject];
        
        if (![annotationView.annotation isEqual:self.mapView.userLocation]) {
            [mapView selectAnnotation:annotationView.annotation
                             animated:YES];
        }
    }
    
    self.initialAnnotationSelected = YES;
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
