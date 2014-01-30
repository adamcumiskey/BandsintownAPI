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
    kBITDefaultRequest
};

@class BITDateRange;
@class BITLocation;
@class BITArtist;

@interface BITRequest : NSObject

@property (nonatomic) BITRequestType requestType; // Type of request to be sent out.
@property (strong, nonatomic) NSString *artistName; // Artist name as a string
@property (strong, nonatomic) NSString *mbid; // Artist's Music Brainz ID
@property (strong, nonatomic) NSString *facebookID; // Artist's FB ID
@property (strong, nonatomic) BITDateRange *dates; // Date range for event/recommendation request
@property (strong, nonatomic) BITLocation *location; // Location for event/recommendation request
@property (strong, nonatomic) NSNumber *radius; // Search radius from location
@property (nonatomic) BOOL onlyRecommendations; // If the request is for recommended shows, set to YES to filter out shows from the original artist

// Base initializer
- (id)initWithArtist:(BITArtist *)artist
         requestType:(BITRequestType)requestType
           dateRange:(BITDateRange *)dateRange
            location:(BITLocation *)location
              radius:(NSNumber *)radius
            onlyRecs:(BOOL)onlyRecs;

// Class methods for artist requests
+ (id)artistRequestForName:(NSString *)artist;
+ (id)artistRequestForFacebookID:(NSString *)facebookID;
+ (id)artistRequestForMusicBrainzID:(NSString *)mbid;

// Class methods for getting events for an artist.
+ (id)allEventsForArtist:(BITArtist *)artist;
+ (id)upcomingEventsForArtist:(BITArtist *)artist;
+ (id)eventsForArtist:(BITArtist *)artist
          inDateRange:(BITDateRange *)dateRange;

- (NSURLRequest *)urlRequest;
- (BOOL)isArtistRequest;

@end
