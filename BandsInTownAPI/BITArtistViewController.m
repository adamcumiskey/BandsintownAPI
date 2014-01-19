//
//  BITArtistViewController.m
//  BandsInTownAPI
//
//  Created by Adam Cumiskey on 1/15/14.
//  Copyright (c) 2014 Adam Cumiskey. All rights reserved.
//

#import "BITArtistViewController.h"

#import "BandsInTown.h"

@interface BITArtistViewController ()

@end

@implementation BITArtistViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    [self setViewForArtist:_artist];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setViewForArtist:(BITArtist *)artist
{
    _artist = artist;
    
    // Grab the artist's image
    [artist requestImageWithCompletionHandler:^(BOOL success,
                                                UIImage *artistImage,
                                                NSError *error) {
        if (success) {
            [_artistImageView setImage:artistImage];
        }
    }];
    
    [_nameLabel setText:artist.name];
    [_upcomingShowsLabel setText:[NSString stringWithFormat:@"%@ upcoming shows",
                                  artist.numberOfUpcomingEvents]];
}

- (IBAction)viewShows:(id)sender
{
    NSURL *facebookURL = [NSURL URLWithString:_artist.facebookTourDatesURLString];
    if ([[UIApplication sharedApplication] canOpenURL:facebookURL]) {
        [[UIApplication sharedApplication] openURL:facebookURL];
    }
}

@end
