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

#pragma mark - Public Initializers
- (id)initWithDictionary:(NSDictionary *)dictonary
{
    if (self = [super init]) {
        _name = [self sanitizedString:[dictonary objectForKey:kArtistNameKey]];
        _mbid = [self sanitizedString:[dictonary objectForKey:kMusicBrainzIDKey]];
        _imageURL = [NSURL URLWithString:[self sanitizedString:[dictonary objectForKey:kArtistImageURLKey]]];
        _thumbURL = [NSURL URLWithString:[self sanitizedString:[dictonary objectForKey:kArtistThumbURLKey]]];
        _facebookTourDatesURL = [NSURL URLWithString:[self sanitizedString:[dictonary objectForKey:kFacebookTourDatesURLKey]]];
        _numberOfUpcomingEvents = [dictonary objectForKey:kUpcomingEventsCountKey];
    }
    return self;
}

- (id)initWithName:(NSString *)name
{
    if (self = [super init]) {
        _name = name;
        _artistNameType = kBITArtistNameTypeString;
    }
    return self;
}

- (id)initWithMusicBrainzID:(NSString *)mbid
{
    if (self = [super init]) {
        _mbid = mbid;
        _artistNameType = kBITArtistNameTypeMusicBrainzID;
    }
    return self;
}

- (id)initWithFacebookID:(NSString *)fbid
{
    if (self = [super init]) {
        _fbid = fbid;
        _artistNameType = kBITArtistNameTypeFacebookID;
    }
    return self;
}

#pragma mark - Class initializers
+ (instancetype)artistNamed:(NSString *)artistName
{
    return [[BITArtist alloc] initWithName:artistName];
}

+ (instancetype)artistForMusicBrainzID:(NSString *)mbid
{
    return [[BITArtist alloc] initWithMusicBrainzID:mbid];
}

+ (instancetype)artistForFacebookID:(NSString *)fbid
{
    return [[BITArtist alloc] initWithFacebookID:fbid];
}

#pragma mark - Custom Setters
#pragma mark Used to ensure the correct nameType gets set
- (void)setName:(NSString *)name
{
    _name = name;
    _artistNameType = kBITArtistNameTypeString;
}

- (void)setMbid:(NSString *)mbid
{
    _mbid = mbid;
    _artistNameType = kBITArtistNameTypeMusicBrainzID;
}

- (void)setFbid:(NSString *)fbid
{
    _fbid = fbid;
    _artistNameType = kBITArtistNameTypeFacebookID;
}

#pragma mark - Public methods
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

#pragma mark - Private methods
// Ensures that a string from the JSON is not an instance of NSNull
- (NSString *)sanitizedString:(NSString *)string
{
    if ((id)string == [NSNull null]) {
        return nil;
    } else {
        return string;
    }
}

- (NSString *)description {
	return [NSString stringWithFormat:@"BITArtist[name = %@, mbid = %@, fbid = %@, imageURL = %@, thumbURL = %@, facebookTourDatesURL = %@]"
			, _name, _mbid, _fbid, _imageURL, _thumbURL, _facebookTourDatesURL];
}

@end
