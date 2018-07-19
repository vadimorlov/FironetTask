//
//  SavedCitiesService.m
//  FironetTestTask
//
//  Created by Vadim Orlov on 17.07.2018.
//  Copyright © 2018 Vadim Orlov. All rights reserved.
//

#import "SavedCitiesService.h"

@implementation SavedCitiesService

- (void)loadCityForName:(NSString*)name withCallBack:(void (^)(City *city, NSError *error))callBack {
    BOOL isConnectedToInternet = [[NetworkManager sharedInstance] checkConnection];
    if (isConnectedToInternet) {
        [[NetworkManager sharedInstance] getWeatherInfoForCityWithName:name andComplition:^(City *city, NSError *error) {
            if (city) {
                [[RealmManager sharedInstance] saveCity:city];
                callBack(city, nil);
            } else {
                NSLog(@"Error: %@", error);
                callBack(nil, error);
            }
        }];
    } else {
        NSError *error = [[NSError alloc] initWithDomain:@"com.vadimorlov.FironetTestTask"
                                                    code:408
                                                userInfo:@{@"description" : @"No Internet Connection"}];
        callBack(nil, error);
    }
}

- (void)loadSavedCitiesWithCallBack:(void (^)(NSArray<City*> *cities, NSError *error))callBack {
    NSMutableArray<City*> *cities = [[NSMutableArray alloc] init];
    RLMResults *savedCities = [CitySavingTable allObjects];
    dispatch_group_t dispatchGroup = dispatch_group_create();
    if (savedCities.count == 0) {
        NSArray *defaultCitiesNames = @[@"Kiev", @"Berlin", @"Los Angeles"];
        for (NSString *name in defaultCitiesNames) {
            dispatch_group_enter(dispatchGroup);
            [self getInfoForCityName:name
                        withCallBack:^(City *city, NSError *error) {
                dispatch_group_leave(dispatchGroup);
                if (city) {
                    [cities addObject:city];
                    [[RealmManager sharedInstance] saveCity:city];
                } else {
                    NSLog(@"Error: %@", error);
                    callBack(nil, error);
                }
            }];
        }
        dispatch_group_notify(dispatchGroup, dispatch_get_main_queue(), ^{
            callBack(cities, nil);
        });
    } else {
        BOOL isConnectedToInternet = [[NetworkManager sharedInstance] checkConnection];
        if (isConnectedToInternet) {
            for (CitySavingTable *realmCity in savedCities) {
                dispatch_group_enter(dispatchGroup);
                [self getInfoForCityName:realmCity.name
                            withCallBack:^(City *city, NSError *error) {
                    dispatch_group_leave(dispatchGroup);
                    if (city) {
                        [cities addObject:city];
                        [[RealmManager sharedInstance] updateWeatherInfoForCity:city];
                    } else {
                        NSLog(@"Error: %@", error);
                        callBack(nil, error);
                    }
                }];
            }
            dispatch_group_notify(dispatchGroup, dispatch_get_main_queue(), ^{
                callBack(cities, nil);
            });
        } else {
            [[RealmManager sharedInstance]getAllSavedCitiesWithCallBack:^(NSArray<City *> *cities) {
                callBack(cities, nil);
            }];
        }
    }
}

- (void)getInfoForCityName:(NSString*)name withCallBack:(void (^)(City *city, NSError *error))callBack {
    [[NetworkManager sharedInstance] getWeatherInfoForCityWithName:name
                                                     andComplition:^(City *city, NSError *error) {
        if (city != nil) {
            callBack(city, nil);
        } else {
            callBack(nil, error);
        }
    }];
}

@end
