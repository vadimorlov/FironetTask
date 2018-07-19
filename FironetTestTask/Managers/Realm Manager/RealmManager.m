//
//  RealmManager.m
//  FironetTestTask
//
//  Created by Vadim Orlov on 17.07.2018.
//  Copyright © 2018 Vadim Orlov. All rights reserved.
//

#import "RealmManager.h"

@implementation RealmManager

#pragma mark - Initialization
- (instancetype)init {
    @throw [NSException exceptionWithName:NSInternalInconsistencyException reason:@"You cannot create a new instance of RealmManager class!!!" userInfo:nil];
}

- (instancetype)initPrivate {
    self = [super init];
    return self;
}

+ (instancetype)sharedInstance {
    static id sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[RealmManager alloc] initPrivate];
    });
    return sharedInstance;
}

#pragma mark - City Realm Service Methods
- (void)getAllSavedCitiesWithCallBack:(void (^)(NSArray<City*> *cities))callBack {
    NSMutableArray<City*> *cities = [[NSMutableArray alloc] init];
    self.savedCitiesArray = [CitySavingTable allObjects];
    for (CitySavingTable *savedCity in self.savedCitiesArray) {
        City* city = [[City alloc] init];
        city.main = [[Main alloc] init];
        city.wind = [[Wind alloc] init];
        city.name = savedCity.name;
        NSDictionary *weather = [[NSDictionary alloc] initWithObjectsAndKeys:
                                 savedCity.weatherTitle, @"main",
                                 savedCity.weatherDescription, @"description",
                                 savedCity.icon, @"icon",
                                 nil];
        city.weather = [NSSet setWithObject:weather];
        city.main.temp = [[NSNumber alloc] initWithInt:savedCity.temp];
        city.main.humidity = [[NSNumber alloc] initWithInt:savedCity.humidity];
        city.wind.speed = [[NSNumber alloc] initWithInt:savedCity.windSpeed];
        city.Id = [[NSNumber alloc] initWithInt:savedCity.ID];
        [cities addObject:city];
    }
    callBack(cities);
}

- (void)saveCity:(City*)city {
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm beginWriteTransaction];
    CitySavingTable *cityToSave = [[CitySavingTable alloc] init];
    cityToSave.name = city.name;
    cityToSave.temp = [city.main.temp intValue];
    cityToSave.humidity = [city.main.humidity intValue];
    cityToSave.windSpeed = [city.wind.speed intValue];
    cityToSave.ID = [city.Id intValue];
    NSDictionary *weather = city.weather.allObjects.firstObject;
    cityToSave.weatherTitle = weather[@"main"];
    cityToSave.weatherDescription = weather[@"description"];
    cityToSave.icon = weather[@"icon"];
    [realm addObject:cityToSave];
    [realm commitWriteTransaction];
}

- (void)updateWeatherInfoForCity:(City*)city {
    self.savedCitiesArray = [CitySavingTable allObjects];
    for (CitySavingTable *oldCityInfo in self.savedCitiesArray) {
        if (oldCityInfo.ID == [city.Id intValue]) {
            RLMRealm *realm = [RLMRealm defaultRealm];
            [realm beginWriteTransaction];
            oldCityInfo.temp = [city.main.temp intValue];
            oldCityInfo.humidity = [city.main.humidity intValue];
            oldCityInfo.windSpeed = [city.wind.speed intValue];
            oldCityInfo.ID = [city.Id intValue];
            NSDictionary *weather = city.weather.allObjects.firstObject;
            oldCityInfo.weatherTitle = weather[@"main"];
            oldCityInfo.weatherDescription = weather[@"description"];
            oldCityInfo.icon = weather[@"icon"];
            [realm commitWriteTransaction];
        }
    }
}

- (void)removeCityFromHistoryForID:(NSNumber*)ID {
    self.savedCitiesArray = [CitySavingTable allObjects];
    for (CitySavingTable *city in self.savedCitiesArray) {
        if (city.ID == [ID intValue]) {
            RLMRealm *realm = [RLMRealm defaultRealm];
            [realm beginWriteTransaction];
            [realm deleteObject:city];
            [realm commitWriteTransaction];
        }
    }
}

- (BOOL)doesCityExistForID:(NSNumber*)ID {
    BOOL doesCityExist = false;
    self.savedCitiesArray = [CitySavingTable allObjects];
    for (CitySavingTable *city in self.savedCitiesArray) {
        if (city.ID == [ID intValue]) {
            doesCityExist = true;
        }
    }
    return doesCityExist;
}

@end
