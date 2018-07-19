//
//  CityTableViewCell.h
//  FironetTestTask
//
//  Created by Vadim Orlov on 18.07.2018.
//  Copyright © 2018 Vadim Orlov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <RestKit.h>
#import "CityViewData.h"

@interface CityTableViewCell : UITableViewCell
@property (nonatomic, weak) IBOutlet UILabel *cityNameLabel;
@property (nonatomic, weak) IBOutlet UILabel *tempLabel;
@property (nonatomic, weak) IBOutlet UILabel *weatherTitleLabel;
@property (nonatomic, weak) IBOutlet UIImageView *weatherIconImageView;

- (void)configureWithCity:(CityViewData*)city;

@end
