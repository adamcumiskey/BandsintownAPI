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

#import "BITRequest.h"
#import "BITAuthManager.h"

#import "BITDateRange.h"
#import "BITLocation.h"
#import "BITArtist.h"

NSString *const apiURLString = @"http://api.bandsintown.com/artists/";
NSString *const apiVersion = @"2.0";
NSString *const responseFormat = @"json";

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
                                  requestType:kBITEventsRequest
                                    dateRange:dateRange
                                     location:nil
                                       radius:nil];
}

+ (instancetype)upcomingEventsForArtist:(BITArtist *)artist
{
    BITDateRange *dateRange = [BITDateRange upcomingEvents];
    return [[BITRequest alloc] initWithArtist:artist
                                  requestType:kBITEventsRequest
                                    dateRange:dateRange
                                     location:nil
                                       radius:nil];
}

+ (instancetype)eventsForArtist:(BITArtist *)artist
                    inDateRange:(BITDateRange *)dateRange
{
    return [[BITRequest alloc] initWithArtist:artist
                                  requestType:kBITEventsRequest
                                    dateRange:dateRange
                                     location:nil
                                       radius:nil];
}

#pragma mark - Request customization
- (void)setSearchLocation:(BITLocation *)location
                andRadius:(NSNumber *)radius
{
    [self setLocation:location];
    [self setRadius:radius];
}

- (void)includeRecommendationsExludingArtist:(BOOL)exludeArtistFromResults
{
    [self setRequestType:kBITRecommendationRequest];
    [self setOnlyRecommendations:exludeArtistFromResults];
}

- (void)setDates:(BITDateRange *)dates
{
    _dates = dates;
    
    // Setting the dates object to an artist search changes
    // it into a events request. Not sure I want to keep this
    // behaviour.
    if (_requestType == kBITArtistRequest) {
        [self setRequestType:kBITEventsRequest];
    }
}

- (void)setLocation:(BITLocation *)location
{
    _location = location;
    
    // If a location is set, the request must be an
    // events search or a recommendation request.
    if ((_requestType == kBITEventsRequest ||
        _requestType == kBITArtistRequest) &&
        _requestType != kBITRecommendationRequest) {
        [self setRequestType:kBITEventSearch];
    }
}

#pragma mark - Public Methods
- (NSURLRequest *)urlRequest
{
    switch ([self requestType]) {
        case kBITArtistRequest:
            return [self aritstRequestURL];
            break;
            
        case kBITEventsRequest:
            return [self eventsRequestURL];
            break;
            
        case kBITEventSearch:
            return [self eventSearchURL];
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
    NSString *requestString = [NSString stringWithString:apiURLString];
    switch ([[self artist] artistNameType]) {
        case kBITArtistNameTypeString:
            requestString = [requestString stringByAppendingFormat:@"%@.json?%@%@",
                             [self artistNameString],
                             [self apiVersionString],
                             [self appIDString]];
            break;
            
        case kBITArtistNameTypeMusicBrainzID:
            requestString = [requestString stringByAppendingFormat:@"%@?%@&%@%@",
                             [_artist mbid],
                             [self formatString],
                             [self apiVersionString],
                             [self appIDString]];
            break;
            
        case kBITArtistNameTypeFacebookID:
            requestString = [requestString stringByAppendingFormat:@"%@?%@&%@%@",
             [_artist fbid],
             [self formatString],
             [self apiVersionString],
             [self appIDString]];
            break;
            
        default:
            break;
    }
    
    return [self urlRequestFromString:requestString];
}

- (NSURLRequest *)eventsRequestURL
{
    NSString *requestString = [NSString stringWithString:apiURLString];
    requestString = [requestString stringByAppendingFormat:@"%@/events.%@?%@%@%@",
                     [self artistNameString],
                     responseFormat,
                     [self apiVersionString],
                     [self appIDString],
                     [self dateString]];
    
    return [self urlRequestFromString:requestString];
}

- (NSURLRequest *)eventSearchURL
{
    NSString *requestString = [NSString stringWithString:apiURLString];
    requestString = [requestString stringByAppendingFormat:@"%@/events/search.%@?%@%@%@%@%@",
                     [self artistNameString],
                     responseFormat,
                     [self apiVersionString],
                     [self appIDString],
                     [self dateString],
                     [self locationString],
                     [self radiusString]];
    
    return [self urlRequestFromString:requestString];
}

- (NSURLRequest *)recommendationRequestURL
{
    NSString *requestString = [NSString stringWithString:apiURLString];
    requestString = [requestString stringByAppendingFormat:@"%@/events/recommended.%@?%@%@%@%@%@%@",
                     [self artistNameString],
                     responseFormat,
                     [self apiVersionString],
                     [self appIDString],
                     [self dateString],
                     [self locationString],
                     [self radiusString],
                     [self onlyRecsString]];
    
    return [self urlRequestFromString:requestString];
}

#pragma mark - String Helpers (Private)
- (NSURLRequest *)urlRequestFromString:(NSString *)string
{
    string = [string stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    string = [string stringByReplacingOccurrencesOfString:@"(null)"
                                               withString:@""];
    NSLog(@"Request String: %@", string);
    return [NSURLRequest requestWithURL:[NSURL URLWithString:string]];
}

- (NSString *)sanitizeArtistNameString:(NSString *)artistName
{
    artistName = [artistName stringByReplacingOccurrencesOfString:@"/"
                                                       withString:@"%2F"];
    artistName = [artistName stringByReplacingOccurrencesOfString:@"?"
                                                       withString:@"%3F"];
    return artistName;
}

#pragma mark Required Params
// API version string should always go after the question mark
- (NSString *)apiVersionString
{
    return [NSString stringWithFormat:@"api_version=%@",
            apiVersion];
}

- (NSString *)appIDString
{
    return [NSString stringWithFormat:@"&app_id=%@",
            [BITAuthManager appID]];
}

- (NSString *)artistNameString
{
    switch ([[self artist] artistNameType]) {
        case kBITArtistNameTypeString:
            return [self sanitizeArtistNameString:_artist.name];
            break;
        
        case kBITArtistNameTypeMusicBrainzID:
            return _artist.mbid;
            break;
            
        case kBITArtistNameTypeFacebookID:
            return _artist.fbid;
            break;
            
        default:
            break;
    }
}

#pragma mark Optional Params
//Return the full param string if there is a value otherwise return an empty string
- (NSString *)locationString
{
    if (![[[self location] string] isEqualToString:@""] && _location) {
        return [NSString stringWithFormat:@"&location=%@",
                _location.string];
    } else {
        return @"";
    }
}

- (NSString *)radiusString
{
    // Radius parameter requires valid location
    if (_radius &&
        (![[[self location] string] isEqualToString:@""] && _location)) {
        return [NSString stringWithFormat:@"&radius=%@",
                _radius];
    } else {
        return @"";
    }
}

- (NSString *)dateString
{
    if (![[[self dates] string] isEqualToString:@""] && _dates) {
        return [NSString stringWithFormat:@"&date=%@",
                _dates.string];
    } else {
        return @"";
    }
}

- (NSString *)onlyRecsString
{
    NSString *only_recs;
    if (_onlyRecommendations) {
        only_recs = @"true";
    } else {
        only_recs = @"false";
    }
    
    return [NSString stringWithFormat:@"&only_recs=%@",
            only_recs];
}

// If the format string is part of the query, it should always go after the question mark
- (NSString *)formatString
{
    return [NSString stringWithFormat:@"format=%@",
            responseFormat];
}

#pragma mark - Debug
- (NSString *)description
{
	return [NSString stringWithFormat:@"BITRequest[requestType = %ld, \
            artist = %@, \
            dates = %@, \
            location = %@, \
            radius = %@, \
            onlyRecommendations = %i]",
            _requestType,
            _artist,
            _dates,
            _location,
            _radius,
            _onlyRecommendations];
}

@end