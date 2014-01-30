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
//  BITRequest.m
//  BandsInTownAPI
//
//  Created by Adam Cumiskey on 1/14/14.
//  Copyright (c) 2014 Adam Cumiskey. All rights reserved.
//

#import <JSONKit/JSONKit.h>

#import "BITRequest.h"
#import "BITAuthManager.h"

#import "BITDateRange.h"
#import "BITLocation.h"
#import "BITArtist.h"

NSString * const apiURL = @"http://api.bandsintown.com/artists/";
NSString * const apiVersion = @"2.0";

@implementation BITRequest

#pragma mark - Base Initializers
- (id)initWithRequestForArtist:(BITArtist *)artist
{
    if (self = [super init]) {
        _artist = artist;
        _requestType = kBITArtistRequest;
    }
    return self;
}

- (id)initWithArtist:(BITArtist *)artist
         requestType:(BITRequestType)requestType
           dateRange:(BITDateRange *)dateRange
            location:(BITLocation *)location
              radius:(NSNumber *)radius
{
    if (self = [super init]) {
        _artist = artist;
        _requestType = requestType;
        _dates = dateRange;
        _location = location;
        _radius = radius;
    }
    
    return self;
}

#pragma mark - Class Initializers
#pragma mark Artist Requests
+ (instancetype)artistRequestForName:(NSString *)artistName
{
    BITArtist *artist = [BITArtist artistNamed:artistName];
    return [[BITRequest alloc] initWithRequestForArtist:artist];
}

+ (instancetype)artistRequestForMusicBrainzID:(NSString *)mbid
{
    BITArtist *artist = [BITArtist artistForMusicBrainzID:mbid];
    return [[BITRequest alloc] initWithRequestForArtist:artist];
}

+ (instancetype)artistRequestForFacebookID:(NSString *)facebookID
{
    BITArtist *artist = [BITArtist artistForFacebookID:facebookID];
    return [[BITRequest alloc] initWithRequestForArtist:artist];
}

#pragma mark Event Requests
+ (instancetype)allEventsForArtist:(BITArtist *)artist
{
    BITDateRange *dateRange = [BITDateRange allEvents];
    return [[BITRequest alloc] initWithArtist:artist
                                  requestType:kBITEventRequest
                                    dateRange:dateRange
                                     location:nil
                                       radius:nil];
}

+ (instancetype)upcomingEventsForArtist:(BITArtist *)artist
{
    BITDateRange *dateRange = [BITDateRange upcomingEvents];
    return [[BITRequest alloc] initWithArtist:artist
                                  requestType:kBITEventRequest
                                    dateRange:dateRange
                                     location:nil
                                       radius:nil];
}

+ (instancetype)eventsForArtist:(BITArtist *)artist
                    inDateRange:(BITDateRange *)dateRange
{
    return [[BITRequest alloc] initWithArtist:artist
                                  requestType:kBITEventRequest
                                    dateRange:dateRange
                                     location:nil
                                       radius:nil];
}

#pragma mark - Request customization
- (void)setSearchLocation:(BITLocation *)location
                andRadius:(NSNumber *)radius
{
    _location = location;
    _radius = radius;
}

- (void)includeRecommendations:(BOOL)exludeArtistFromResults
{
    _requestType = kBITRecommendationRequest;
    _onlyRecommendations = exludeArtistFromResults;
}

#pragma mark - Public Methods
- (NSURLRequest *)urlRequest
{
    switch ([self requestType]) {
        case kBITArtistRequest:
            return [self aritstRequestURL];
            break;
            
        case kBITEventRequest:
            return [self eventRequestURL];
            break;
            
        case kBITRecommendationRequest:
            return [self recommendationRequestURL];
            break;
            
        default:
            break;
    }
}

#pragma mark - NSURLRequestConstruction methods (Private)
- (NSURLRequest *)aritstRequestURL
{
    
}

- (NSURLRequest *)eventRequestURL
{
    
}

- (NSURLRequest *)recommendationRequestURL
{
    
}

@end