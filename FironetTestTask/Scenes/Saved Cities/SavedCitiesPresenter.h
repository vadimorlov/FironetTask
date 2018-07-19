//
//  SavedCitiesPresenter.h
//  FironetTestTask
//
//  Created by Vadim Orlov on 18.07.2018.
//  Copyright © 2018 Vadim Orlov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SavedCitiesService.h"
#import "SavedCitiesRouter.h"
#import "CityViewData.h"

@protocol SavedCitiesView <NSObject>

- (void)citiesLoaded;

@end

@interface SavedCitiesPresenter : NSObject

@property (nonatomic, strong) SavedCitiesRouter *router;
@property (nonatomic, strong) NSMutableArray<CityViewData*> *cities;

- (instancetype)initWithService:(SavedCitiesService*)service andRouter:(SavedCitiesRouter*)router;

- (void)loadCities;
- (void)attachView:(id<SavedCitiesView>)view;
- (void)detachView;
- (void)addCityWithName:(NSString*)name andComplition:(void (^)(BOOL finished))completion;

@end
