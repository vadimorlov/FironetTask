//
//  CitySavingTable.h
//  FironetTestTask
//
//  Created by Vadim Orlov on 17.07.2018.
//  Copyright © 2018 Vadim Orlov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Realm.h>

@interface CitySavingTable : RLMObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *weatherTitle;
@property (nonatomic, copy) NSString *weatherDescription;
@property (nonatomic, copy) NSString *icon;
@property (nonatomic) int temp;
@property (nonatomic) int humidity;
@property (nonatomic) int windSpeed;
@property (nonatomic) int ID;

@end

@interface RealmCitiesSaver : RLMObject

@property RLMArray<CitySavingTable *> *savedCities;

@end
