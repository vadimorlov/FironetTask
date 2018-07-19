//
//  NetworkManager.h
//  FironetTestTask
//
//  Created by Vadim Orlov on 17.07.2018.
//  Copyright © 2018 Vadim Orlov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <RestKit.h>
#import <Reachability.h>
#import "NetworkConstants.h"
#import "City.h"

@interface NetworkManager : NSObject

+ (instancetype)sharedInstance;
- (void)getWeatherInfoForCityWithName:(NSString*)name andComplition:(void (^)(City *city, NSError *error))complitionHandler;
- (BOOL)checkConnection;

@end
