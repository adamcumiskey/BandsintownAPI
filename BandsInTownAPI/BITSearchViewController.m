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
                                                                      action:@selector(dismissKeyboard)];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)search:(id)sender
{
    
}

#pragma mark - Slider Methods
- (void)setUpRadiusSlider
{
    [_searchRadiusSlider addTarget:self
                            action:@selector(sliderValueChanged:)
                  forControlEvents:UIControlEventValueChanged];
    [self setSliderValueLabelText];
}

- (void)sliderValueChanged:(UISlider *)slider
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

- (void)dismissKeyboard
{
    // Dismiss the keyboard by resigning first responder status for any text field
    for (UIView *subview in self.view.subviews) {
        if ([subview isKindOfClass:[UITextField class]]) {
            [(UITextField *)subview resignFirstResponder];
        }
    }
}

@end
