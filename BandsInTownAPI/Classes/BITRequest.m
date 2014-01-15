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

#import "BITArtist.h"

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
    }
    
    request = [NSURLRequest requestWithURL:[NSURL URLWithString:requestString]];
    return request;
}

#pragma mark - Private Methods
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

/** Parse NSData object from response into BITArtist object */
// Params: NSData
// Return: BITArtist
- (BITArtist *)artistFromData:(NSData *)data
{
    NSDictionary *jsonDictionary = [data objectFromJSONData];
    if (jsonDictionary && (id)jsonDictionary != [NSNull null]) {
        BITArtist *artist = [[BITArtist alloc] initWithDictionary:jsonDictionary];
        return artist;
    } else {
        return nil;
    }
}

/** Parse NSData object from response into array of BITEvent objects */
// Params: NSData
// Return: NSArray
- (NSArray *)eventsFromData:(NSData *)data
{
    NSDictionary *jsonDictionary = [data objectFromJSONData];
    if (jsonDictionary && (id)jsonDictionary != [NSNull null]) {
    }
    return nil;
}

/** Assert that the developer has provided an app_id */
- (void)checkAuth
{
    NSAssert([[BITAuthManager sharedManager] isAuthorized],
             @"Your app must provide an app_id to use the BandsInTownAPI.\
             \nPlease use the [BITAuthManager provideAppName:] method in\
             [AppDelegate didFinishLaunchingWithOptions:] to provide an app_id.");
}

@end
