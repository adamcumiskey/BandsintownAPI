//
//  BITRequest.h
//  BandsInTownAPI
//
//  Created by Adam Cumiskey on 1/14/14.
//  Copyright (c) 2014 Adam Cumiskey. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BITArtist;
@class BITDateRange;

typedef void (^artistCompletionHandler)(BOOL success, BITArtist *artist, NSError *error);
typedef void (^eventsCompletionHandler)(BOOL success, NSArray *events, NSError *error);

@interface BITRequest : NSObject

@property (strong, nonatomic) NSString *artist;
@property (strong, nonatomic) BITDateRange *dates;
@property (strong, nonatomic) NSString *location;
@property (strong, nonatomic) NSNumber *radius;
@property (strong, nonatomic) NSNumber *onlyRecs;

- (void)sendArtistRequest:(artistCompletionHandler)completionHandler;
- (void)sendEventsRequest:(eventsCompletionHandler)completionHandler;

@end
