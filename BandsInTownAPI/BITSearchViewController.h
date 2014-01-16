//
//  BITSearchViewController.h
//  BandsInTownAPI
//
//  Created by Adam Cumiskey on 1/15/14.
//  Copyright (c) 2014 Adam Cumiskey. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BITSearchViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *artistTextField;

@property (weak, nonatomic) IBOutlet UITextField *startDateTextField;
@property (weak, nonatomic) IBOutlet UITextField *endDateTextField;
@property (weak, nonatomic) IBOutlet UISegmentedControl *dateTypeSegmentedControl;

@property (weak, nonatomic) IBOutlet UITextField *locationTextField;
@property (weak, nonatomic) IBOutlet UISegmentedControl *locationTypeSegmentedControl;

@property (weak, nonatomic) IBOutlet UISlider *searchRadiusSlider;
@property (weak, nonatomic) IBOutlet UILabel *sliderValueLabel;

@property (weak, nonatomic) IBOutlet UISwitch *includeRecommendationsSwitch;

@property (weak, nonatomic) IBOutlet UIView *dateInputView;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UIButton *datePickerDoneButton;


- (IBAction)search:(id)sender;

@end
