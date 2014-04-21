//
//  TAXRatingView.m
//  Taxi Rating
//
//  Created by Seth Friedman on 4/21/14.
//  Copyright (c) 2014 Nashville Public Works. All rights reserved.
//

#import "TAXRatingView.h"

@implementation TAXRatingView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 4.0);
    CGContextSetFillColorWithColor(context, [self colorForRating:self.rating].CGColor);
    CGContextAddEllipseInRect(context, rect);
    CGContextFillEllipseInRect(context, rect);
}

#pragma mark - Helper Method

- (UIColor *)colorForRating:(TAXRating)rating {
    UIColor *color;
    
    switch (rating) {
        case TAXRatingLowRating:
            color = [UIColor colorWithRed:240.0/255.0
                                    green:81.0/255.0
                                     blue:84.0/255.0
                                    alpha:1.0];
            break;
        case TAXRatingMiddleRating:
            color = [UIColor colorWithRed:87.0/255.0
                                    green:196.0/255.0
                                     blue:210.0/255.0
                                    alpha:1.0];
            break;
        case TAXRatingHighRating:
            color = [UIColor colorWithRed:128.0/255.0
                                    green:239.0/255.0
                                     blue:253.0/255.0
                                    alpha:1.0];
            break;
            
        default:
            break;
    }
    
    return color;
}

@end
