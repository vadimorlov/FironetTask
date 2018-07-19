//
//  RealmManager.h
//  FironetTestTask
//
//  Created by Vadim Orlov on 17.07.2018.
//  Copyright © 2018 Vadim Orlov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Realm.h>
#import "City.h"
#import "CitySavingTable.h"

@interface RealmManager : NSObject

@property (nonatomic, strong) RLMResults *savedCitiesArray;

+ (instancetype)sharedInstance;
- (void)getAllSavedCitiesWithCallBack:(void (^)(NSArray<City*> *cities))callBack;
- (void)saveCity:(City*)city;
- (void)updateWeatherInfoForCity:(City*)city;
- (void)removeCityFromHistoryForID:(NSNumber*)ID;
- (BOOL)doesCityExistForID:(NSNumber*)ID;

@end
