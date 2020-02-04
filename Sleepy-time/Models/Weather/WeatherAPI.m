//
//  WeatherAPI.m
//  Sleepy-time
//
//  Created by Michael Sidoruk on 03.02.2020.
//  Copyright © 2020 Michael Sidoruk. All rights reserved.
//

#import "WeatherAPI.h"

NS_ASSUME_NONNULL_BEGIN

#pragma mark - Private interfaces
@interface MSHourly (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
@end

@interface MSCurrently (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
@end

#pragma mark - Implementation Weather
@implementation Weather

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict {
    return dict ? [[Weather alloc] initWithDictionary:dict] : nil;
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    if (self) {
        self.timezone = dict[@"timezone"];
        self.currently = [MSCurrently fromJSONDictionary:dict[@"currently"]];
        self.hourly = [MSHourly fromJSONDictionary:dict[@"hourly"]];
    }
    return self;
}

@end

#pragma mark - Implementation MSCurrently
@implementation MSCurrently

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict {
    return dict ? [[MSCurrently alloc] initWithDictionary:dict] : nil;
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    if (self) {
        self.temperature = [dict[@"temperature"] doubleValue];
        self.apparentTemperature = [dict[@"apparentTemperature"] doubleValue];
    }
    return self;
}

@end

#pragma mark - Implementation MSHourly
@implementation MSHourly

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict {
    return dict ? [[MSHourly alloc] initWithDictionary:dict] : nil;
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    if (self) {
        self.icon = dict[@"icon"];
        self.summary = dict[@"summary"];

        NSMutableArray *dataArray = [NSMutableArray array];
        for (NSDictionary *nestedDict in dict[@"data"]) {
            MSCurrently *currently = [MSCurrently fromJSONDictionary:nestedDict];
            [dataArray addObject:currently];
        }
        self.data = dataArray;
    }
    return self;
}
                       
@end

NS_ASSUME_NONNULL_END

//возможно сделать через один инициализатор и добираться до объектов через разные способы. Второй key value coding показывает свои преимущества.
//        currently.temperature = [[[dictionary objectForKey:@"currently"] objectForKey:@"temperature"] doubleValue];
//currently.apparentTemperature = [[dictionary valueForKeyPath:@"currently.apparentTemperature"] doubleValue];

