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
//  BITRequest.h
//  BandsInTownAPI
//
//  Created by Adam Cumiskey on 1/14/14.
//  Copyright (c) 2014 Adam Cumiskey. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, BITRequestType) {
    kBITArtistRequest,
    kBITEventRequest,
    kBITRecommendationRequest,
};

@class BITDateRange;
@class BITLocation;
@class BITArtist;

@interface BITRequest : NSObject

@property (nonatomic) BITRequestType requestType; // Type of request to be sent out.
@property (strong, nonatomic) BITArtist *artist;
@property (strong, nonatomic) BITDateRange *dates; // Date range for event/recommendation request
@property (strong, nonatomic) BITLocation *location; // Location for event/recommendation request
@property (strong, nonatomic) NSNumber *radius; // Search radius from location
@property (nonatomic) BOOL onlyRecommendations; // If the request is for recommended shows, set to YES to filter out shows from the original artist

// Base initializer
- (id)initWithRequestForArtist:(BITArtist *)artist;
- (id)initWithArtist:(BITArtist *)artist
         requestType:(BITRequestType)requestType
           dateRange:(BITDateRange *)dateRange
            location:(BITLocation *)location
              radius:(NSNumber *)radius;

// ***************************************************************************
// Class methods for artist requests

// I don't recommend modifying these requests after they are created, as they
// are designed specifically for the artist request. Changing the request type
// to anything but kBITArtistRequest will have undefined behavior.
// ***************************************************************************
+ (instancetype)artistRequestForName:(NSString *)artistName;
+ (instancetype)artistRequestForFacebookID:(NSString *)facebookID;
+ (instancetype)artistRequestForMusicBrainzID:(NSString *)mbid;

// ***************************************************************************
// Class methods for getting events for an artist.
// These requests default to events only for the artist.

// To get recommendations, set the requestType to kBITRecommendationRequest.
// The onlyRecommendations BOOL can be set to YES to filter out events for the original artist.

// The location and radius properties can also be set after the object is
// instantiated to allow for searching a perticular area.
// ***************************************************************************
+ (instancetype)allEventsForArtist:(BITArtist *)artist;
+ (instancetype)upcomingEventsForArtist:(BITArtist *)artist;
+ (instancetype)eventsForArtist:(BITArtist *)artist
                    inDateRange:(BITDateRange *)dateRange;

// Setters to make it easier to customize the request
- (void)setSearchLocation:(BITLocation *)location
                andRadius:(NSNumber *)radius;
- (void)includeRecommendations:(BOOL)exludeArtistFromResults;

// Returns the URLRequest for the current BITRequest object
- (NSURLRequest *)urlRequest;

@end