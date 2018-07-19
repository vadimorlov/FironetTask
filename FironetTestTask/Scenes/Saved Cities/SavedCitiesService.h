//
//  SavedCitiesService.h
//  FironetTestTask
//
//  Created by Vadim Orlov on 17.07.2018.
//  Copyright © 2018 Vadim Orlov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RealmManager.h"
#import "NetworkManager.h"
#import "CitySavingTable.h"
#import "City.h"

@interface SavedCitiesService : NSObject

- (void)loadCityForName:(NSString*)name withCallBack:(void (^)(City *city, NSError *error))callBack;
- (void)loadSavedCitiesWithCallBack:(void (^)(NSArray<City*> *cities, NSError *error))callBack;

@end
