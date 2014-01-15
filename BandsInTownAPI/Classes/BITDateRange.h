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

@property (nonatomic) BITDateRangeType type;
@property (nonatomic, strong) NSDate *startDate;
@property (nonatomic, strong) NSDate *endDate;

- (id)initWithStartDate:(NSDate *)endDate;

- (id)initWithStartDate:(NSDate *)startDate
             andEndDate:(NSDate *)endDate;

- (id)initForUpcomingEvents;

- (id)initForAllEvents;

- (NSString *)dateRangeString;

@end
