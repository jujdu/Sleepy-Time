//
//  WeatherAPIExample.m
//  Sleepy-time
//
//  Created by Michael Sidoruk on 04.02.2020.
//  Copyright © 2020 Michael Sidoruk. All rights reserved.
//

#import "WeatherAPI.h"

NS_ASSUME_NONNULL_BEGIN

#pragma mark - Private model interfaces

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

#pragma mark - Implementation MSWelcome

@implementation MSWelcome

+ (_Nullable instancetype)fromData:(NSData *)data error:(NSError *_Nullable *)error {
    return MSWelcomeFromData(data, error);
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict {
    return dict ? [[MSWelcome alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict {
    if (self = [super init]) {
        NSLog(@"%@", dict);
        [self setValuesForKeysWithDictionary:dict];
        _currently = [MSCurrently fromJSONDictionary:(id)_currently];
    }
    return self;
}

@end

#pragma mark - Implementation MSCurrently

@implementation MSCurrently

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict {
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict {
    return dict ? [[MSCurrently alloc] initWithJSONDictionary:dict] : nil;
}

@end

NS_ASSUME_NONNULL_END
