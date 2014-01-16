//
//  BITRequest.h
//  BandsInTownAPI
//
//  Created by Adam Cumiskey on 1/14/14.
//  Copyright (c) 2014 Adam Cumiskey. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BITDateRange;
@class BITLocation;

@interface BITRequest : NSObject

@property (strong, nonatomic) NSString *artistName;
@property (strong, nonatomic) BITDateRange *dates;
@property (strong, nonatomic) BITLocation *location;
@property (strong, nonatomic) NSNumber *radius;
@property (nonatomic) BOOL onlyRecs;

+ (id)requestWithArtist:(NSString *)artist;
+ (id)requestWithArtist:(NSString *)artist
              dateRange:(BITDateRange *)dateRange
               location:(BITLocation *)location
                 radius:(NSNumber *)radius
               onlyRecs:(BOOL)onlyRecs;

- (id)initWithArtist:(NSString *)artist;
- (id)initWithArtist:(NSString *)artist
           dateRange:(BITDateRange *)dateRange
            location:(BITLocation *)location
              radius:(NSNumber *)radius
            onlyRecs:(BOOL)onlyRecs;

- (NSURLRequest *)urlRequest;
- (BOOL)isArtistRequest;

@end
