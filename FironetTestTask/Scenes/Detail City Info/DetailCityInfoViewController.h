//
//  DetailCityInfoViewController.h
//  FironetTestTask
//
//  Created by Vadim Orlov on 18.07.2018.
//  Copyright © 2018 Vadim Orlov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <RestKit.h>
#import "CityViewData.h"

@interface DetailCityInfoViewController : UIViewController
@property (nonatomic, weak) IBOutlet UILabel *cityNameLabel;
@property (nonatomic, weak) IBOutlet UIImageView *weatherIconImageView;
@property (nonatomic, weak) IBOutlet UILabel *weatherDescriptionLabel;
@property (nonatomic, weak) IBOutlet UILabel *temperatureValueLabel;
@property (nonatomic, weak) IBOutlet UILabel *windValueLabel;
@property (nonatomic ,weak) IBOutlet UILabel *humidityValueLabel;

@property (nonatomic, strong) CityViewData *city;

@end
