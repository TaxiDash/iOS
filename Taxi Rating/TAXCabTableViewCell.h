//
//  TAXCabTableViewCell.h
//  Taxi Rating
//
//  Created by Seth Friedman on 3/24/14.
//  Copyright (c) 2014 Nashville Public Works. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TAXRatingView;

@interface TAXCabTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet TAXRatingView *ratingView;
@property (weak, nonatomic) IBOutlet UIImageView *bannerImageView;
@property (weak, nonatomic) IBOutlet UILabel *ratingLabel;
@property (weak, nonatomic) IBOutlet UILabel *cabNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *driverLabel;

@end
