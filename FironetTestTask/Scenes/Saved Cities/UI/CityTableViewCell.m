//
//  CityTableViewCell.m
//  FironetTestTask
//
//  Created by Vadim Orlov on 18.07.2018.
//  Copyright © 2018 Vadim Orlov. All rights reserved.
//

#import "CityTableViewCell.h"

@implementation CityTableViewCell

- (void)configureWithCity:(CityViewData *)city {
    self.cityNameLabel.text = city.name;
    self.tempLabel.text = [NSString stringWithFormat:@"%ld°C", ((long)[city.temp integerValue] - 273)];
    self.weatherTitleLabel.text = city.weatherTitle;
    NSURL *imageURL = [[NSURL alloc] initWithString:city.imageLink];
    [self.weatherIconImageView setImageWithURL:imageURL];
}

@end
