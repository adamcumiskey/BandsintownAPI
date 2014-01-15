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

@implementation BITRequest

- (void)checkAuth
{
    NSAssert([[BITAuthManager sharedManager] isAuthorized],
             @"Your app must provide an app_id to use the BandsInTownAPI.\
             \nPlease use the [BITAuthManager provideAppName:] method in\
             [AppDelegate didFinishLaunchingWithOptions:] to provide an app_id.");
}

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

- (NSArray *)eventsFromData:(NSData *)data
{
    NSDictionary *jsonDictionary = [data objectFromJSONData];
    if (jsonDictionary && (id)jsonDictionary != [NSNull null]) {
    }
    return nil;
}

- (void)sendArtistRequest:(artistCompletionHandler)completionHandler
{
    
}

- (void)sendEventsRequest:(eventsCompletionHandler)completionHandler
{
    
}

//+ (void)getInfoForArtist:(NSString *)artist
//       completionHandler:(artistCompletionHandler)completionHandler
//{
//    [self checkAuth];
//    
//    // Add excape characters to the artist string
//    artist = [artist stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    
//    NSMutableString *requestString = [NSMutableString stringWithString:apiURL];
//    [requestString appendFormat:@"%@.json?api_version=2.0&app_id=%@", artist, [[BITAuthManager sharedManager] appName]];
//
//    NSURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:requestString]];
//    [NSURLConnection sendAsynchronousRequest:request
//                                       queue:[NSOperationQueue mainQueue]
//                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
//                               if (connectionError) {
//                                   NSLog(@"Error in [BITRequest getInfoForArtist:], %@", connectionError);
//                                   completionHandler(NO, nil, connectionError);
//                               } else if (!response) {
//                                   NSLog(@"No response from [BITRequest getInfoForArtist]");
//                                   completionHandler(NO, nil, nil);
//                               } else {
//                                   BITArtist *artist = [self artistFromData:data];
//                                   if (artist) {
//                                       completionHandler(YES, artist, nil);
//                                   } else {
//                                       completionHandler(NO, nil, nil);
//                                   }
//                               }
//                           }];
//}
//
//+ (void)getAllShowsForArtist:(NSString *)artist
//{
//    [self checkAuth];
//    
//    // Add excape characters to the artist string
//    artist = [artist stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    
//    NSMutableString *requestString = [NSMutableString stringWithString:apiURL];
//    [requestString appendFormat:@"%@/events.json?api_version=2.0&app_id=%@", artist, [[BITAuthManager sharedManager] appName]];
//}
//
//+ (void)getUpcomingShowsForArtist:(NSString *)artist
//{
//    [self checkAuth];
//}
//
//+ (void)getShowsForArtist:(NSString *)artist
//                afterDate:(NSDate *)date
//{
//    [self checkAuth];
//}
//
//+ (void)getShowsForArtist:(NSString *)artist
//                 fromDate:(NSDate *)startDate
//                   toDate:(NSString *)endDate
//{
//    [self checkAuth];
//}

@end
