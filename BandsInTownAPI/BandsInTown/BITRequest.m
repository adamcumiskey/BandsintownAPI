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
+ (id)requestWithArtist:(NSString *)artist
{
    return [[BITRequest alloc] initWithArtist:artist];
}

+ (id)requestWithArtist:(NSString *)artist
              dateRange:(BITDateRange *)dateRange
               location:(BITLocation *)location
                 radius:(NSNumber *)radius
               onlyRecs:(BOOL)onlyRecs
{
    return [[BITRequest alloc] initWithArtist:artist
                                    dateRange:dateRange
                                     location:location
                                       radius:radius
                                     onlyRecs:onlyRecs];
}

- (id)initWithArtist:(NSString *)artist
{
    if (self = [super init]) {
        _artistName = artist;
    }
    
    return self;
}

- (id)initWithArtist:(NSString *)artist
           dateRange:(BITDateRange *)dateRange
            location:(BITLocation *)location
              radius:(NSNumber *)radius
            onlyRecs:(BOOL)onlyRecs
{
    if (self = [super init]) {
        _artistName = artist;
        _dates = dateRange;
        _location = location;
        _radius = radius;
        _onlyRecs = onlyRecs;
    }
    
    return self;
}

#pragma mark - Public Methods
/** Generate the URLRequest from the object */
- (NSMutableURLRequest *)urlRequest
{
    NSMutableURLRequest *request;
    NSString *requestString;
    
    if ([self isArtistRequest]) {
        requestString = [apiURL stringByAppendingFormat:@"%@.json?api_version=%@&app_id=%@",
                         _artistName,
                         apiVersion,
                         [BITAuthManager appID]];
    } else {
        requestString = [apiURL stringByAppendingFormat:@"%@/events.json?api_version=%@&app_id=%@",
                         _artistName,
                         apiVersion,
                         [BITAuthManager appID]];
        
        if (_dates) {
            requestString = [requestString stringByAppendingFormat:@"&date=%@",
                             [_dates string]];
        }
        
        if (_location) {
            requestString = [requestString stringByAppendingFormat:@"&location=%@",
                             [_location string]];
        }
        
        if (_radius) {
            requestString = [requestString stringByAppendingFormat:@"&radius=%@",
                             [NSString stringWithFormat:@"%@", _radius]];
        }
        
        if (_onlyRecs) {
            requestString = [requestString stringByAppendingString:@"&only_recs=true"];
        }
    }
    
    requestString = [requestString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSLog(@"Request String: %@", requestString);
    
    request = [NSURLRequest requestWithURL:[NSURL URLWithString:requestString]];
    return request;
}

/** Checks to see if the request is for an artist only */
// Return: BOOL
- (BOOL)isArtistRequest
{
    if (!_dates &&
        !_location &&
        !_radius &&
        !_onlyRecs) {
        return YES;
    } else {
        return NO;
    }
}

@end