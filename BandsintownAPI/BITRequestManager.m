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
//  BITRequestManager.m
//  BandsInTownAPI
//
//  Created by Adam Cumiskey on 1/15/14.
//  Copyright (c) 2014 Adam Cumiskey. All rights reserved.
//


#import "BITRequestManager.h"

#import "BITArtist.h"
#import "BITEvent.h"
#import "BITAuthManager.h"
#import "BITRequest.h"
#import "BITResponse.h"

@implementation BITRequestManager

#pragma mark - Public Methods
+ (void)sendRequest:(BITRequest *)request
    withCompletionHandler:(requestCompletionHandler)completionHandler
{
    [self checkAuth];
    
    [NSURLConnection sendAsynchronousRequest:[request urlRequest]
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *urlResponse,
                                               NSData *data,
                                               NSError *connectionError) {
                               if (connectionError) {
                                   completionHandler(NO, nil, connectionError);
                                   
                               } else if (!urlResponse) {
                                   completionHandler(NO, nil, nil);
                                   
                               } else {
                                   NSError *jsonError = nil;
                                   NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:data
                                                                                                  options:NSJSONReadingAllowFragments
                                                                                                    error:&jsonError];
                                   if ([jsonDictionary isKindOfClass:[NSDictionary class]]) {
                                       jsonError = [self errorsForJSON:jsonDictionary];
                                   }
                                   
                                   if (!jsonError) {
                                       BITResponse *response;
                                       // If the request is for an artist, make an artist response
                                       if ([request requestType] == kBITArtistRequest) {
                                           BITArtist *artist = [self artistFromData:data];
                                           if (artist) {
                                               response = [[BITResponse alloc] initWithArtist:artist];
                                           }
                                       } else {
                                           NSArray *events = [self eventsFromData:data];
                                           if (events) {
                                               response = [[BITResponse alloc] initWithEvents:events];
                                           }
                                       }
                                       
                                       if (response) {
                                           // Add the raw json string to the response
                                           [response setRawResponse:[[NSString alloc] initWithData:data
                                                                                          encoding:NSUTF8StringEncoding]];
                                           completionHandler(YES, response, nil);
                                       }
                                   } else {
                                       completionHandler(NO, nil, jsonError);
                                   }

                               }
                           }];
}

+ (NSError *)errorsForJSON:(NSDictionary *)jsonDictionary
{
    if (jsonDictionary && (id)jsonDictionary != [NSNull null]) {
        NSArray *errors = [jsonDictionary objectForKey:@"errors"];
        if (errors) {
            NSError *error = [[NSError alloc] initWithDomain:@"BITRequestManager"
                                                        code:1
                                                    userInfo:@{NSLocalizedDescriptionKey: [errors firstObject]}];
            return error;
        }
    }
    return nil;
}

#pragma mark - Private Methods
/** Parse NSData object from response into BITArtist object */
// Params: NSData
// Return: BITArtist
+ (BITArtist *)artistFromData:(NSData *)data
{
    NSError *error = nil;
    NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:data
                                                                   options:NSJSONReadingAllowFragments
                                                                     error:&error];
    if (jsonDictionary && (id)jsonDictionary != [NSNull null] && !error) {
        BITArtist *artist = [[BITArtist alloc] initWithDictionary:jsonDictionary];
        return artist;
    } else {
        return nil;
    }
}

/** Parse NSData object from response into array of BITEvent objects */
// Params: NSData
// Return: NSArray
+ (NSArray *)eventsFromData:(NSData *)data
{
    NSError *error = nil;
    NSDictionary *jsonArray = [NSJSONSerialization JSONObjectWithData:data
                                                              options:NSJSONReadingAllowFragments
                                                                error:&error];
    if (jsonArray && (id)jsonArray != [NSNull null] && !error) {
        NSMutableArray *events = [NSMutableArray array];
        for (NSDictionary *eventDictionary in jsonArray) {
            BITEvent *event = [[BITEvent alloc] initWithDictionary:eventDictionary];
            [events addObject:event];
        }
        return [NSArray arrayWithArray:events];
    }
    return nil;
}

/** Assert that the developer has provided an app_id */
+ (void)checkAuth
{
    NSAssert([[BITAuthManager sharedManager] isAuthorized],
             @"Your app must provide an app_id to use the BandsInTownAPI.\
             \nPlease use the [BITAuthManager provideAppName:] method in\
             [AppDelegate didFinishLaunchingWithOptions:] to provide an app_id.");
}

@end
