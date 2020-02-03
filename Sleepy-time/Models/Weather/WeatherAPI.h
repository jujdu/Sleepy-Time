//
//  WeatherAPI.h
//  Sleepy-time
//
//  Created by Michael Sidoruk on 03.02.2020.
//  Copyright © 2020 Michael Sidoruk. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MSWelcome;
@class MSCurrently;
@class MSHourly;

NS_ASSUME_NONNULL_BEGIN

#pragma mark - Object interfaces

@interface MSWelcome : NSObject
@property (nonatomic, copy)   NSString *timezone;
@property (nonatomic, strong) MSCurrently *currently;
//@property (nonatomic, strong) MSHourly *hourly;
@end

@interface MSCurrently : NSObject
//@property (nonatomic, assign) NSInteger time;
//@property (nonatomic, copy)   NSString *summary;
//@property (nonatomic, copy)   NSString *icon;
//@property (nonatomic, assign) double precipProbability;
//@property (nonatomic, copy)   NSString *precipType;
@property (nonatomic, assign) double temperature;
@property (nonatomic, assign) double apparentTemperature;
//@property (nonatomic, assign) double humidity;
//@property (nonatomic, assign) double pressure;
//@property (nonatomic, assign) double windSpeed;
//@property (nonatomic, assign) NSInteger uvIndex;
//@property (nonatomic, assign) NSInteger visibility;
@end

@interface MSHourly : NSObject
@property (nonatomic, copy) NSString *summary;
@property (nonatomic, copy) NSString *icon;
@property (nonatomic, copy) NSArray<MSCurrently *> *data;
@end

NS_ASSUME_NONNULL_END
