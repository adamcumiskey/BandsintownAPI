/*
 * All rights reserved. This program and the accompanying materials
 * are made available under the terms of the GNU Lesser General Public License
 * (LGPL) version 2.1 which accompanies this distribution, and is available at
 * http://www.gnu.org/licenses/lgpl-2.1.html
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
 * Lesser General Public License for more details.
 *
 */

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

#pragma mark - Public Init Methods
- (id)initWithStartDate:(NSDate *)startDate
{
    if (self = [super init]) {
        if (startDate) {
            _startDate = startDate;
            _type = kDatesAfter;
        } else {
            _type = kAllDates;
        }
    }
    return self;
}

- (id)initWithStartDate:(NSDate *)startDate
             andEndDate:(NSDate *)endDate
{
    if (self = [super init]) {
        if (startDate && endDate) {
            _startDate = startDate;
            _endDate = endDate;
            _type = kDatesInRange;
        } else {
            _type = kAllDates;
        }
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

#pragma mark - Public class initializers
+ (instancetype)dateRangeWithStartDate:(NSDate *)startDate
{
    return [[BITDateRange alloc] initWithStartDate:startDate];
}

+ (instancetype)dateRangeWithStartDate:(NSDate *)startDate
                  andEndDate:(NSDate *)endDate
{
    return [[BITDateRange alloc] initWithStartDate:startDate
                                        andEndDate:endDate];
}

+ (instancetype)upcomingEvents
{
    return [[BITDateRange alloc] initForUpcomingEvents];
}

+ (instancetype)allEvents
{
    return [[BITDateRange alloc] initForAllEvents];
}

#pragma mark - Private Methods
- (NSString *)stringForDate:(NSDate *)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    return [dateFormatter stringFromDate:date];
}

#pragma mark - Debug
- (NSString *)description
{
	return [NSString stringWithFormat:@"BITDateRange[type = %d, \
            startDate = %@, \
            endDate = %@]",
            _type,
            _startDate,
            _endDate];
}

@end