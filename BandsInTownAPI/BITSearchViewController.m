//
//  BITSearchViewController.m
//  BandsInTownAPI
//
//  Created by Adam Cumiskey on 1/15/14.
//  Copyright (c) 2014 Adam Cumiskey. All rights reserved.
//

#import "BITSearchViewController.h"

@interface BITSearchViewController () {
    UITapGestureRecognizer *_keyboardDismissGesture;
}

@end

@implementation BITSearchViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [self setUpRadiusSlider];
    [self setUpDatePicker];
}

- (void)viewDidAppear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidAppear)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide)
                                                 name:UIKeyboardDidHideNotification
                                               object:nil];
    _keyboardDismissGesture = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                      action:@selector(dismissInputView)];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)search:(id)sender
{
    
}

#pragma mark - Date Picker Methods
- (void)setUpDatePicker
{
    [self enableDateInputForSegmentIndex:_dateTypeSegmentedControl.selectedSegmentIndex];
    
    [_startDateTextField setInputView:_datePicker];
    [_endDateTextField setInputView:_datePicker];
    [_startDateTextField setInputAccessoryView:_datePickerDoneButton];
    [_endDateTextField setInputAccessoryView:_datePickerDoneButton];
    [_datePicker setMinimumDate:[NSDate date]];
}

- (IBAction)dateTypeValueChanged:(id)sender
{
    UISegmentedControl *segmentedControl = (UISegmentedControl *)sender;
    [self enableDateInputForSegmentIndex:segmentedControl.selectedSegmentIndex];
}

- (void)enableDateInputForSegmentIndex:(int)index;
{
    [_startDateTextField setEnabled:YES];
    [_endDateTextField setEnabled:YES];
    
    if (index == 0 || // Upcoming
        index == 1) { // All
        [_startDateTextField setEnabled:NO];
        [_endDateTextField setEnabled:NO];
    } else if (index == 2) { // Inclusive
        [_endDateTextField setEnabled:NO];
    }
}

- (IBAction)datePickerDoneButtonPressed:(id)sender
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterShortStyle];
    
    if ([_startDateTextField isFirstResponder]) {
        [_startDateTextField setText:[dateFormatter stringFromDate:_datePicker.date]];
    } else if ([_endDateTextField isFirstResponder]) {
        [_endDateTextField setText:[dateFormatter stringFromDate:_datePicker.date]];

    }
    
    [self dismissInputView];
}

#pragma mark - Slider Methods
- (void)setUpRadiusSlider
{
    [self setSliderValueLabelText];
}

- (IBAction)sliderValueChanged:(id)sender
{
    [self setSliderValueLabelText];
}

- (void)setSliderValueLabelText
{
    [_sliderValueLabel setText:[NSString stringWithFormat:@"%d miles",
                                (NSInteger)_searchRadiusSlider.value]];
}

#pragma mark - Keyboard Control
// These methods allow the keyboard to be dismissed by tapping the view
- (void)keyboardDidAppear
{
    [self.view addGestureRecognizer:_keyboardDismissGesture];
}

- (void)keyboardDidHide
{
    [self.view removeGestureRecognizer:_keyboardDismissGesture];
}

- (void)dismissInputView
{
    // Dismiss the keyboard by resigning first responder status for any text field
    for (UIView *subview in self.view.subviews) {
        if ([subview isKindOfClass:[UITextField class]]) {
            [(UITextField *)subview resignFirstResponder];
        }
    }
}

@end
