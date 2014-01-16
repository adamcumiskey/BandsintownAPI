//
//  BITRequestManager.m
//  BandsInTownAPI
//
//  Created by Adam Cumiskey on 1/15/14.
//  Copyright (c) 2014 Adam Cumiskey. All rights reserved.
//


#import "BITRequestManager.h"
#import <JSONKit/JSONKit.h>

#import "BITArtist.h"
#import "BITAuthManager.h"

@implementation BITRequestManager

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
