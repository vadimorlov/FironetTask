//
//  CityViewData.h
//  FironetTestTask
//
//  Created by Vadim Orlov on 17.07.2018.
//  Copyright © 2018 Vadim Orlov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CityViewData : NSObject

@property (nonatomic, copy) NSString *imageLink;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *weatherTitle;
@property (nonatomic, copy) NSString *weatherDescription;
@property (nonatomic) NSNumber *humidity;
@property (nonatomic) NSNumber *windSpeed;
@property (nonatomic) NSNumber *temp;

@end
