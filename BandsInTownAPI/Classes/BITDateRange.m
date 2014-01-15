//
//  BITDateRange.m
//  BandsInTownAPI
//
//  Created by Adam Cumiskey on 1/14/14.
//  Copyright (c) 2014 Adam Cumiskey. All rights reserved.
//

#import "BITDateRange.h"

@implementation BITDateRange

#pragma mark - Public Methods
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

- (id)initWithStartDate:(NSDate *)startDate
{
    if (self = [super init]) {
        _startDate = startDate;
        _type = kDatesAfter;
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

- (NSString *)string
{
    switch (_type) {
        case kAllDates:
            return @"all";
            break;
            
        case kUpcomingDates:
            return @"upcoming";
            break;
            
        case kDatesAfter:
            return [self stringForDate:_startDate];
            break;
            
        case kDatesInRange:
            return [NSString stringWithFormat:@"%@,%@",
                    [self stringForDate:_startDate],
                    [self stringForDate:_endDate]];
            break;
            
        default:
            return nil;
            break;
    }
}

#pragma mark - Private Methods
- (NSString *)stringForDate:(NSDate *)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-mm-dd"];
    
    return [dateFormatter stringFromDate:date];
}

@end
