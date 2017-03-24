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
#import "CustomAnnotationView.h"

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
    annotation.title = @"Custom annotation";
    return annotation;
}

- (void)reloadAnnotations {
    [self.mapView removeAnnotations:self.mapView.annotations];
    [self.mapView addAnnotation:[self defaultAnnotation]];

    // Testing regular pointAnnotation instead of PointFeature
    MGLPointAnnotation *regularAnnotation = [[MGLPointAnnotation alloc] init];
    regularAnnotation.coordinate = CLLocationCoordinate2DMake(40.262163, -79.420844);
    regularAnnotation.title = @"Regular annotation";

    [self.mapView addAnnotation:regularAnnotation];
}

- (IBAction)reloadAnnotations:(id)sender {
    [self reloadAnnotations];
}

#pragma mark - mapviewdelegate

- (MGLAnnotationView *)mapView:(MGLMapView *)mapView viewForAnnotation:(id<MGLAnnotation>)annotation {

    if ([annotation isKindOfClass:[MGLUserLocation class]]) {
        return nil;
    }

    NSString *reuseIdentifier = [NSString stringWithFormat:@"%@", @(annotation.coordinate.latitude)];
    if ([annotation isKindOfClass:[MGLPointFeature class]]) {

        BOAssetAnnotationView *annotationView = [mapView dequeueReusableAnnotationViewWithIdentifier:reuseIdentifier];
        if (!annotationView) {
            annotationView = [[BOAssetAnnotationView alloc] initWithReuseIdentifier:reuseIdentifier];
        }
        
        return annotationView;
    }
    if ([annotation isKindOfClass:[MGLPointAnnotation class]]) {

        CustomAnnotationView *annotationView = [mapView dequeueReusableAnnotationViewWithIdentifier:reuseIdentifier];
        if (!annotationView) {
            annotationView = [[CustomAnnotationView alloc] initWithReuseIdentifier:reuseIdentifier];
            annotationView.frame = CGRectMake(0, 0, 40, 40);

            // Set the annotation view’s background color to a value determined by its longitude.
            CGFloat hue = (CGFloat)annotation.coordinate.longitude / 100;
            annotationView.backgroundColor = [UIColor colorWithHue:hue saturation:0.5 brightness:1 alpha:1];
        }
        return annotationView;
    }
    return nil;
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
