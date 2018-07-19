//
//  SavedCitiesRouter.h
//  FironetTestTask
//
//  Created by Vadim Orlov on 17.07.2018.
//  Copyright © 2018 Vadim Orlov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DetailCityInfoViewController.h"
#import "CityViewData.h"
#import "GlobalConstants.h"
@class SavedCitiesViewController;

@interface SavedCitiesRouter : NSObject

- (void)openDetailInfoForCity:(CityViewData*)city;
- (instancetype)initWithController:(SavedCitiesViewController*)savedCitiesViewController;

@end
