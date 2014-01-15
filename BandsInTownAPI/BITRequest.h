//
//  BITRequest.h
//  BandsInTownAPI
//
//  Created by Adam Cumiskey on 1/14/14.
//  Copyright (c) 2014 Adam Cumiskey. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, BITAritstIDType) {
    kArtistName,
    kMusicBrainzID,
    kFacebookID
};

@interface BITRequest : NSObject

+ (void)getInfoForArtist:(NSString *)artist
                  idType:(BITAritstIDType)idType;

+ (void)getAllShowsForArtist:(NSString *)artist
                      idType:(BITAritstIDType)idType;

+ (void)getUpcomingShowsForArtist:(NSString *)artist
                           idType:(BITAritstIDType)idType;

+ (void)getShowsForArtist:(NSString *)artist
                   idType:(BITAritstIDType)idType
                afterDate:(NSDate *)date;

+ (void)getShowsForArtist:(NSString *)artist
                   idType:(BITAritstIDType)idType
                 fromDate:(NSDate *)startDate
                   toDate:(NSString *)endDate;

@end
