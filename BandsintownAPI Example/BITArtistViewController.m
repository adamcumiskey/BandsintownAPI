/*
 * All rights reserved. This program and the accompanying materials
 * are made available under the terms of the GNU Lesser General Public License
 * (LGPL) version 2.1 which accompanies this distribution, and is available at
 * http://www.gnu.org/licenses/lgpl-2.1.html
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
 * Lesser General Public License for more details.
 *
 */

//
//  BITArtistViewController.m
//  BandsInTownAPI
//
//  Created by Adam Cumiskey on 1/15/14.
//  Copyright (c) 2014 Adam Cumiskey. All rights reserved.
//

#import "BITArtistViewController.h"

#import "Bandsintown.h"

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
    if ([[UIApplication sharedApplication] canOpenURL:_artist.facebookTourDatesURL]) {
        [[UIApplication sharedApplication] openURL:_artist.facebookTourDatesURL];
    }
}

@end