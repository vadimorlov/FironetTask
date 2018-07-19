//
//  SavedCitiesPresenter.m
//  FironetTestTask
//
//  Created by Vadim Orlov on 18.07.2018.
//  Copyright © 2018 Vadim Orlov. All rights reserved.
//

#import "SavedCitiesPresenter.h"

@interface SavedCitiesPresenter ()

@property (nonatomic, strong) SavedCitiesService *savedCitiesService;
@property (nonatomic, weak) id<SavedCitiesView> savedCitiesView;

@end

@implementation SavedCitiesPresenter

#pragma mark - Initializers
- (instancetype)initWithService:(SavedCitiesService*)service andRouter:(SavedCitiesRouter*)router {
    self = [super init];
    if (self) {
        self.savedCitiesService = service;
        self.router = router;
    }
    return self;
}

#pragma mark - View Lifecycle
- (void)attachView:(id<SavedCitiesView>)view {
    self.savedCitiesView = view;
}

- (void)detachView {
    self.savedCitiesView = nil;
}

#pragma mark - Business Logic
- (void)loadCities {
    [self.savedCitiesService loadSavedCitiesWithCallBack:^(NSArray<City *> *cities, NSError *error) {
        NSMutableArray *citiesViewData = [[NSMutableArray alloc] init];
        if (cities.count != 0) {
            for (City *city in cities) {
                CityViewData *cityViewData = [[CityViewData alloc] init];
                cityViewData.name = city.name;
                cityViewData.temp = city.main.temp;
                NSDictionary *weather = city.weather.allObjects.firstObject;
                NSString *imageLink = [NSString stringWithFormat:@"http://openweathermap.org/img/w/%@.png", weather[@"icon"]];
                cityViewData.imageLink = imageLink;
                cityViewData.weatherTitle = weather[@"main"];
                cityViewData.weatherDescription = weather[@"description"];
                cityViewData.windSpeed = city.wind.speed;
                cityViewData.humidity = city.main.humidity;
                [citiesViewData addObject:cityViewData];
            }
        }
        self.cities = citiesViewData;
        [self.savedCitiesView citiesLoaded];
    }];
}

- (void)addCityWithName:(NSString*)name andComplition:(void (^)(BOOL finished))completion {
    [self.savedCitiesService loadCityForName:name withCallBack:^(City *city, NSError *error) {
        if (city) {
            CityViewData *cityViewData = [[CityViewData alloc] init];
            cityViewData.name = city.name;
            cityViewData.temp = city.main.temp;
            NSDictionary *weather = city.weather.allObjects.firstObject;
            NSString *imageLink = [NSString stringWithFormat:@"http://openweathermap.org/img/w/%@.png", weather[@"icon"]];
            cityViewData.imageLink = imageLink;
            cityViewData.weatherTitle = weather[@"main"];
            cityViewData.weatherDescription = weather[@"description"];
            cityViewData.windSpeed = city.wind.speed;
            cityViewData.humidity = city.main.humidity;
            [self.cities addObject:cityViewData];
        } else {
            NSLog(@"===== YOU'VE ENTERED WRONG CITY NAME! ======");
        }
        completion(true);
    }];
}

@end
