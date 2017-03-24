//
//  CustomAnnotationView.m
//  AnnotationTintBug
//
//  Created by Matthew Kiazyk on 2017-03-24.
//  Copyright © 2017 Robots & Pencils Inc. All rights reserved.
//

#import "CustomAnnotationView.h"

@implementation CustomAnnotationView

- (void)layoutSubviews {
    [super layoutSubviews];

    // Force the annotation view to maintain a constant size when the map is tilted.
    self.scalesWithViewingDistance = false;

    // Use CALayer’s corner radius to turn this view into a circle.
    self.layer.cornerRadius = self.frame.size.width / 2;
    self.layer.borderWidth = 2;
    self.layer.borderColor = [UIColor whiteColor].CGColor;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Animate the border width in/out, creating an iris effect.
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"borderWidth"];
    animation.duration = 0.1;
    self.layer.borderWidth = selected ? self.frame.size.width / 4 : 2;
    [self.layer addAnimation:animation forKey:@"borderWidth"];
}

@end
