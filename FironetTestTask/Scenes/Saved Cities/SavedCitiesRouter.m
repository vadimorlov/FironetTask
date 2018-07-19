//
//  SavedCitiesRouter.m
//  FironetTestTask
//
//  Created by Vadim Orlov on 17.07.2018.
//  Copyright © 2018 Vadim Orlov. All rights reserved.
//

#import "SavedCitiesRouter.h"
#import "SavedCitiesViewController.h"

@interface SavedCitiesRouter ()

#pragma mark - Private Properties
@property (nonatomic, weak) SavedCitiesViewController *savedCitiesViewController;

@end

@implementation SavedCitiesRouter

#pragma mark - Initializers
- (instancetype)initWithController:(SavedCitiesViewController*)savedCitiesViewController {
    self = [super init];
    if (self) {
        self.savedCitiesViewController = savedCitiesViewController;
    }
    return self;
}

- (void)openDetailInfoForCity:(CityViewData *)city {
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    DetailCityInfoViewController *detailCityInfoViewController = [mainStoryboard instantiateViewControllerWithIdentifier:DETAIL_INFO_CONTROLLER_ID];
    detailCityInfoViewController.city = city;
    dispatch_async(dispatch_get_main_queue(), ^(void){
        [self.savedCitiesViewController.navigationController pushViewController:detailCityInfoViewController
                                                                       animated:true];
    });
}

@end
