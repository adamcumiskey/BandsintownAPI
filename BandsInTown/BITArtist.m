//
//  BITArtist.m
//  BandsInTownAPI
//
//  Created by Adam Cumiskey on 1/14/14.
//  Copyright (c) 2014 Adam Cumiskey. All rights reserved.
//

#import "BITArtist.h"

static const NSString *kArtistNameKey = @"name";
static const NSString *kArtistImageURLKey = @"image_url";
static const NSString *kArtistThumbURLKey = @"thumb_url";
static const NSString *kFacebookTourDatesURLKey = @"facebook_tour_dates_url";
static const NSString *kMusicBrainzIDKey = @"mbid";
static const NSString *kUpcomingEventsCountKey = @"upcoming_events_count";

@implementation BITArtist

- (id)initWithDictionary:(NSDictionary *)dictonary
{
    if (self = [super init]) {
        _name = [dictonary objectForKey:kArtistNameKey];
        _mbid = [dictonary objectForKey:kMusicBrainzIDKey];
        _imageURL = [dictonary objectForKey:kArtistImageURLKey];
        _thumbURL = [dictonary objectForKey:kArtistThumbURLKey];
        _facebookTourDatesURL = [dictonary objectForKey:kFacebookTourDatesURLKey];
        _numberOfUpcomingEvents = [dictonary objectForKey:kUpcomingEventsCountKey];
    }

    return self;
}

- (void)requestImageWithCompletionHandler:(artistImageCompletionHandler)completionHandler
{
    NSURLRequest *artistImageRequest = [NSURLRequest requestWithURL:_imageURL];
    [NSURLConnection sendAsynchronousRequest:artistImageRequest
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response,
                                               NSData *data,
                                               NSError *connectionError) {
                               if (!connectionError) {
                                   UIImage *artistImage = [UIImage imageWithData:data];
                                   completionHandler(YES, artistImage, nil);
                               } else {
                                   completionHandler(NO, nil, connectionError);
                               }
                           }];
}

@end
