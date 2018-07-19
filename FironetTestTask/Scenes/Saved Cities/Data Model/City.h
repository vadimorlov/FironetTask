//
//  City.h
//  FironetTestTask
//
//  Created by Vadim Orlov on 17.07.2018.
//  Copyright © 2018 Vadim Orlov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Main.h"
#import "Wind.h"

@interface City : NSObject
    @property (nonatomic) NSSet *weather;
    @property (nonatomic) Main *main;
    @property (nonatomic) Wind *wind;
    @property (nonatomic) NSNumber *Id;
    @property (nonatomic, copy) NSString *name;
@end


