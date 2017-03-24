//
//  ViewController.m
//  AnnotationTintBug
//
//  Created by Matthew Kiazyk on 2017-03-24.
//  Copyright © 2017 Robots & Pencils Inc. All rights reserved.
//

#import "ViewController.h"
#import <Mapbox/Mapbox.h>
#import "BOAssetAnnotationView.h"
#import "PopupViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet MGLMapView *mapView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self reloadAnnotations];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    [self.mapView setCenterCoordinate:CLLocationCoordinate2DMake(40.262162, -79.420944) zoomLevel:self.mapView.maximumZoomLevel animated:YES];
}

- (MGLPointFeature *)defaultAnnotation {
    MGLPointFeature *annotation = [[MGLPointFeature alloc] init];
    annotation.attributes = @{@"asset": @"my object"};
    annotation.coordinate = CLLocationCoordinate2DMake(40.262162, -79.420944);
    annotation.title = @"Test annotation";
    return annotation;
}

- (void)reloadAnnotations {
    [self.mapView removeAnnotations:self.mapView.annotations];
    [self.mapView addAnnotation:[self defaultAnnotation]];
}

- (IBAction)reloadAnnotations:(id)sender {
    [self reloadAnnotations];
}

#pragma mark - mapviewdelegate

- (MGLAnnotationView *)mapView:(MGLMapView *)mapView viewForAnnotation:(id<MGLAnnotation>)annotation {

    if ([annotation isKindOfClass:[MGLUserLocation class]]) {
        return nil;
    }
    //MGLPointFeature *assetFeature = (MGLPointFeature *)annotation;

    NSString *reuseIdentifier = [NSString stringWithFormat:@"%@", @"Test"];
    BOAssetAnnotationView *annotationView = [mapView dequeueReusableAnnotationViewWithIdentifier:reuseIdentifier];
    if (!annotationView) {
        annotationView = [[BOAssetAnnotationView alloc] initWithReuseIdentifier:reuseIdentifier];
    }

    return annotationView;
}

- (BOOL)mapView:(MGLMapView *)mapView annotationCanShowCallout:(id<MGLAnnotation>)annotation {
    if ([annotation isKindOfClass:[MGLUserLocation class]]) {
        return NO;
    }

    return YES;
}

- (void)mapView:(MGLMapView *)mapView tapOnCalloutForAnnotation:(id<MGLAnnotation>)annotation {

    PopupViewController *vc = [[PopupViewController alloc] init];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:vc];
    navController.modalPresentationStyle = UIModalPresentationFormSheet;

    [self presentViewController:navController animated:YES completion:nil];
}

@end
