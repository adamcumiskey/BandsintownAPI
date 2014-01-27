//
//  BITSearchViewController.h
//  BandsInTownAPI
//
//  Created by Adam Cumiskey on 1/15/14.
//  Copyright (c) 2014 Adam Cumiskey. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ENUM(NSInteger, TextFieldTag) {
    kArtistTextField = 1,
    kStartDateTextField = 2,
    kEndDateTextField = 3,
    kLocationTextField = 4
};

@interface BITSearchViewController : UIViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *artistTextField;

@property (weak, nonatomic) IBOutlet UITextField *startDateTextField;
@property (weak, nonatomic) IBOutlet UITextField *endDateTextField;
@property (weak, nonatomic) IBOutlet UISegmentedControl *dateTypeSegmentedControl;

@property (weak, nonatomic) IBOutlet UITextField *cityTextField;
@property (weak, nonatomic) IBOutlet UITextField *stateTextField;
@property (weak, nonatomic) IBOutlet UISegmentedControl *locationTypeSegmentedControl;

@property (weak, nonatomic) IBOutlet UISlider *searchRadiusSlider;
@property (weak, nonatomic) IBOutlet UILabel *sliderValueLabel;

@property (weak, nonatomic) IBOutlet UISwitch *includeRecommendationsSwitch;

@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;


- (IBAction)search:(id)sender;

@end
