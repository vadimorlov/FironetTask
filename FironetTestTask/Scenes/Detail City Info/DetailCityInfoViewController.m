//
//  DetailCityInfoViewController.m
//  FironetTestTask
//
//  Created by Vadim Orlov on 18.07.2018.
//  Copyright © 2018 Vadim Orlov. All rights reserved.
//

#import "DetailCityInfoViewController.h"

@implementation DetailCityInfoViewController

#pragma mark - Controller Liftcycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureWithCity:self.city];
}

#pragma mark - Controller Configuration
- (void)configureWithCity:(CityViewData*)city {
    self.cityNameLabel.text = city.name;
    NSURL *imageURL = [NSURL URLWithString:city.imageLink];
    [self.weatherIconImageView setImageWithURL:imageURL];
    self.weatherDescriptionLabel.text = [NSString stringWithFormat:@"%@", city.weatherDescription];
    self.temperatureValueLabel.text = [NSString stringWithFormat:@"%d°C", [city.temp intValue] - 273];
    self.windValueLabel.text = [NSString stringWithFormat:@"%.01f m/s", [city.windSpeed floatValue]];
    self.humidityValueLabel.text = [NSString stringWithFormat:@"%d %%", [city.humidity intValue]];
}

@end
