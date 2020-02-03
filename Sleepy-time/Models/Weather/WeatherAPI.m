//
//  WeatherAPI.m
//  Sleepy-time
//
//  Created by Michael Sidoruk on 03.02.2020.
//  Copyright © 2020 Michael Sidoruk. All rights reserved.
//

#import "WeatherAPI.h"

NS_ASSUME_NONNULL_BEGIN

@interface MSWelcome (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
@end

@interface MSCurrently (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
@end

#pragma mark - JSON serialization

MSWelcome *_Nullable MSWelcomeFromData(NSData *data, NSError **error) {
    @try {
        id json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:error];
        return *error ? nil : [MSWelcome fromJSONDictionary:json];
    } @catch (NSException *exception) {
        *error = [NSError errorWithDomain:@"JSONSerialization" code:-1 userInfo:@{ @"exception": exception }];
        return nil;
    }
}

MSWelcome *_Nullable MSWelcomeFromJSON(NSString *json, NSStringEncoding encoding, NSError **error) {
    return MSWelcomeFromData([json dataUsingEncoding:encoding], error);
}

@implementation MSWelcome
+ (NSDictionary<NSString *, NSString *> *)properties {
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"timezone": @"timezone",
        @"currently": @"currently",
    };
}

+ (_Nullable instancetype)fromData:(NSData *)data error:(NSError *_Nullable *)error {
    return MSWelcomeFromData(data, error);
}

+ (_Nullable instancetype)fromJSON:(NSString *)json encoding:(NSStringEncoding)encoding error:(NSError *_Nullable *)error {
    return MSWelcomeFromJSON(json, encoding, error);
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict {
    return dict ? [[MSWelcome alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict {
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
        _currently = [MSCurrently fromJSONDictionary:(id)_currently];
    }
    return self;
}

@end

@implementation MSCurrently
+ (NSDictionary<NSString *, NSString *> *)properties {
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"temperature": @"temperature",
        @"apparentTemperature": @"apparentTemperature",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict {
    return dict ? [[MSCurrently alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict {
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

@end

NS_ASSUME_NONNULL_END
