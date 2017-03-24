//
//  BOAssetAnnotationView.h
//  AnnotationTintBug
//
//  Created by Matthew Kiazyk on 2017-03-24.
//  Copyright © 2017 Robots & Pencils Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Mapbox/Mapbox.h>

@interface BOAssetAnnotationView : MGLAnnotationView
- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier;
@end
