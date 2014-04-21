//
//  TAXRatingView.h
//  Taxi Rating
//
//  Created by Seth Friedman on 4/21/14.
//  Copyright (c) 2014 Nashville Public Works. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, TAXRating) {
    TAXRatingLowRating,
    TAXRatingMiddleRating,
    TAXRatingHighRating,
};

@interface TAXRatingView : UIView

@property (nonatomic, assign) TAXRating rating;

@end
