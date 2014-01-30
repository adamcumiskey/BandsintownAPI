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
