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

#pragma mark - Public Methods
/** Generate the URLRequest from the object */
- (NSMutableURLRequest *)urlRequest
{
    NSMutableURLRequest *request;
//    NSString *requestString;
//    
//    _artistName = [_artistName stringByReplacingOccurrencesOfString:@"/"
//                                                         withString:@"%2F"];
//    _artistName = [_artistName stringByReplacingOccurrencesOfString:@"?"
//                                                         withString:@"%3F"];
//    
//    if ([self isArtistRequest]) {
//        requestString = [apiURL stringByAppendingFormat:@"%@.json?api_version=%@&app_id=%@",
//                         _artistName,
//                         apiVersion,
//                         [BITAuthManager appID]];
//    } else {
//        requestString = [apiURL stringByAppendingFormat:@"%@/events/search.json?api_version=%@&app_id=%@",
//                         _artistName,
//                         apiVersion,
//                         [BITAuthManager appID]];
//        
//        if (_dates) {
//            requestString = [requestString stringByAppendingFormat:@"&date=%@",
//                             [_dates string]];
//        }
//        
//        if (![_location.string isEqualToString:@""]) {
//            requestString = [requestString stringByAppendingFormat:@"&location=%@",
//                             [_location string]];
//            
//            // pre-req for radius is a valid location
//            if (_radius) {
//                requestString = [requestString stringByAppendingFormat:@"&radius=%@",
//                                 [NSString stringWithFormat:@"%@", _radius]];
//            }
//        }
//        
//        if (_onlyRecommendations) {
//            requestString = [requestString stringByAppendingString:@"&only_recs=true"];
//        }
//    }
//    
//    requestString = [requestString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    
//    NSLog(@"Request String: %@", requestString);
//    
//    request = [NSURLRequest requestWithURL:[NSURL URLWithString:requestString]];
    return request;
}

#pragma mark - NSURLRequestConstruction methods (Private)

@end