//
//  BITDateRange.m
//  BandsInTownAPI
//
//  Created by Adam Cumiskey on 1/14/14.
//  Copyright (c) 2014 Adam Cumiskey. All rights reserved.
//

#import "BITDateRange.h"

@implementation BITDateRange

- (id)initWithStartDate:(NSDate *)startDate
             andEndDate:(NSDate *)endDate
{
    if (self = [super init]) {
        _startDate = startDate;
        _endDate = endDate;
        _type = kDatesInRange;
    }
    return self;
}

- (id)initWithEndDate:(NSDate *)endDate
{
    if (self = [super init]) {
        _endDate = endDate;
        _type = kDatesInclusive;
    }
    return self;
}

- (id)initForUpcomingEvents
{
    if (self = [super init]) {
        _type = kUpcomingDates;
    }
    return self;
}

- (id)initForAllEvents
{
    if (self = [super init]) {
        _type = kAllDates;
    }
    return self;
}

@end
