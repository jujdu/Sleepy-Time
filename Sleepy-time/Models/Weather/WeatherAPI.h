//
//  WeatherAPI.h
//  Sleepy-time
//
//  Created by Michael Sidoruk on 03.02.2020.
//  Copyright © 2020 Michael Sidoruk. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MSWeather;
@class MSCurrently;
@class MSHourly;

NS_ASSUME_NONNULL_BEGIN

#pragma mark - Object interfaces

@interface MSWeather : NSObject
@property (copy, nonatomic) NSString *timezone;
@property (strong, nonatomic) MSCurrently *currently;
@property (strong, nonatomic) MSHourly *hourly;

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;

@end

@interface MSCurrently : NSObject
//@property (assign, nonatomic) NSInteger time;
//@property (copy, nonatomic)   NSString *summary;
//@property (copy, nonatomic)   NSString *icon;
//@property (assign, nonatomic) double precipProbability;
//@property (copy, nonatomic)   NSString *precipType;
@property (assign, nonatomic) double temperature;
@property (assign, nonatomic) double apparentTemperature;
//@property (assign, nonatomic) double humidity;
//@property (assign, nonatomic) double pressure;
//@property (assign, nonatomic) double windSpeed;
//@property (assign, nonatomic) NSInteger uvIndex;
//@property (assign, nonatomic) NSInteger visibility;
@end

@interface MSHourly : NSObject
@property (copy, nonatomic) NSString *summary;
@property (copy, nonatomic) NSString *icon;
@property (copy, nonatomic) NSArray<MSCurrently *> *data;
@end

NS_ASSUME_NONNULL_END
