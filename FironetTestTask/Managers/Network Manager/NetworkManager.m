//
//  NetworkManager.m
//  FironetTestTask
//
//  Created by Vadim Orlov on 17.07.2018.
//  Copyright © 2018 Vadim Orlov. All rights reserved.
//

#import "NetworkManager.h"

@implementation NetworkManager

#pragma mark - Initialization
- (instancetype)init {
    @throw [NSException exceptionWithName:NSInternalInconsistencyException reason:@"You cannot create a new instance of NetworkManager class!!!" userInfo:nil];
}

- (instancetype)initPrivate {
    self = [super init];
    return self;
}

+ (instancetype)sharedInstance {
    static id sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[NetworkManager alloc] initPrivate];
    });
    return sharedInstance;
}

#pragma mark - High Level Requests
- (void)getWeatherInfoForCityWithName:(NSString*)name andComplition:(void (^)(City *city, NSError *error))complitionHandler {
    NSDictionary *parameters = @{
                                 @"appid": APP_ID,
                                 @"q": name
                                 };
    [self sendRequestForMethod:CITY_PREFIX
                 andParameters:parameters
                withComplition:^(City *city, NSError *error) {
        NSString *cityResponseDescription = [NSString stringWithFormat:@"====== CITY RESPONSE -> %@ ======", city.description];
        NSLog(@"%@", cityResponseDescription);
        if (city != nil) {
            complitionHandler(city, nil);
        } else {
            complitionHandler(nil, error);
        }
    }];
}

#pragma mark - Send Request
- (void)sendRequestForMethod:(NSString*)method andParameters:(NSDictionary*)parameters withComplition :(void (^)(City *city, NSError *error))complitionHandler {
    BOOL isConnectedToInternet = [self checkConnection];
    if (isConnectedToInternet) {
        if ([RKObjectManager sharedManager] == nil) {
            [self initializeRestKit];
        }
        NSString *path = [NSString stringWithFormat:@"%@%@", API_VERSION, method];
        NSLog(@"====== REQUEST FOR -> %@%@ ======", BASE_URL, path);
        [[RKObjectManager sharedManager] getObjectsAtPath:path
                                               parameters:parameters
                                                  success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                                      complitionHandler(mappingResult.firstObject, nil);
        }
                                                  failure:^(RKObjectRequestOperation *operation, NSError *error) {
                                                      complitionHandler(nil, error);
        }];
    } else {
        NSError *error = [[NSError alloc] initWithDomain:@"com.vadimorlov.FironetTestTask"
                                                    code:408
                                                userInfo:@{@"description" : @"No Internet Connection"}];
        complitionHandler(nil, error);
    }
}

#pragma mark - Network Service
- (BOOL)checkConnection {
    if ([[Reachability reachabilityForInternetConnection] currentReachabilityStatus] == NotReachable) {
        NSLog(@"Not Reachible");
        return false;
    } else {
        NSLog(@"Reachible");
        return true;
    }
}

#pragma mark - Rest Kit Initialization
- (void)initializeRestKit {
    NSString* baseURLString = [NSString stringWithFormat:@"%@", BASE_URL];
    NSURL *baseURL = [NSURL URLWithString:baseURLString];
    AFRKHTTPClient *client = [[AFRKHTTPClient alloc] initWithBaseURL:baseURL];
    RKObjectManager *objectManager = [[RKObjectManager alloc] initWithHTTPClient:client];
    
    //Mapping realization
    RKObjectMapping *windMapping = [RKObjectMapping mappingForClass:[Wind class]];
    [windMapping addAttributeMappingsFromDictionary:@{ @"speed": @"speed" }];
    RKObjectMapping *mainMapping = [RKObjectMapping mappingForClass:[Main class]];
    [mainMapping addAttributeMappingsFromDictionary:@{ @"temp": @"temp",
                                                       @"humidity": @"humidity"
                                                       }];
    RKObjectMapping *cityMapping = [RKObjectMapping mappingForClass:[City class]];
    [cityMapping addAttributeMappingsFromDictionary:@{ @"id": @"id",
                                                       @"name": @"name",
                                                       @"weather": @"weather"
                                                       }];
    [cityMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"wind"
                                                                                toKeyPath:@"wind"
                                                                              withMapping:windMapping]];
    [cityMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"main"
                                                                                toKeyPath:@"main"
                                                                              withMapping:mainMapping]];
    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:cityMapping
                                                                                            method:RKRequestMethodGET
                                                                                       pathPattern:nil
                                                                                           keyPath:nil
                                                                                       statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    
    [objectManager addResponseDescriptor:responseDescriptor];
}

@end
