//
//  BITDateRange.h
//  BandsInTownAPI
//
//  Created by Adam Cumiskey on 1/14/14.
//  Copyright (c) 2014 Adam Cumiskey. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, BITDateRangeType) {
    kAllDates,
    kUpcomingDates,
    kDatesAfter,
    kDatesInRange
};

@interface BITDateRange : NSObject

@property (nonatomic, readonly) BITDateRangeType type;
@property (nonatomic, strong, readonly) NSDate *startDate;
@property (nonatomic, strong, readonly) NSDate *endDate;

// Returns the string representing this date range in the request URL
- (NSString *)string;

// Class initializers
+ (id)dateRangeWithStartDate:(NSDate *)startDate;
+ (id)dateRangeWithStartDate:(NSDate *)startDate
             andEndDate:(NSDate *)endDate;
+ (id)upcomingEvents;
+ (id)allEvents;

// Instance initializers
- (id)initWithStartDate:(NSDate *)startDate;
- (id)initWithStartDate:(NSDate *)startDate
             andEndDate:(NSDate *)endDate;
- (id)initForUpcomingEvents;
- (id)initForAllEvents;

@end
