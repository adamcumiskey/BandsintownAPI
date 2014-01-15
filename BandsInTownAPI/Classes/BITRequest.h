//
//  BITRequest.h
//  BandsInTownAPI
//
//  Created by Adam Cumiskey on 1/14/14.
//  Copyright (c) 2014 Adam Cumiskey. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BITArtist;

typedef void (^artistCompletionHandler)(BOOL success, BITArtist *artist, NSError *error);

@interface BITRequest : NSObject

+ (void)getInfoForArtist:(NSString *)artist
       completionHandler:(artistCompletionHandler)completionHandler;

+ (void)getAllShowsForArtist:(NSString *)artist;

+ (void)getUpcomingShowsForArtist:(NSString *)artist;

+ (void)getShowsForArtist:(NSString *)artist
                afterDate:(NSDate *)date;

+ (void)getShowsForArtist:(NSString *)artist
                 fromDate:(NSDate *)startDate
                   toDate:(NSString *)endDate;

@end
