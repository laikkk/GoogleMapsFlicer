//
//  ViewController.m
//  Test2
//
//  Created by Kamil Zielinski on 16/06/15.
//  Copyright (c) 2015 Kamil Zielinski. All rights reserved.
//

#import "MapViewController.h"
#import <GoogleMaps/GoogleMaps.h>
@interface MapViewController ()

@end

@implementation MapViewController
{
    GMSMapView *mapView_;
    BOOL firstLocationUpdate_;
}

@synthesize delegate;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Create a GMSCameraPosition that tells the map to display the
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:54.35
                                                            longitude:18.66
                                                                 zoom:14];
    
    mapView_ = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    mapView_.settings.compassButton = YES;
    mapView_.myLocationEnabled = YES;
    mapView_.delegate=self;
    
    // Listen to the myLocation property of GMSMapView.
    [mapView_ addObserver:self
               forKeyPath:@"myLocation"
                  options:NSKeyValueObservingOptionNew
                  context:NULL];
    
    self.view = mapView_;
    
    // Ask for My Location data after the map has already been added to the UI.
    dispatch_async(dispatch_get_main_queue(), ^{
        mapView_.myLocationEnabled = YES;
    });
    
    // Creates a marker in the center of the map.
    GMSMarker *marker = [[GMSMarker alloc] init];
    marker.position = CLLocationCoordinate2DMake(54.36, 18.66);
    marker.title = @"Gdansk";
    marker.snippet = @"Polska";
    marker.map = mapView_;
    marker.draggable = YES;
    marker.userData = @"1";
}

- (void)dealloc {
    [mapView_ removeObserver:self
                  forKeyPath:@"myLocation"
                     context:NULL];
}

-(void)mapView:(GMSMapView *)mapView didEndDraggingMarker:(GMSMarker *)marker{
    if([marker.userData  isEqual: @"1"]){
        NSLog(@"New marker location latitude: %f longtitude: %f", marker.position.latitude, marker.position.longitude);
    [self.delegate fetchFotosWithLongtitude:marker.position.longitude andLatitude:marker.position.latitude];
    }
}

#pragma mark - KVO updates

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context {
    if (!firstLocationUpdate_) {
        // If the first location update has not yet been recieved, then jump to that
        // location.
        firstLocationUpdate_ = YES;
        CLLocation *location = [change objectForKey:NSKeyValueChangeNewKey];
        mapView_.camera = [GMSCameraPosition cameraWithTarget:location.coordinate
                                                         zoom:14];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
