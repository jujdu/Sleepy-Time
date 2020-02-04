////
////  WeatherAPI.m
////  Sleepy-time
////
////  Created by Michael Sidoruk on 03.02.2020.
////  Copyright © 2020 Michael Sidoruk. All rights reserved.
////
//
//#import "WeatherAPI.h"
//
//NS_ASSUME_NONNULL_BEGIN
//
//@implementation MSWelcome
//
//- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
//    self = [super init];
//    if (self) {
//
//        self.timezone = dictionary[@"timezone"];
//
//        MSCurrently *currently = [[MSCurrently alloc]init];
//
////        currently.temperature = [[[dictionary objectForKey:@"currently"] objectForKey:@"temperature"] doubleValue];
//
//        currently.temperature = [[dictionary valueForKeyPath:@"currently.temperature"] doubleValue];
//        currently.apparentTemperature = [[dictionary valueForKeyPath:@"currently.apparentTemperature"] doubleValue];
//
//        self.currently = currently;
//
//        MSHourly *hourly = [[MSHourly alloc]init];
//
//        hourly.icon = [dictionary valueForKeyPath:@"hourly.icon"];
//        hourly.summary = [dictionary valueForKeyPath:@"hourly.summary"];
//
//        NSMutableArray *dataArray = [NSMutableArray array];
//        for (NSDictionary *dic in [dictionary valueForKeyPath:@"hourly.data"]) {
//            MSCurrently *currently = [[MSCurrently alloc]init];
//            currently.temperature = [[dic valueForKeyPath:@"temperature"] doubleValue];
//            currently.apparentTemperature = [[dic valueForKeyPath:@"apparentTemperature"] doubleValue];
//            [dataArray addObject:currently];
//        }
//        hourly.data = dataArray;
//
//        self.hourly = hourly;
//    }
//    return self;
//}
//
//@end
//
//NS_ASSUME_NONNULL_END
