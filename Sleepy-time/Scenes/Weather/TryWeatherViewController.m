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
@property (weak, nonatomic) UIActivityIndicatorView *activityIndicator;

@end

@implementation TryWeatherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setupView];
    
    [self.activityIndicator startAnimating];
    
    NSURL *url = [NSURL URLWithString:@"https://api.darksky.net/forecast/75821a36b020505377992aee2cbf6770/59.865968,30.469290"];
    [[NSURLSession.sharedSession dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (data) {
            
            NSError *error = nil;
            
            NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
      
            MSWeather *welcome = [MSWeather fromJSONDictionary:json];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                NSLog(@"%d", (int)welcome.currently.temperature);
                [self.activityIndicator stopAnimating];
                self.degreeLabel.text = [NSString stringWithFormat:@"%d°", (int)((welcome.currently.temperature - 32) / 1.8)];
                self.feelsLikeDegreeLabel.text = [NSString stringWithFormat:@"feels like %d°", (int)((welcome.currently.apparentTemperature - 32) / 1.8)];
                self.dayInfoLabel.text = [NSString stringWithFormat:@"%@", welcome.hourly.summary];
            });
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
    
    UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleLarge];
    
    self.dayInfoLabel = dayInfoLabel;
    self.degreeLabel = degreeLabel;
    self.feelsLikeDegreeLabel = feelsLikeDegreeLabel;
    self.stackView = stackView;
    
    self.activityIndicator = activityIndicator;
    
    self.dayInfoLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.dayInfoLabel.textAlignment = NSTextAlignmentCenter;
    self.dayInfoLabel.text = [NSString stringWithFormat:@"Monday 3"];

    self.degreeLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.degreeLabel.textAlignment = NSTextAlignmentCenter;
    self.degreeLabel.text = @"-";

    self.feelsLikeDegreeLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.feelsLikeDegreeLabel.textAlignment = NSTextAlignmentCenter;
    self.feelsLikeDegreeLabel.text = @"-";

    self.stackView.translatesAutoresizingMaskIntoConstraints = NO;
    self.stackView.alignment = UIStackViewAlignmentFill;
    self.stackView.distribution = UIStackViewDistributionFill;
    self.stackView.axis = UILayoutConstraintAxisVertical;
    self.stackView.spacing = 20.f;
    
    self.activityIndicator.translatesAutoresizingMaskIntoConstraints = NO;
    self.activityIndicator.color = [UIColor blackColor];
    self.activityIndicator.hidesWhenStopped = YES;
    
    [self.view addSubview:self.stackView];
        
    [self.stackView.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor].active = YES;
    [self.stackView.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor].active = YES;
    
    [self.view addSubview:self.activityIndicator];
    
    [self.activityIndicator.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor constant: -100].active = YES;
    [self.activityIndicator.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor].active = YES;
}


@end
