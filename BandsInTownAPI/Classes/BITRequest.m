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

NSString * const apiURL = @"http://api.bandsintown.com/artists/";
NSString * const apiVersion = @"2.0";

@implementation BITRequest

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
                         appName];
    } else {
        requestString = [apiURL stringByAppendingFormat:@"%@/events.json?api_version=%@&app_name=%@",
                         _artistName,
                         apiVersion,
                         appName];
        
        if (_dates) {
            requestString = [requestString stringByAppendingFormat:@"&date=%@", [_dates string]];
        }
        
        if (_location) {
            
        }
        
        if (_radius) {
            
        }
        
        if (_onlyRecs) {
            
        }
    }
    
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
