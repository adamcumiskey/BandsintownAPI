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
//  BITVenue.m
//  BandsInTownAPI
//
//  Created by Adam Cumiskey on 1/14/14.
//  Copyright (c) 2014 Adam Cumiskey. All rights reserved.
//

#import "BITVenue.h"

static const NSString *kVenueNameKey = @"name";
static const NSString *kVenueCityKey = @"city";
static const NSString *kVenueRegionKey = @"region";
static const NSString *kVenueCountryKey = @"country";
static const NSString *kVenueLatitudeKey = @"latitude";
static const NSString *kVenueLongitudeKey = @"longitude";

@implementation BITVenue

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    if (self = [super init]) {
        _name = [dictionary objectForKey:kVenueNameKey];
        _city = [dictionary objectForKey:kVenueCityKey];
        _region = [dictionary objectForKey:kVenueRegionKey];
        _country = [dictionary objectForKey:kVenueCountryKey];
        
        // Create the CLLocationCoordinate2D from the lat and lon doubles
        double lat = [[dictionary objectForKey:kVenueLatitudeKey] doubleValue];
        double lon = [[dictionary objectForKey:kVenueLongitudeKey] doubleValue];
        _coordinate = CLLocationCoordinate2DMake(lat, lon);
    }
    
    return self;
}

@end
