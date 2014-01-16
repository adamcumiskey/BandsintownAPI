//
//  BITArtistViewController.h
//  BandsInTownAPI
//
//  Created by Adam Cumiskey on 1/15/14.
//  Copyright (c) 2014 Adam Cumiskey. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BITArtistViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *artistImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *upcomingShowsLabel;




- (IBAction)viewShows:(id)sender;

@end
