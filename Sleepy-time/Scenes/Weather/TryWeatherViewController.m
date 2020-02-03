//
//  TryWeatherViewController.m
//  Sleepy-time
//
//  Created by Michael Sidoruk on 03.02.2020.
//  Copyright © 2020 Michael Sidoruk. All rights reserved.
//

#import "TryWeatherViewController.h"
#import "WeatherAPI.h"

@interface TryWeatherViewController ()

@property (weak, nonatomic) UILabel *dayInfoLabel;
@property (weak, nonatomic) UILabel *degreeLabel;
@property (weak, nonatomic) UILabel *feelsLikeDegreeLabel;
@property (weak, nonatomic) UIStackView *stackView;

@end

@implementation TryWeatherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setupView];
    
    NSURL *url = [NSURL URLWithString:@"https://api.darksky.net/forecast/75821a36b020505377992aee2cbf6770/37.8267,-122.4233"];
    [[NSURLSession.sharedSession dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (data) {
            NSError *jsonError = nil;
            id json = [NSJSONSerialization JSONObjectWithData:data
                                                      options:NSJSONReadingMutableContainers
                                                        error:&jsonError];
            
            MSWelcome *welcome = [[MSWelcome alloc]initWithDictionary:json];
            
            NSLog(@"%@", welcome);
            
//            if ([json isKindOfClass:[NSArray class]]) {
//                NSLog(@"%@", (NSArray *)json);
//            } else {
//                NSLog(@"%@", (NSDictionary *)json);
//            }
        }
        
    }] resume];
}

- (void)setupView {
    UILabel *dayInfoLabel = [[UILabel alloc]initWithFrame:CGRectZero];
    UILabel *degreeLabel = [[UILabel alloc]initWithFrame:CGRectZero];
    UILabel *feelsLikeDegreeLabel = [[UILabel alloc]initWithFrame:CGRectZero];
    UIStackView *stackView = [[UIStackView alloc]initWithArrangedSubviews: [NSArray arrayWithObjects:
                                                                            dayInfoLabel,
                                                                            degreeLabel,
                                                                            feelsLikeDegreeLabel, nil]];
    
    self.dayInfoLabel = dayInfoLabel;
    self.degreeLabel = degreeLabel;
    self.feelsLikeDegreeLabel = feelsLikeDegreeLabel;
    self.stackView = stackView;
    
    self.dayInfoLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.dayInfoLabel.textAlignment = NSTextAlignmentCenter;
    self.dayInfoLabel.text = [NSString stringWithFormat:@"Monday 3"];

    self.degreeLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.degreeLabel.textAlignment = NSTextAlignmentCenter;
    self.degreeLabel.text = [NSString stringWithFormat:@"%@ degree", @25];

    self.feelsLikeDegreeLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.feelsLikeDegreeLabel.textAlignment = NSTextAlignmentCenter;
    self.feelsLikeDegreeLabel.text = [NSString stringWithFormat:@"feels like %@ degree", @24];

    self.stackView.translatesAutoresizingMaskIntoConstraints = NO;
    self.stackView.alignment = UIStackViewAlignmentFill;
    self.stackView.distribution = UIStackViewDistributionFill;
    self.stackView.axis = UILayoutConstraintAxisVertical;
    self.stackView.spacing = 20.f;
    
    [self.view addSubview:stackView];
        
    [self.stackView.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor].active = YES;
    [self.stackView.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor].active = YES;
    
}


@end
