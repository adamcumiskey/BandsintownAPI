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

NSString * const apiURL = @"http://api.bandsintown.com/artists/";
NSString * const apiVersion = @"2.0";

@implementation BITRequest

#pragma mark - Initializers
- (id)initWithArtist:(NSString *)artist
         requestType:(BITRequestType)requestType
           dateRange:(BITDateRange *)dateRange
            location:(BITLocation *)location
              radius:(NSNumber *)radius
            onlyRecs:(BOOL)onlyRecs
{
    if (self = [super init]) {
        _artistName = artist;
        _requestType = requestType;
        _dates = dateRange;
        _location = location;
        _radius = radius;
        _onlyRecommendations = onlyRecs;
    }
    
    return self;
}

#pragma mark - Public Methods
/** Generate the URLRequest from the object */
- (NSMutableURLRequest *)urlRequest
{
    NSMutableURLRequest *request;
    NSString *requestString;
    
    _artistName = [_artistName stringByReplacingOccurrencesOfString:@"/"
                                                         withString:@"%2F"];
    _artistName = [_artistName stringByReplacingOccurrencesOfString:@"?"
                                                         withString:@"%3F"];
    
    if ([self isArtistRequest]) {
        requestString = [apiURL stringByAppendingFormat:@"%@.json?api_version=%@&app_id=%@",
                         _artistName,
                         apiVersion,
                         [BITAuthManager appID]];
    } else {
        requestString = [apiURL stringByAppendingFormat:@"%@/events/search.json?api_version=%@&app_id=%@",
                         _artistName,
                         apiVersion,
                         [BITAuthManager appID]];
        
        if (_dates) {
            requestString = [requestString stringByAppendingFormat:@"&date=%@",
                             [_dates string]];
        }
        
        if (![_location.string isEqualToString:@""]) {
            requestString = [requestString stringByAppendingFormat:@"&location=%@",
                             [_location string]];
            
            // pre-req for radius is a valid location
            if (_radius) {
                requestString = [requestString stringByAppendingFormat:@"&radius=%@",
                                 [NSString stringWithFormat:@"%@", _radius]];
            }
        }
        
        if (_onlyRecommendations) {
            requestString = [requestString stringByAppendingString:@"&only_recs=true"];
        }
    }
    
    requestString = [requestString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSLog(@"Request String: %@", requestString);
    
    request = [NSURLRequest requestWithURL:[NSURL URLWithString:requestString]];
    return request;
}

@end