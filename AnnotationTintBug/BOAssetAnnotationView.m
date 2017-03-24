//
//  BOAssetAnnotationView.m
//  AnnotationTintBug
//
//  Created by Matthew Kiazyk on 2017-03-24.
//  Copyright © 2017 Robots & Pencils Inc. All rights reserved.
//

#import "BOAssetAnnotationView.h"

@implementation BOAssetAnnotationView

CGFloat const BOAssetPinStubHeight = 6.0;
CGFloat const BOAssetMapIconPadding = 7.0;

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        // Start with shadow so that it shows up in the background behind main image
        UIImage *assetBackgroundImage = [self annotationBackgroundImage];
        UIImageView *assetBackgroundImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"filled_droppin_circle_shadow"]];
        [assetBackgroundImageView addSubview:[[UIImageView alloc] initWithImage:assetBackgroundImage]];

        [assetBackgroundImageView setTintColor:[self tintColorFromObject]];

        UIImageView *assetImageView = [[UIImageView alloc] initWithImage:[self assetTypeImage]];
        CGRect rect = assetImageView.frame;
        rect.size = CGSizeMake(assetImageView.frame.size.width - BOAssetMapIconPadding, assetImageView.frame.size.height - BOAssetMapIconPadding);
        assetImageView.frame = rect;

        assetImageView.center = CGPointMake(assetBackgroundImage.size.width / 2, (assetBackgroundImage.size.height / 2) - BOAssetPinStubHeight);
        assetImageView.tintColor =  [UIColor whiteColor];
        [assetImageView setContentMode:UIViewContentModeScaleAspectFit];
        [assetBackgroundImageView addSubview:assetImageView];

        // This property prevents the annotation from changing size when the map is tilted.
        self.scalesWithViewingDistance = NO;

        [self addSubview:assetBackgroundImageView];
        self.frame = assetBackgroundImageView.frame;
    }
    return self;
}

- (UIImage *)annotationBackgroundImage {
    return [[UIImage imageNamed:@"filled_droppin_circle_empty"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
}

- (UIColor *)tintColorFromObject {
    return [UIColor orangeColor];
}

- (UIImage *)assetTypeImage {
    return [[UIImage imageNamed:@"assetTypeImage"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
}
@end
