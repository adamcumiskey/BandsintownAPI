//
//  BITRequest.m
//  BandsInTownAPI
//
//  Created by Adam Cumiskey on 1/14/14.
//  Copyright (c) 2014 Adam Cumiskey. All rights reserved.
//

#import "BITRequest.h"
#import "BITAuthManager.h"

@implementation BITRequest

+ (void)checkAuth
{
    NSAssert([[BITAuthManager sharedManager] isAuthorized],
             @"Your app must provide an API key to uset the BandsInTownAPI");
}

+ (void)getInfoForArtist:(NSString *)artist
                  idType:(BITAritstIDType)idType
{
    [self checkAuth];
}

+ (void)getAllShowsForArtist:(NSString *)artist
                      idType:(BITAritstIDType)idType
{
    [self checkAuth];
}

+ (void)getUpcomingShowsForArtist:(NSString *)artist
                           idType:(BITAritstIDType)idType
{
    [self checkAuth];
}

+ (void)getShowsForArtist:(NSString *)artist
                   idType:(BITAritstIDType)idType
                afterDate:(NSDate *)date
{
    [self checkAuth];
}

+ (void)getShowsForArtist:(NSString *)artist
                   idType:(BITAritstIDType)idType
                 fromDate:(NSDate *)startDate
                   toDate:(NSString *)endDate
{
    [self checkAuth];
}

@end
