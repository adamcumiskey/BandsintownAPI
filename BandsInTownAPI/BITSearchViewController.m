//
//  BITSearchViewController.m
//  BandsInTownAPI
//
//  Created by Adam Cumiskey on 1/15/14.
//  Copyright (c) 2014 Adam Cumiskey. All rights reserved.
//

#import "BITSearchViewController.h"
#import "BITArtistViewController.h"

#import "BandsInTown.h"

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
    if (![_artistTextField.text isEqualToString:@""]) {
        BITRequest *request = [BITRequest requestWithArtist:_artistTextField.text];
        [BITRequestManager sendRequest:request
                 withCompletionHandler:^(BOOL success, BITResponse *response, NSError *error) {
                     if (success) {
                         BITArtist *artist = [response artist];
                         NSLog(@"Artist: %@", artist.name);
                     } else {
                         UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                         message:error.localizedDescription
                                                                        delegate:nil
                                                               cancelButtonTitle:@"OK"
                                                               otherButtonTitles:nil, nil];
                         [alert show];
                     }
                 }];
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                        message:@"An artist is required to perform a search"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil, nil];
        [alert show];
    }
}

- (void)performSegueWithIdentifier:(NSString *)identifier
                            sender:(id)sender
{
    if ([identifier isEqualToString:@"ArtistDetailSegue"]) {
    }
}

#pragma mark - UITextField Delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self dismissInputView];
    return YES;
}

#pragma mark - Date Picker Methods
- (void)setUpDatePicker
{
    [self enableDateInputForSegmentIndex:_dateTypeSegmentedControl.selectedSegmentIndex];
    
    [_startDateTextField setInputView:_datePicker];
    [_endDateTextField setInputView:_datePicker];
    
    // Add a toolbar to the date picker
    UIToolbar *datePickerToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0,
                                                                               0,
                                                                               self.view.frame.size.width,
                                                                               44)];
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                                                target:self
                                                                                action:@selector(datePickerDoneButtonPressed)];
    [datePickerToolbar setItems:@[doneButton]];
    [_startDateTextField setInputAccessoryView:datePickerToolbar];
    [_endDateTextField setInputAccessoryView:datePickerToolbar];
    
    [_datePicker setMinimumDate:[NSDate date]];
}

- (IBAction)dateTypeValueChanged:(id)sender
{
    UISegmentedControl *segmentedControl = (UISegmentedControl *)sender;
    [self enableDateInputForSegmentIndex:segmentedControl.selectedSegmentIndex];
}

- (void)enableDateInputForSegmentIndex:(NSInteger)index;
{
    [_startDateTextField setEnabled:YES];
    [_endDateTextField setEnabled:YES];
    
    if (index == 1 || // Upcoming
        index == 2) { // All
        [_startDateTextField setText:@""];
        [_endDateTextField setText:@""];
        [_startDateTextField setEnabled:NO];
        [_endDateTextField setEnabled:NO];
    }
}

- (NSString *)stringForDate:(NSDate *)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterShortStyle];
    
    return [dateFormatter stringFromDate:date];
}

- (void)datePickerDoneButtonPressed
{
    if ([_startDateTextField isFirstResponder]) {
        [_startDateTextField setText:[self stringForDate:_datePicker.date]];
    } else if ([_endDateTextField isFirstResponder]) {
        [_endDateTextField setText:[self stringForDate:_datePicker.date]];
    }
    
    [self dismissInputView];
}

#pragma mark - Location Methods
- (IBAction)locationSettingValueChanged:(id)sender
{
    if ([_locationTypeSegmentedControl selectedSegmentIndex] == 1) {
        [_locationTextField setEnabled:NO];
    } else {
        [_locationTextField setEnabled:YES];
    }
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
                                (int)_searchRadiusSlider.value]];
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